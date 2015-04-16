require "./csfml/csfml_window_lib"

mode = CSFML::VideoMode.new(width: 800, height: 600, bits_per_pixel: 32)

window = CSFML.window_create(mode, "CSFML works!", 7u32, nil) # TODO 7 == CSFML::WindowStyle::Default

while CSFML.window_is_open(window) != 0
  while CSFML.window_poll_event(window, out event) != 0
    if event.type == CSFML::EventType::Closed
      CSFML.window_close(window)
    end
  end
  CSFML.window_display(window)
end
