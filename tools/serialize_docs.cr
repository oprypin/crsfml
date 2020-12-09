require "./diff_util"

def module_doc_path(mod)
  "#{__DIR__}/../docs/api/#{mod.downcase}.md"
end

def read_docs(mod, result = {} of String => Array(String))
  split = File.read(module_doc_path(mod)).chomp.split(/(?:^|\n\n)#+ (SF(?:#|::).+?)\n\n/)
  split.shift
  split.in_groups_of(2, "") do |(key, value)|
    (result[key] ||= [] of String) << value
  end
  result
end

def write_docs(mod, docs : Hash(String, Array(String)))
  items = docs.each_with_index.to_a.sort_by! { |(k, v), i| {k.split(/\W+/), i} } .map(&.first)

  File.open(module_doc_path(mod), "w") do |out_f|
    out_f.puts "Based on #{github_file_url("SFML", "include/SFML/#{mod.capitalize}")}"
    out_f.puts
    items.each_with_index do |(item, docs), i|
      docs.each do |doc|
        out_f.puts if i > 0
        out_f.puts "#" * (item.split(/::|#|\./).size - 1) + " #{item}"
        out_f.puts
        out_f.puts doc
      end
    end
  end
end
