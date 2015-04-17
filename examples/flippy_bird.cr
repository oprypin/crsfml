require "csfml/system"
require "csfml/window"
require "csfml/graphics"

mode = SF::VideoMode.new(width: 800, height: 600, bits_per_pixel: 32)
window = SF::RenderWindow.new(mode, "pɹıq ʎddılɟ", CSFML::WindowStyle::Default, nil)
window.vertical_sync_enabled = true

bird_texture = SF::Texture.new("resources/bird.png", nil)
sz = bird_texture.size

bird = SF::Sprite.new()
bird.set_texture bird_texture, true
bird.origin = SF::Vector2f.new(x: sz.x / 2.0f32, y: sz.y / 2.0f32)
bird.scale = SF::Vector2f.new(x: 2.5f32, y: 2.5f32)
bird.position = SF::Vector2f.new(x: 250f32, y: 300f32)

speed = 0.0f32

while window.open
  while CSFML.render_window_poll_event(window, out event) != 0
    if event.type == CSFML::EventType::Closed
      window.close()
    elsif event.type == CSFML::EventType::KeyPressed
      if event.key.code == CSFML::KeyCode::Escape
        window.close()
      else
        speed = -9.0f32
      end
    end
  end
  
  speed += 0.3f32
  bird.move CSFML::Vector2f.new(x: 0.0f32, y: speed)
  bird.rotation = speed*8.0f32 < 90.0f32 ? speed*8.0f32 : 90.0f32
  
  window.clear CSFML::Color.new(r: 112u8, g: 197u8, b: 206u8)
  window.draw_sprite bird, nil
  window.display()
end
