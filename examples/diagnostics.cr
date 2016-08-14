require "crsfml/system"
require "crsfml/window"
require "crsfml/graphics"
require "crsfml/audio"


$font = SF::Font.from_file("resources/font/Cantarell-Regular.otf")

$window = SF::RenderWindow.new(
  SF::VideoMode.new(800, 600), "Diagnostic information",
  settings: SF::ContextSettings.new(depth: 24, antialiasing: 8)
)
$window.framerate_limit = 30


abstract class View
  abstract def frame()

  def input(event : SF::Event) : Bool
    case event
    when SF::Event::KeyPressed, SF::Event::MouseButtonPressed
      return false
    end
    true
  end
end

class FullscreenModesView < View
  TITLE = "Fullscreen modes"

  def initialize
    @text = SF::Text.new("Fullscreen modes:", $font, 20)

    SF::VideoMode.fullscreen_modes.group_by { |mode|
      {mode.width, mode.height}
    }.each do |(width, height), devices|
      bpps = devices.map(&.bits_per_pixel).join('/')
      @text.string += "\n - #{width} x #{height} @ #{bpps} bpp"
    end
  end

  def frame()
    $window.draw @text
  end
end

class AudioDevicesView < View
  TITLE = "Audio devices"

  def initialize
    @text = SF::Text.new("Audio devices:", $font, 24)

    SF::SoundRecorder.available_devices.each do |device|
      @text.string += "\n - #{device}"
    end
  end

  def frame()
    $window.draw @text
  end
end

class MouseView < View
  TITLE = "Mouse"

  @wheel_delta : SF::Vector2(Float64)
  def initialize
    $window.mouse_cursor_visible = false

    @wheel_delta = SF::Vector2.new(0.0, 0.0)
  end

  def input(event)
    case event
    when SF::Event::KeyPressed
      $window.mouse_cursor_visible = true
      return false
    when SF::Event::MouseWheelScrolled
      case event.wheel
      when SF::Mouse::HorizontalWheel
        @wheel_delta.x += event.delta
      else
        @wheel_delta.y += event.delta
      end
    end
    true
  end

  def frame()
    @wheel_delta *= 0.9

    pos = $window.map_pixel_to_coords(SF::Mouse.get_position($window))

    shape = SF::CircleShape.new(15)
    shape.origin = SF.vector2(15, 15)
    shape.position = SF.vector2(pos.x, pos.y)
    shape.fill_color = SF.color(0, 200, 0)
    shape.scale SF.vector2(0.9, 1.1)
    $window.draw shape

    shape = SF::CircleShape.new(8)
    shape.origin = SF.vector2(8, 8)
    shape.fill_color = SF.color(255, 128, 0)

    {
      SF::Mouse::Left => {-0.7, -0.7},
      SF::Mouse::Right => {0.7, -0.7},
      SF::Mouse::Middle => {0, -1},
      SF::Mouse::XButton1 => {-1, 0},
      SF::Mouse::XButton2 => {1, 0},
    }.each do |btn, delta|
      if SF::Mouse.button_pressed?(btn)
        shape.position = pos + SF.vector2(20, 20) * delta
        $window.draw shape
      end
    end

    shape = SF::ConvexShape.new(3)
    shape.fill_color = SF.color(128, 0, 255)
    shape.position = pos - {0, 4}
    shape[0] = SF.vector2f(-8, 0)
    shape[1] = SF.vector2f(8, 0)
    shape[2] = SF.vector2f(0, -@wheel_delta.y*5)
    $window.draw shape
    shape[0] = SF.vector2f(0, -8)
    shape[1] = SF.vector2f(0, 8)
    shape[2] = SF.vector2f(-@wheel_delta.x*5, 0)
    $window.draw shape
  end
end

class ControllerView < View
  TITLE = "Controller"

  @js : Int32
  def initialize
    @js = (0...SF::Joystick::Count).find { |js|
      SF::Joystick.connected?(js)
    } .not_nil!
    @text = SF::Text.new(SF::Joystick.get_identification(@js).name, $font, 20)
  end

  def input(event)
    case event
    when SF::Event::KeyPressed, SF::Event::MouseButtonPressed
      return false
    end
    true
  end

  def frame()
    $window.draw @text

    scale = (($window.view.size.x + $window.view.size.y) / 70).to_i

    shape = SF::CircleShape.new(scale)
    shape.origin = {shape.radius, shape.radius}

    text = SF::Text.new("", $font, scale + 5)
    text.color = SF.color(0, 0, 0)

    button_pos = [
      {10, 2}, {12, 0}, {8, 0}, {10, -2},
      {-10, -6}, {10, -6},
      {-4, -1}, {4, -1},
      {0, 0},
      {-5, 4}, {5, 4},
    ]
    SF::Joystick.get_button_count(@js).times do |btn|
      text.string = (btn + 1).to_s
      text.origin = SF.vector2(text.local_bounds.width * 0.5 + scale/10, text.local_bounds.height * 0.85)
      pos = button_pos.at(btn) { {0, (button_pos.size - 1 - btn) * 2} }

      shape.position = $window.view.size / 2 + SF.vector2(*pos) * scale
      text.position = shape.position
      shape.fill_color = SF::Joystick.button_pressed?(@js, btn) ? SF.color(255, 128, 0) : SF.color(0, 128, 0)

      $window.draw shape
      $window.draw text if SF::Joystick.button_pressed?(@js, btn)
    end

    shape = SF::CircleShape.new(scale * 3/4)
    shape.origin = {shape.radius, shape.radius}
    shape.fill_color = SF.color(128, 0, 255)

    {
      {SF::Joystick::X, SF::Joystick::Y} => {-5, 4},
      {SF::Joystick::U, SF::Joystick::V} => {5, 4},
      {SF::Joystick::PovX, SF::Joystick::PovY} => {-10, 0},
      {nil, SF::Joystick::Z} => {-10, -8}, {nil, SF::Joystick::R} => {10, -8},
    }.each do |axes, pos|
      state = axes.map { |a| a ? SF::Joystick.get_axis_position(@js, a) / 100 : 0 }

      max = axes.all? ? 1.75 : 1.0
      shape.position = $window.view.size / 2 + (SF.vector2(*pos) + SF.vector2(*state) * max) * scale

      $window.draw shape
    end
  end
end


class Button < SF::RectangleShape
  def initialize(message, geometry)
    super({geometry.width, geometry.height})
    @text = SF::Text.new(message, $font, (geometry.height * 0.8).to_i)
    @text.position = {
      size.x / 2 - @text.local_bounds.width * 0.5,
      size.y / 2 - geometry.height * 0.5
    }
    self.position = {geometry.left, geometry.top}
    self.fill_color = SF.color(0, 128, 0)
  end

  def draw(target, states)
    super(target, states)
    states.transform *= transform
    $window.draw(@text, states)
  end
end


geometry = SF::Rect.new($window.size.x / 4, 25, width: $window.size.x / 2, height: 50)

$buttons = {} of Button => View.class
{% for cls in View.all_subclasses %}
  {% if cls.subclasses.empty? %}
    $buttons[Button.new({{cls}}::TITLE, geometry)] = {{cls}}
    geometry.top += geometry.height * 3 / 2
  {% end %}
{% end %}

version_text = SF::Text.new("SFML v#{SF::SFML_VERSION}\nCrSFML v#{SF::VERSION}", $font, 20)
version_text.origin = {0, version_text.local_bounds.height.round + 10}
version_text.position = {5, $window.size.y - 5}

$view : View? = nil

while $window.open?
  $window.clear(SF::Color::Black)

  while event = $window.poll_event()
    if event.is_a? SF::Event::Closed
      $window.close()
    end

    if (view = $view)
      if !view.input(event)
        $view = nil
      end
    else
      if event.is_a? SF::Event::MouseButtonPressed
        coord = $window.map_pixel_to_coords({event.x, event.y})

        $buttons.each do |btn, cls|
          if btn.global_bounds.contains? coord
            $view = cls.new rescue btn.fill_color = SF.color(128, 0, 0)
          end
        end
      end
    end
  end

  if (view = $view)
    view.frame()
  else
    $buttons.each_key do |btn|
      $window.draw btn
    end
    $window.draw version_text
  end

  $window.display()
end
