require "crsfml"

window = SF::RenderWindow.new(
  SF.video_mode(200, 200), "Shapes",
  settings: SF.context_settings(depth: 24, antialiasing: 8)
)
window.vertical_sync_enabled = true

while window.open?
  while event = window.poll_event()
    window.close if event.type == SF::Event::Closed
  end
  
  window.clear SF::Color::Black

  # Top left
  vertex_array = SF::VertexArray.new(SF::Triangles)
  vertex_array.append SF.vertex(SF.vector2(0, 0), SF::Color::Green)
  vertex_array.append SF.vertex(SF.vector2(100, 0), SF::Color::Red)
  vertex_array.append SF.vertex(SF.vector2(0, 100), SF::Color::Blue)
  window.draw vertex_array

  # Top right
  vertices = [
      SF.vertex(SF.vector2(200, 0), SF::Color::Green),
      SF.vertex(SF.vector2(100, 0), SF::Color::Red),
      SF.vertex(SF.vector2(200, 100), SF::Color::Blue),
  ]
  window.draw vertices, SF::Triangles, SF.render_states()
  
  # Bottom left
  convex_shape = SF::ConvexShape.new(3)
  convex_shape[0] = SF.vector2(0, 200)
  convex_shape[1] = SF.vector2(100, 200)
  convex_shape[2] = SF.vector2(0, 100)
  convex_shape.fill_color = SF::Color::Green
  window.draw convex_shape
  
  # Bottom right
  class CustomShape < SF::Shape
    def point_count
      3
    end
    def get_point(i)
      case i
      when 0
        SF.vector2(100, 200)
      when 1
        SF.vector2(200, 200)
      else
        SF.vector2(200, 100)
      end
    end
  end
  custom_shape = CustomShape.new()
  custom_shape.fill_color = SF::Color::Green
  window.draw custom_shape
  
  window.display()
end
