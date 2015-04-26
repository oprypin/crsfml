require "csfml"


mode = SF.video_mode(800, 600)
window = SF::RenderWindow.new(mode, "pɹıq ʎddılɟ")
window.vertical_sync_enabled = true

bird_texture = SF::Texture.from_file("resources/bird.png")
sz = bird_texture.size

bird = SF::Sprite.new(bird_texture)
bird.origin = SF.vector2f(sz.x / 2.0, sz.y / 2.0)
bird.scale = SF.vector2f(2.5, 2.5)
bird.position = SF.vector2f(250, 300)

speed = 0.0

while window.open?
  while event = window.poll_event()
    case event.type
    when SF::Event::Closed
      window.close()
    when SF::Event::KeyPressed
      if event.key.code == SF::Keyboard::Escape
        window.close()
      else
        speed = -9.0
      end
    end
  end
  
  speed += 0.3
  bird.move SF.vector2f(0.0, speed)
  bird.rotation = speed*8.0 < 90.0 ? speed*8.0 : 90.0
  
  window.clear SF.color(112, 197, 206)
  window.draw bird
  window.display()
end
