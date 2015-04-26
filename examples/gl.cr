require "csfml"

@[Link("GL")]
lib GL
  fun viewport = glViewport(x: Int32, y: Int32, width: Int32, height: Int32)
  fun begin = glBegin(mode: UInt32)
  fun end = glEnd()
  fun color3f = glColor3f(red: Float32, green: Float32, blue: Float32)
  fun vertex2f = glVertex2f(x: Float32, y: Float32)
  TRIANGLES = 4u32
end

window = SF::RenderWindow.new(SF.video_mode(500, 500), "OpenGL")

while window.open?
  while event = window.poll_event()
    case event.type
    when SF::Event::Resized
      GL.viewport(0, 0, event.size.width, event.size.height)
    when SF::Event::Closed
      window.close()
    end
  end

  window.clear SF::Color::Black

  GL.begin GL::TRIANGLES
    GL.color3f(0.0f32, 1.0f32, 0.0f32); GL.vertex2f(-1.0f32,  1.0f32)
    GL.color3f(1.0f32, 0.5f32, 0.0f32); GL.vertex2f( 1.0f32,  0.0f32)
    GL.color3f(0.0f32, 0.5f32, 1.0f32); GL.vertex2f( 0.0f32, -1.0f32)
  GL.end

  window.display()
end
