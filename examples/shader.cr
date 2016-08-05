# Adapted from SFML Shader example
# https://github.com/LaurentGomila/SFML/blob/master/examples/shader/Shader.cpp

require "crsfml"
require "crsfml/network"

sprite = SF::Sprite.new(SF::Texture.from_file("resources/background.jpg"))
px_shader = SF::Shader.from_file("resources/shaders/pixelate.frag", SF::Shader::Fragment)
px_shader.texture SF::Shader::CurrentTexture

http = SF::Http.new("loripsum.net")
response = http.send_request(SF::Http::Request.new("/api/12/short/plaintext"))

if response.status.ok?
  ipsum = response.body
else
  ipsum = "Couldn't download sample text."
end


font = SF::Font.from_file("resources/font/Ubuntu-R.ttf")
text = SF::Text.new(ipsum, font, 22)
text.position = {30, 20}
text.color = SF::Color::Black
wb_shader = SF::Shader.from_file("resources/shaders/wave.vert", "resources/shaders/blur.frag")

window = SF::RenderWindow.new(SF::VideoMode.new(800, 600), "SFML Shader", SF::Titlebar|SF::Close)
window.vertical_sync_enabled = true

scene = rand(2)

clock = SF::Clock.new()
while window.open?
  while event = window.poll_event()
    case event
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
    px_shader.pixel_threshold (x+y)/30.0

    window.draw sprite, SF::RenderStates.new(shader: px_shader)
  when 1
    wb_shader.wave_phase time
    wb_shader.wave_amplitude x*40, y*40
    wb_shader.blur_radius (x+y)*0.008

    window.clear SF::Color::White
    window.draw text, SF::RenderStates.new(shader: wb_shader)
  end

  window.display()
end
