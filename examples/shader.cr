# Adapted from SFML Shader example
# https://github.com/LaurentGomila/SFML/blob/master/examples/shader/Shader.cpp

require "http/client"
require "csfml"


scene = rand(2)


texture = SF::Texture.from_file("resources/background.jpg")
sprite = SF::Sprite.new(texture)
px_shader = SF::Shader.from_file("resources/shaders/pixelate.frag", SF::Shader::Fragment)
px_shader.set_parameter "texture", SF::Shader::CurrentTexture


ipsum = HTTP::Client.get("http://loripsum.net/api/12/short/plaintext").body
font = SF::Font.from_file("resources/font/Ubuntu-R.ttf")
text = SF::Text.new(ipsum, font, 22)
text.position = SF.vector2f(30, 20)
text.color = SF::Color::Black
wb_shader = SF::Shader.from_file("resources/shaders/wave.vert", "resources/shaders/blur.frag")


window = SF::RenderWindow.new(SF.video_mode(800, 600), "SFML Shader", SF::Titlebar|SF::Close)
window.vertical_sync_enabled = true

clock = SF::Clock.new()
while window.open?
  while event = window.poll_event()
    case event.type
    when SF::Event::Closed
      window.close()
    when SF::Event::MouseButtonPressed, SF::Event::KeyPressed
      scene = (scene+1) % 2
    end
  end
  
  cursor = SF::Mouse.get_position(window)
  x = cursor.x .fdiv window.size.x
  y = cursor.y .fdiv window.size.y
  time = clock.elapsed_time.as_seconds
  
  case scene
  when 0
    px_shader.set_parameter "pixel_threshold", (x+y)/30.0
    
    window.draw sprite, SF.render_states(shader: px_shader)
  when 1
    wb_shader.set_parameter "wave_phase", time
    wb_shader.set_parameter "wave_amplitude", x*40, y*40
    wb_shader.set_parameter "blur_radius", (x+y)*0.008
    
    window.clear SF::Color::White
    states = SF.render_states(shader: wb_shader)
    window.draw text, states
  end
  
  window.display()
end
