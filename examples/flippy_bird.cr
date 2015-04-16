require "./csfml/csfml_window_lib"
require "./csfml/csfml_graphics_lib"

def sf_unicode(s)
  chars = s.chars
  chars << '\0'
end

mode = CSFML::VideoMode.new(width: 800, height: 600, bits_per_pixel: 32)
window = CSFML.render_window_create_unicode(mode, sf_unicode("pɹıq ʎddılɟ"), 7u32, nil) # TODO 7 == CSFML::WindowStyle::Default
CSFML.render_window_set_vertical_sync_enabled window, 1

bird_texture = CSFML.texture_create_from_file("resources/bird.png", nil)
sz = CSFML.texture_get_size bird_texture

bird = CSFML.sprite_create
CSFML.sprite_set_texture bird, bird_texture, 1
CSFML.sprite_set_origin bird, CSFML::Vector2f.new(x: sz.x / 2.0f32, y: sz.y / 2.0f32)
CSFML.sprite_set_scale bird, CSFML::Vector2f.new(x: 2.5f32, y: 2.5f32)
CSFML.sprite_set_position bird, CSFML::Vector2f.new(x: 250f32, y: 300f32)

speed = 0.0f32

while CSFML.render_window_is_open(window) != 0
  while CSFML.render_window_poll_event(window, out event) != 0
    if event.type == CSFML::EventType::Closed
      CSFML.render_window_close(window)
    elsif event.type == CSFML::EventType::KeyPressed
      if event.key.code == CSFML::KeyCode::Escape
        CSFML.render_window_close(window)
      else
        speed = -9.0f32
      end
    end
  end
  
  speed += 0.3f32
  CSFML.sprite_move bird, CSFML::Vector2f.new(x: 0.0f32, y: speed)
  CSFML.sprite_set_rotation bird, speed*8.0f32 < 90.0f32 ? speed*8.0f32 : 90.0f32
  
  CSFML.render_window_clear window, CSFML::Color.new(r: 112u8, g: 197u8, b: 206u8)
  CSFML.render_window_draw_sprite window, bird, nil
  CSFML.render_window_display window
end