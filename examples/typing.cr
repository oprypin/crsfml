require "csfml/graphics"

mode = CSFML::VideoMode.new(width: 800, height: 600, bits_per_pixel: 32)
window = SF::RenderWindow.new(mode, "Typing", CSFML::WindowStyle::Default, nil)

str = ""

font = SF::Font.new("resources/font/Ubuntu-R.ttf")

text = SF::Text.new()
text.string = "_"
text.font = font
text.color = SF.color(0u8, 0u8, 0u8)

while window.open
  event = SF::Event.new()
  while window.poll_event(pointerof(event))
    if event.type == CSFML::EventType::KeyPressed
      if event.key.code == CSFML::KeyCode::Escape
        window.close()
      elsif event.key.code == CSFML::KeyCode::Back
        str = str[0...-1]
      elsif event.key.code == CSFML::KeyCode::Return
        str += '\n'
      end
    elsif event.type == CSFML::EventType::TextEntered
      str += event.text.unicode if event.text.unicode >= ' '
      text.string = str + "_"
    elsif event.type == CSFML::EventType::Closed
      window.close()
    end
  end

  window.clear SF.color(255u8, 255u8, 255u8)
  window.draw_text text, nil
  window.display()
end