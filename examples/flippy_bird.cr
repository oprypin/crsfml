require "crsfml"


mode = SF::VideoMode.new(800, 600)
window = SF::RenderWindow.new(mode, "pɹıq ʎddılɟ")
window.vertical_sync_enabled = true

bird_texture = SF::Texture.from_file("resources/bird.png")
sz = bird_texture.size

bird = SF::Sprite.new(bird_texture)
bird.origin = SF.vector2(sz.x / 2.0f32, sz.y / 2.0f32)
bird.scale = SF.vector2(2.5f32, 2.5f32)
bird.position = SF.vector2(250f32, 300f32)

speed = 0.0f32

while window.open?
  while event = window.poll_event()
    case event
    when SF::Event::Closed
      window.close()
    when SF::Event::KeyPressed
      if event.code.escape?
        window.close()
      else
        speed = -9.0f32
      end
    end
  end

  speed += 0.3f32
  bird.move SF.vector2(0.0f32, speed)
  bird.rotation = speed*8.0f32 < 90.0f32 ? speed*8.0f32 : 90.0f32

  window.clear SF::Color.new(112, 197, 206)
  window.draw bird
  window.display()
end
