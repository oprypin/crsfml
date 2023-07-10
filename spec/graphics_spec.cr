require "spec"
require "../src/graphics"
require "../src/system"
require "../src/version"

describe SF::Image do
  {% if compare_versions(SF::SFML_VERSION, "2.6.0") >= 0 %}
    it "exports to memory" do
      img = SF::Image.new(5, 5, SF::Color::Red)
      buf = SF::MemoryBuffer.new
      img.save_to_memory(buf, "bmp")
      buf.to_slice.size.should eq 222
      buf.to_slice[0, 2].should eq "BM".to_slice
    end
  {% end %}
end
