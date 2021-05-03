require "crsfml"

FONT = SF::Font.from_file("#{__DIR__}/resources/font/Cantarell-Regular.otf")

struct SF::Rect
  def center
    SF::Vector2.new(left + width / 2, top + height / 2)
  end
end

class Logo < SF::Transformable
  include SF::Drawable

  def initialize(message = "CrSFML")
    super()
    @text = SF::Text.new(message, FONT, 200)
    bounds = @text.local_bounds
    @text.origin = bounds.center

    @shape = SF::RectangleShape.new(SF.vector2(bounds.width * 1.2, bounds.height * 2))
    @shape.fill_color = SF.color(0, 0, 128)
    @shape.origin = @shape.size / 2
  end

  def draw(target, states)
    states.transform *= transform
    target.draw @shape, states
    target.draw @text, states
  end
end

mode = SF::VideoMode.new(800, 600)
window = SF::RenderWindow.new(mode, "Hello")
window.vertical_sync_enabled = true

logo = Logo.new()

logo.position = SF.vector2(400, 300)

clock = SF::Clock.new()

while window.open?
  while event = window.poll_event()
    case event
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
