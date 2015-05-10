require "crsfml/system"
require "crsfml/window"
require "crsfml/graphics"
require "crsfml/audio"

$font = SF::Font.from_file("resources/font/Ubuntu-R.ttf")

$window = SF::RenderWindow.new(
  SF.video_mode(800, 600), "Diagnostic information",
  settings: SF.context_settings(depth: 32, antialiasing: 8)
)
$window.framerate_limit = 30


def display_fullscreen_modes()
  text = SF::Text.new("Fullscreen modes:", $font, 20)

  SF::VideoMode.fullscreen_modes
  .group_by { |mode| {mode.width, mode.height} }
  .each do |wh, devices|
    bpps = devices.map { |device| device.bits_per_pixel } .join('/')
    text.string += "\n - #{wh[0]} x #{wh[1]} @ #{bpps} bpp"
  end

  $window.clear()
  $window.draw(text)
  $window.display()
  wait()
end

def display_audio_devices()
  text = SF::Text.new("Audio devices:", $font, 25)
  SF::SoundRecorder.available_devices.each do |device|
    text.string += "\n - #{device}"
  end

  $window.clear()
  $window.draw(text)
  $window.display()
  wait()
end

def test_mouse()
  $window.mouse_cursor_visible = false
  
  wheel_delta = 0
  while true
    while event = $window.poll_event()
      case event.type
      when SF::Event::Closed
        $window.mouse_cursor_visible = true
        return
      when SF::Event::MouseWheelMoved
        wheel_delta += event.mouse_wheel.delta
      end
    end
    wheel_delta *= 0.9
    
    $window.clear()
    m = SF::Mouse.get_position($window)
    
    shape = SF::CircleShape.new(15)
    shape.origin = SF.vector2(15, 15)
    shape.position = SF.vector2(m.x, m.y)
    shape.fill_color = SF.color(0, 200, 0)
    shape.scale SF.vector2(0.9, 1.1)
    $window.draw shape
    
    shape = SF::CircleShape.new(8)
    shape.origin = SF.vector2(8, 8)
    shape.fill_color = SF.color(255, 128, 0)
    
    buttons = {
      SF::Mouse::Left => {-0.7, -0.7}
      SF::Mouse::Right => {0.7, -0.7}
      SF::Mouse::Middle => {0, -1}
      SF::Mouse::XButton1 => {-1, 0}
      SF::Mouse::XButton2 => {1, 0}
    }
    buttons.each do |btn, delta|
      if SF::Mouse.is_button_pressed(btn)
        shape.position = m + SF.vector2(20, 20) * delta
        $window.draw shape
      end
    end
    
    shape = SF::ConvexShape.new()
    shape.point_count = 3
    shape.fill_color = SF.color(128, 0, 255)
    shape[0] = SF.vector2(-8, 0)
    shape[1] = SF.vector2(8, 0)
    shape[2] = SF.vector2(0, -wheel_delta*5)
    shape.position = m - {0, 4}
    $window.draw shape

    $window.display()
  end
end

def test_controller()
  unless js = (0...SF::Joystick::Count).find { |js| SF::Joystick.is_connected(js) }
    return
  end
  
  while true
    while event = $window.poll_event()
      case event.type
      when SF::Event::Closed
        return
      end
    end
    
    $window.clear()
    
    text = SF::Text.new(String.new(SF::Joystick.get_identification(js).name), $font, 20)
    $window.draw text
    
    shape = SF::CircleShape.new(15)
    shape.origin = SF.vector2(15, 15)

    text = SF::Text.new("", $font, 20)
    text.color = SF.color(0, 0, 0)
    
    button_pos = [
      {5 + 0, 1}
      {5 + 1, 0}
      {5 - 1, 0}
      {5 + 0, -1}
      {-5, -3}, {5, -3}
      {-2, -0.5}, {2, -0.5}
      {0, 0}
      {-2.5, 2}, {2.5, 2}
    ]
    (0...SF::Joystick.get_button_count(js)).each do |btn|
      text.string = (btn+1).to_s
      text.origin = SF.vector2(text.local_bounds.width * 0.6, text.local_bounds.height * 0.85)
      begin
        delta = button_pos[btn]
      rescue
        delta = {0, button_pos.length - btn - 1}
      end
      shape.position = SF.vector2(400, 300) + SF.vector2(delta) * {30, 30}
      text.position = shape.position
      shape.fill_color = SF::Joystick.is_button_pressed(js, btn) ? SF.color(255, 128, 0): SF.color(0, 128, 0)
      
      $window.draw shape
      $window.draw text if SF::Joystick.is_button_pressed(js, btn)
    end
    
    shape = SF::CircleShape.new(10)
    shape.origin = SF.vector2(10, 10)
    shape.fill_color = SF.color(128, 0, 255)
    
    axis_pos = [
      {-2.5, 2, :h}, {-2.5, 2, :v}
      {-5, -4.5, :v}, {5, -4.5, :v}
      {2.5, 2, :h}, {2.5, 2, :v}
      {-5, 0, :h}, {-5, 0, :v}
    ]
    axi = 0
    axis_pos.group_by { |a| {a[0], a[1]} } .each do |delta, group|
      dx = 0
      dy = 0
      any = false
      group.each do |a|
        ax = SF::JoystickAxis.new(axi)
        axi += 1
        next unless SF::Joystick.has_axis(js, ax)
        p = SF::Joystick.get_axis_position(js, ax)
        dx = p if a[2] == :h
        dy = p if a[2] == :v
        any = true
      end
      next unless any
      shape.position = SF.vector2(400, 300) + SF.vector2(delta) * {30, 30} + {dx*0.3, dy*0.3}
      
      $window.draw shape
    end
    
    $window.display()
  end
end

def wait()
  while event = $window.wait_event()
    break if [SF::Event::KeyPressed, SF::Event::MouseButtonPressed, SF::Event::JoystickButtonPressed, SF::Event::Closed].includes? event.type
  end
end


class Button < SF::RectangleShape
  include SF::TransformableM
  
  def initialize(message, width, height, color=SF.color(0, 128, 0))
    super(SF.vector2(width, height))
    @text = SF::Text.new(message, $font, (height*0.8).to_i)
    self.fill_color = color
    @text.position = SF.vector2((width - @text.global_bounds.width) / 2, -height / 20)
  end
  
  def draw(target, states: RenderStates)
    states.transform.combine(transform)
    
    super(target, states)
    target.draw(@text, states)
  end
end

w = 400
h = 50
x = 200
y = 25
actions = {
  Button.new("Mouse", w, h) => -> { test_mouse }
  Button.new("Controller", w, h) => -> { test_controller }
  Button.new("Fullscreen modes", w, h) => -> { display_fullscreen_modes }
  Button.new("Audio devices", w, h) => -> { display_audio_devices }
}

actions.each_key do |btn|
  btn.position = SF.vector2(x, y)
  y += h + h/2
end

while $window.open?
  while event = $window.poll_event()
    case event.type
    when SF::Event::Closed
      $window.close()
    when SF::Event::MouseButtonPressed
      actions.each_key do |btn|
        if btn.global_bounds.contains(event.x.to_f - btn.position.x, event.y.to_f - btn.position.y)
          actions[btn].call
          break
        end
      end
    end
  end

  $window.clear()
  actions.each_key do |btn|
    $window.draw(btn)
  end
  $window.display()
end