require "crsfml"

@[Link("GL")]
lib GL
  fun viewport = glViewport(x : Int32, y : Int32, width : Int32, height : Int32)
  fun begin = glBegin(mode : UInt32)
  fun end = glEnd()
  fun color3f = glColor3f(red : Float32, green : Float32, blue : Float32)
  fun vertex2f = glVertex2f(x : Float32, y : Float32)
  TRIANGLES = 4u32
end

window = SF::RenderWindow.new(SF::VideoMode.new(500, 500), "OpenGL")

while window.open?
  while event = window.poll_event()
    case event
    when SF::Event::Resized
      GL.viewport(0, 0, event.width, event.height)
    when SF::Event::Closed
      window.close()
    end
  end

  window.clear SF::Color::Black

  GL.begin GL::TRIANGLES
    GL.color3f(0.0, 1.0, 0.0); GL.vertex2f(-1.0,  1.0)
    GL.color3f(1.0, 0.5, 0.0); GL.vertex2f( 1.0,  0.0)
    GL.color3f(0.0, 0.5, 1.0); GL.vertex2f( 0.0, -1.0)
  GL.end

  window.display()
end
