require "csfml/window"

mode = SF::VideoMode.new(width: 800, height: 600, bits_per_pixel: 32)

window = SF::Window.new(mode, "CSFML works!", CSFML::WindowStyle::Default, nil)

while window.open
  event = SF::Event.new()
  while window.poll_event(pointerof(event))
    if event.type == CSFML::EventType::Closed
      window.close()
    end
  end
  window.display()
end
