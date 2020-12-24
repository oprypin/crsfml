macro assert(expr)
  ({{expr}}) || raise "Assertion failed: " + {{expr.stringify}}
end

TAG_CACHE    = {} of String => String
REMOTE_CACHE = {} of String => String

# Gets the checked out tag or rev in the Git repo at *dir*.
def git_tag(dir : String) : String
  TAG_CACHE[dir] ||= assert begin
    if Process.run("git", %w[describe --tags --exact-match HEAD], chdir: dir, output: (io = IO::Memory.new)).success?
      io.to_s.strip
    elsif Process.run("git", %w[rev-parse HEAD], chdir: dir, output: (io = IO::Memory.new)).success?
      io.to_s.strip
    end
  end
end

private def github_remote_regex
  %r((\bhttps://github.com/[^/\s]+?/[^/\s]+?\b)(?:\.git\b)?)
end

# Gets the GitHub URL of the remote in the Git repo at *dir*.
def github_url(dir : String) : String
  remote = REMOTE_CACHE[dir] ||= begin
    assert Process.run("git", %w[remote get-url origin], chdir: dir, output: (io = IO::Memory.new)).success?
    io.to_s.strip
  end
  assert remote.to_s =~ /^#{github_remote_regex}$/
  $1
end

# Gets the URL to view a file on GitHub
def github_file_url(github_url : String, version : String, file : String, line : Int? = nil) : String
  "#{github_url}/blob/#{version}/#{file}" + (line ? "#L#{line}" : "")
end

# Gets the URL to view a file on GitHub (base URL inferred from the Git repo at *dir*)
def github_file_url(dir : String, file : String, line : Int? = nil) : String
  github_file_url(github_url(dir), git_tag(dir), file, line)
end

private def github_file_url_regex
  %r(#{github_remote_regex}/(?:blob|tree)/([^/\s]+?)/([^\s]+))
end

# Get the {version, path} of the original file referred to by a url, assuming *dir* is a Git repo with a matching remote
def get_file_url_path(url : String, dir : String? = nil)
  assert url =~ github_file_url_regex
  assert $1 == github_url(dir) if dir
  {$2, $3}
end

class UpstreamMerger(T)
  def initialize(@dir : String, url : String)
    @old_version, _ = get_file_url_path(url, dir)
    @new_version = git_tag(dir)
  end

  {% for kind in ["old", "new"] %}
    {% var = "@#{kind.id}_version".id %}
    {{var}} : String

    def checkout_{{kind.id}} : Nil
      assert Process.run("git", ["checkout", {{var}}], chdir: @dir).success?
    end
  {% end %}

  @contents = {} of T => Hash(Symbol, String)
  private SUBFILES = [:"modified", :"old upstream", :"new upstream"]

  {% for kind in SUBFILES %}
    def set_{{kind.split(' ')[0].id}}(file : T, content : String)
      group = @contents[file] ||= {} of Symbol => String
      assert !group[{{kind}}]?
      group[{{kind}}] = content
    end
  {% end %}

  def merge(&block : (T, String)->)
    Dir.mkdir(tmp_dir = File.tempname)
    @contents.each do |file, subfiles|
      file_names = SUBFILES.map do |subfile|
        if (content = subfiles[subfile]?)
          File.write(File.join(tmp_dir, subfile.to_s), content)
          subfile.to_s
        else
          File::NULL
        end
      end

      Process.run("git", ["merge-file", "--diff3", "-p"] + file_names, chdir: tmp_dir, output: (io = IO::Memory.new))
      result = io.to_s
      unless result.empty? && !subfiles[:"new upstream"]?
        yield file, result
      end
    end
  end
end
