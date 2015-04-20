require "csfml/window"
require "csfml/graphics"


window = SF::Window.new(SF.video_mode(800, 600), "CrSFML works!")

while window.open
  window.each_event do |event|
    if event.type == SF::Event_Closed
      window.close()
    end
  end
  window.display()
end
