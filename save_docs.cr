require "file_utils"
require "compiler/crystal/syntax"


private def parse_docs(node, docs, path = "")
  if node.is_a?(Crystal::Expressions)
    node = node.expressions
  end
  if node.is_a?(Array)
    node.each do |ex|
      parse_docs(ex, docs, path)
    end
  elsif node
    joiner = if node.is_a? Crystal::Def
      node.receiver ? "." : "#"
    else
      "::"
    end
    if (
      node.responds_to?(:name) && (name = node.name) ||
      node.responds_to?(:target) && (name = node.target)
    )
      path += joiner unless path.empty?
      path += name.to_s
      if node.is_a?(Crystal::Def)
        path += "(" + node.args.map(&.external_name).join(",") + ")"
      end
      if (doc = node.doc) && !doc.empty?
        docs[path] = doc
      end
    end
    if (
      (node.responds_to?(:body) && (node = node.body)) ||
      (node.responds_to?(:members) && (node = node.members))
    )
      parse_docs(node, docs, path)
    end
  end
end

def get_docs(file)
  src = File.read(file)
  parser = Crystal::Parser.new(src)
  parser.filename = file
  parser.wants_doc = true
  begin
    ast = parser.parse
  rescue e
    STDERR.puts e
  end

  docs = {} of String => String
  parse_docs(ast, docs)
  docs
end


Dir.glob("docs/*.diff").each do |file|
  File.delete(file)
end

current = Dir.current
tmp = `mktemp -d`.strip
Dir.cd(tmp)
require "./generate"
Dir.cd(current)

source_pairs = {} of String => Array(String)

{tmp, Dir.exists?("build") ? File.join(current, "build", "**") : File.join(current, "**")}.each_with_index do |dir, i|
  glob = File.join(dir, "src", "*", "obj.cr")
  Dir.glob(glob).each do |file|
    mod = file.split(File::SEPARATOR)[-2]
    files = (source_pairs[mod] ||= [] of String)
    files << file
    unless files.size == i + 1
      raise "duplicate or missing file for #{mod.inspect} module in #{glob.inspect}: #{files.inspect}"
    end
  end
end

Dir.cd(tmp)

source_pairs.each do |mod, files|
  Dir.mkdir("a")
  Dir.mkdir("b")

  docs_a, docs_b = files.map { |f| get_docs(f) }
  items = docs_b.keys.sort_by(&.split(/\W+/))

  items.each_with_index do |item, i|
    doc_a, doc_b = docs_a[item], docs_b[item]
    if doc_a != doc_b
      File.write(File.join("a", i.to_s), doc_a + "\n")
      File.write(File.join("b", i.to_s), doc_b + "\n")
    end
  end

  Process.run("git", %w[diff -U1 --minimal --text --no-index --no-prefix --no-renames a b]) do |pr|
    File.open(File.join(current, "docs", "#{mod}.diff"), "w") do |diff|
      pr.output.each_line(chomp: false) do |line|
        case line.chomp
        when /^(---|\+\+\+) [ab]\/(\d+)$/
          diff.puts "#{$1} #{items[$2.to_i]}"
        when /^(@@ .+? @@)/
          diff.puts $1
        when /^[\+\- ]/
          diff.print line
        else
        end
      end
    end
  end

  FileUtils.rm_r("a")
  FileUtils.rm_r("b")
end

FileUtils.rm_r(tmp)
