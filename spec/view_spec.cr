require "spec"
require "../src/graphics"

describe SF::View do
  describe "#dup" do
    it "works from a Reference (#34)" do
      w = SF::RenderTexture.new
      w.view = SF::View.new(SF.float_rect(1, 2, 3, 4))
      v = w.view.dup
      v.size.should eq SF.vector2(3, 4)
    end

    it "works as a class member (#34)" do
      v = ViewDupTest.new.view_dup
      v.size.should eq SF.vector2(3, 4)
    end
  end
end

class ViewDupTest
  def initialize
    @view = SF::View.new(SF.float_rect(1, 2, 3, 4))
  end

  def view_dup
    @view.dup
  end
end

