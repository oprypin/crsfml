# Update generated sources according to upstream.

# 1. Symlink the desired version of SFML as ./SFML/
# 2. Run `crystal tools/update.cr`
# 3. Resolve merge conflicts

require "./diff_util"
require "./serialize_docs"

assert system("crystal build generate.cr")

MODULES = %w[System Window Graphics Audio Network]

docs = MODULES.map do |mod|
  { {nil.as(GeneratorEpoch?), mod}, read_docs(mod)}
end .to_h

entries = [] of {String, String, Int32}
MODULES.each do |mod|
  docs[{nil, mod}].each do |(name, subdocs)|
    subdocs.each_index do |i|
      entries << { mod, name, i }
    end
  end
end

generated = Set{nil.as(GeneratorEpoch?)}
merged = merge_upstream("SFML", entries, File.open(module_doc_path(MODULES[0]), &.read_line)) do |(mod, name, index), epoch|
  mod_docs = (docs[{epoch, mod}] ||= begin
    if generated.add?(epoch)
      assert system("./generate --save-docs SFML/include")
    end
    read_docs(mod)
  end)
  mod_docs[name][index] rescue nil
end

out_docs = MODULES.map do |mod|
  {mod, docs[{1, mod}].keys.map do |k|
    {k, [] of String}
  end .to_h}
end .to_h

merged.each do |(mod, name, index), doc|
  out_docs[mod][name] << doc rescue nil
end

out_docs.each do |mod, mod_docs|
  write_docs(mod, mod_docs)
end

assert system("./generate SFML/include")
