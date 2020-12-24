# Update generated sources according to upstream.

# 1. Symlink the desired version of SFML as ./SFML/
# 2. Run `crystal tools/update.cr`
# 3. Resolve merge conflicts

require "./diff_util"
require "./serialize_docs"

assert system("crystal build generate.cr")

MODULES = %w[System Window Graphics Audio Network]

merger = UpstreamMerger({String, String, Int32}).new("SFML", File.open(module_doc_path(MODULES[0]), &.read_line))

macro accept_files(kind)
  MODULES.each do |mod|
    read_docs(mod).each do |(name, subdocs)|
      subdocs.each_with_index do |doc, i|
        merger.set_{{kind.id}}({mod, name, i}, doc)
      end
    end
  end
end

accept_files(:modified)

merger.checkout_old
assert system("git show HEAD:generate.cr >generate_.cr")
assert system("crystal generate_.cr --save-docs SFML/include")
accept_files(:old)
system("rm generate_.cr")

merger.checkout_new
assert system("./generate --save-docs SFML/include")
accept_files(:new)

out_docs = MODULES.to_h do |mod|
  {mod,
    Hash(String, Array(String)).new do |hash, key|
      hash[key] = Array(String).new
    end
  }
end

merger.merge do |(mod, name, index), doc|
  out_docs[mod][name] << doc
end

out_docs.each do |mod, mod_docs|
  write_docs(mod, mod_docs)
end

assert system("./generate SFML/include")
