require "crsfml"


$font = SF::Font.from_file("resources/font/Ubuntu-R.ttf")

class Logo
  include SF::TransformableM
  
  def initialize(message="CrSFML")
    @text = SF::Text.new(message, $font, 200)
    bounds = @text.local_bounds
    @shape = SF::RectangleShape.new(SF.vector2(bounds.width*1.2, bounds.height*2))
    @shape.fill_color = SF.color(0, 0, 128)
    @shape.origin = @shape.size / 2
    @text.origin = SF.vector2(bounds.width / 2, bounds.height * 0.8)
  end
  
  def draw(target, states: SF::RenderStates)
    states.transform.combine(transform)
    target.draw(@shape, states)
    target.draw(@text, states)
  end
end

mode = SF.video_mode(800, 600)
window = SF::RenderWindow.new(mode, "Hello")
window.vertical_sync_enabled = true

logo = Logo.new()

logo.position = SF.vector2(400, 300)

clock = SF::Clock.new()

while window.open?
  while event = window.poll_event()
    case event.type
    when SF::Event::Closed
      window.close()
    end
  end
  
  t = clock.elapsed_time.as_seconds
  
  logo.rotation = t*50
  logo.scale = SF.vector2(Math.sin(t), Math.cos(t))
  
  window.clear
  window.draw logo
  window.display()
end

