require "crsfml"

class CustomShape < SF::Shape
  def initialize
    super()
    update()
  end
  def point_count : Int32
    3
  end
  def get_point(i : Int) : SF::Vector2f
    case i
    when 0
      SF.vector2f(100, 200)
    when 1
      SF.vector2f(200, 200)
    else
      SF.vector2f(200, 100)
    end
  end
end

window = SF::RenderWindow.new(
  SF::VideoMode.new(200, 200), "Shapes",
  settings: SF::ContextSettings.new(depth: 24, antialiasing: 8)
)
window.vertical_sync_enabled = true

while window.open?
  while event = window.poll_event()
    window.close if event.is_a? SF::Event::Closed
  end

  window.clear SF::Color::Black

  # Top left
  vertex_array = SF::VertexArray.new(SF::Triangles)
  vertex_array.append SF::Vertex.new({0, 0}, SF::Color::Green)
  vertex_array.append SF::Vertex.new({100, 0}, SF::Color::Red)
  vertex_array.append SF::Vertex.new({0, 100}, SF::Color::Blue)
  window.draw vertex_array

  # Top right
  vertices = [
      SF::Vertex.new({200, 0}, SF::Color::Green),
      SF::Vertex.new({100, 0}, SF::Color::Red),
      SF::Vertex.new({200, 100}, SF::Color::Blue),
  ]
  window.draw vertices, SF::Triangles

  # Bottom left
  convex_shape = SF::ConvexShape.new(3)
  convex_shape[0] = {0, 200}
  convex_shape[1] = {100, 200}
  convex_shape[2] = {0, 100}
  convex_shape.fill_color = SF::Color::Green
  window.draw convex_shape

  # Bottom right
  custom_shape = CustomShape.new()
  custom_shape.fill_color = SF::Color::Green
  window.draw custom_shape

  window.display()
end
