require "csfml/window"

mode = SF::VideoMode.new(width: 800, height: 600, bits_per_pixel: 32)

window = SF::Window.new(mode, "CSFML works!", CSFML::WindowStyle::Default, nil)

while window.open
  while CSFML.window_poll_event(window, out event) != 0
    if event.type == CSFML::EventType::Closed
      window.close()
    end
  end
  window.display()
end
