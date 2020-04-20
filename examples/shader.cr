# Adapted from SFML Shader example
# https://github.com/SFML/SFML/blob/master/examples/shader/Shader.cpp

require "crsfml"
require "crsfml/network"

FONT = SF::Font.from_file("resources/font/Cantarell-Regular.otf")

def mouse_pos(window)
  cursor = SF::Mouse.get_position(window)
  {cursor.x.to_f / window.size.x, cursor.y.to_f / window.size.y}
end

class Scene1
  BACKGROUND_TEXTURE = SF::Texture.from_file("resources/background.jpg")

  def initialize
    @sprite = SF::Sprite.new(BACKGROUND_TEXTURE)
    @shader = SF::Shader.from_file("resources/shaders/pixelate.frag", SF::Shader::Fragment)
    @shader.texture SF::Shader::CurrentTexture
  end

  def draw(window)
    x, y = mouse_pos(window)
    @shader.pixel_threshold (x + y)/30.0

    window.draw @sprite, SF::RenderStates.new(shader: @shader)
  end
end

class Scene2
  def initialize
    http = SF::Http.new("loripsum.net")
    response = http.send_request(SF::Http::Request.new("/api/12/short/plaintext"))
    if response.status.ok?
      ipsum = response.body
    else
      ipsum = "Couldn't download sample text."
    end
    @text = SF::Text.new(ipsum, FONT, 22)
    @text.position = {30, 20}
    @text.color = SF::Color::Black

    @shader = SF::Shader.from_file("resources/shaders/wave.vert", "resources/shaders/blur.frag")
    @clock = SF::Clock.new
  end

  def draw(window)
    x, y = mouse_pos(window)
    time = @clock.elapsed_time.as_seconds

    @shader.wave_phase time
    @shader.wave_amplitude x * 40, y * 40
    @shader.blur_radius (x + y) * 0.008

    window.clear SF::Color::White
    window.draw @text, SF::RenderStates.new(shader: @shader)
  end
end

window = SF::RenderWindow.new(
  SF::VideoMode.new(800, 600), "SFML Shader",
  SF::Style::Titlebar | SF::Style::Close
)
window.vertical_sync_enabled = true

scenes = [Scene1, Scene2].map &.new

clock = SF::Clock.new
while window.open?
  while event = window.poll_event
    case event
    when SF::Event::Closed
      window.close
    when SF::Event::MouseButtonPressed, SF::Event::KeyPressed
      scenes.rotate!
    else
    end
  end

  scenes.first.draw(window)
  window.display
end
