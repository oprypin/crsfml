require "crsfml"


window = SF::RenderWindow.new(SF::VideoMode.new(800, 600), "Typing")

str = ""

font = SF::Font.from_file("resources/font/Ubuntu-R.ttf")

text = SF::Text.new("_", font)
text.color = SF::Color::Black


while window.open?
  while event = window.poll_event()
    case event
    when SF::Event::KeyPressed
      case event.code
      when SF::Keyboard::Escape
        window.close()
      when SF::Keyboard::BackSpace
        str = str.chop
      when SF::Keyboard::Return
        str += '\n'
      end
    when SF::Event::TextEntered
      str += event.unicode.chr if event.unicode.chr >= ' '
      text.string = str + "_"
    when SF::Event::Closed
      window.close()
    end
  end

  window.clear SF::Color::White
  window.draw text
  window.display()
end
