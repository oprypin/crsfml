require "csfml/window"
require "csfml/graphics"


window = SF::Window.new(SF.video_mode(800, 600), "CrSFML works!")

while window.open
  while event = window.poll_event()
    if event.type == SF::Event::Closed
      window.close()
    end
  end
  window.display()
end
