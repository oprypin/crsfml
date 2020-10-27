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
def get_file_url_path(url : String, dir : String)
  assert url =~ github_file_url_regex
  assert $1 == github_url(dir)
  {$2, $3}
end

alias GeneratorEpoch = Int32?

def merge_upstream(dir : String, files : Enumerable(T), url : String, &generator : (T, GeneratorEpoch) -> String?) : Hash(T, String) forall T
  current_version = git_tag(dir)

  version, path = get_file_url_path(url, dir)

  contents = files.map do |file|
    {file, {"modified" => yield file, nil}}
  end.to_h

  assert Process.run("git", ["checkout", version], chdir: dir).success?
  begin
    files.each do |file|
      contents[file]["old upstream"] = yield file, 0
    end
  ensure
    assert Process.run("git", ["checkout", current_version], chdir: dir).success?
  end
  files.each do |file|
    contents[file]["new upstream"] = yield file, 1
  end

  Dir.mkdir(tmp_dir = File.tempname)
  Hash(T, String).new.tap do |result|
    Dir.cd(tmp_dir) do
      contents.each do |file, subfiles|
        file_names = subfiles.map do |(subfile, content)|
          if content
            File.write(subfile, content)
            subfile
          else
            File::NULL
          end
        end

        Process.run("git", ["merge-file", "--diff3", "-p"] + file_names, output: (io = IO::Memory.new))
        result[file] = io.to_s
      end
    end
  end
end

def merge_upstream(dir : String, file : String, &generator : -> String)
  merged = merge_upstream(dir, [file], File.open(file, &.read_line)) do |file, epoch|
    yield if epoch
    File.read(file)
  end
  File.write(file, merged[file])
end
