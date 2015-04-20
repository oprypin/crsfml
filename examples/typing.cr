require "csfml/window"
require "csfml/graphics"

mode = SF.video_mode(800, 600)
window = SF::RenderWindow.new(SF.video_mode(800, 600), "Typing")

str = ""

font = SF::Font.new("resources/font/Ubuntu-R.ttf")

text = SF::Text.new("_", font)
text.color = SF::Color_Black

while window.open
  while event = window.poll_event()
    case event.type
    when SF::Event_KeyPressed
      case event.key.code
      when SF::Keyboard_Escape
        window.close()
      when SF::Keyboard_Back
        str = str[0...-1]
      when SF::Keyboard_Return
        str += '\n'
      end
    when SF::Event_TextEntered
      str += event.text.unicode if event.text.unicode >= ' '
      text.string = str + "_"
    when SF::Event_Closed
      window.close()
    end
  end

  window.clear SF::Color_White
  window.draw text
  window.display()
end