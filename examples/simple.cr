require "crsfml/window"


window = SF::Window.new(SF::VideoMode.new(800, 600), "CrSFML works!")

while window.open?
  while event = window.poll_event()
    if event.is_a? SF::Event::Closed
      window.close()
    end
  end
  window.display()
end
