require "spec"
require "../src/window"

describe SF::Window do
  it "set size via tuple" do
    window = SF::Window.new(SF::VideoMode.new(640, 480), "test")
    window.size = {400, 400}
  end
end
