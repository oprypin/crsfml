require "csfml/window"
require "csfml/graphics"

window = SF::RenderWindow.new(SF.video_mode(800, 600), "Typing")

str = ""

font = SF::Font.new("resources/font/Ubuntu-R.ttf")

text = SF::Text.new("_", font)
text.color = SF::Color::Black

while window.open
  while event = window.poll_event()
    case event.type
    when SF::Event::KeyPressed
      case event.key.code
      when SF::Keyboard::Escape
        window.close()
      when SF::Keyboard::Back
        str = str[0...-1]
      when SF::Keyboard::Return
        str += '\n'
      end
    when SF::Event::TextEntered
      str += event.text.unicode if event.text.unicode >= ' '
      text.string = str + "_"
    when SF::Event::Closed
      window.close()
    end
  end

  window.clear SF::Color::White
  window.draw text
  window.display()
end