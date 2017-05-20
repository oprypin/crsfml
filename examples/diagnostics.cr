require "yaml"
require "crsfml"
require "crsfml/audio"


FONT = SF::Font.from_file("resources/font/Cantarell-Regular.otf")


abstract class View
  def initialize(@window : SF::RenderWindow)
  end

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

  def initialize(@window : SF::RenderWindow)
    @text = SF::Text.new("Fullscreen modes:", FONT, 24)

    SF::VideoMode.fullscreen_modes.group_by { |mode|
      {mode.width, mode.height}
    }.each do |(width, height), devices|
      bpps = devices.map(&.bits_per_pixel).join('/')
      @text.string += "\n - #{width} x #{height} @ #{bpps} bpp"
    end
  end

  def frame()
    @window.draw @text
  end
end

class AudioDevicesView < View
  TITLE = "Audio devices"

  def initialize(@window : SF::RenderWindow)
    @text = SF::Text.new("Audio devices:", FONT, 24)

    SF::SoundRecorder.available_devices.each do |device|
      @text.string += "\n - #{device}"
    end
  end

  def frame()
    @window.draw @text
  end
end

class MouseView < View
  TITLE = "Mouse"

  def initialize(@window : SF::RenderWindow)
    @window.mouse_cursor_visible = false

    @wheel_delta = SF::Vector2(Float64).new(0.0, 0.0)
  end

  def input(event)
    case event
    when SF::Event::KeyPressed
      @window.mouse_cursor_visible = true
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

    pos = @window.map_pixel_to_coords(SF::Mouse.get_position(@window))

    shape = SF::CircleShape.new(15)
    shape.origin = SF.vector2(15, 15)
    shape.position = SF.vector2(pos.x, pos.y)
    shape.fill_color = SF.color(0, 200, 0)
    shape.scale SF.vector2(0.9, 1.1)
    @window.draw shape

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
        @window.draw shape
      end
    end

    shape = SF::ConvexShape.new(3)
    shape.fill_color = SF.color(128, 0, 255)
    shape.position = pos - {0, 4}
    shape[0] = SF.vector2f(-8, 0)
    shape[1] = SF.vector2f(8, 0)
    shape[2] = SF.vector2f(0, -@wheel_delta.y*5)
    @window.draw shape
    shape[0] = SF.vector2f(0, -8)
    shape[1] = SF.vector2f(0, 8)
    shape[2] = SF.vector2f(-@wheel_delta.x*5, 0)
    @window.draw shape
  end
end

class KeyboardView < View
  TITLE = "Keyboard"

  def initialize(@window : SF::RenderWindow)
    @buttons = [] of Button
    @key_to_button = {} of SF::Keyboard::Key => Button

    scale = 55

    yaml = YAML.parse(File.read("resources/keyboard-layout.yaml"))
    y = 0.3
    yaml.each do |line|
      x = 0.3
      line.each do |item|
        w = h = 1
        key_id = nil
        key_text = ""
        pos = {x, y}
        first = true

        item.as_h.each do |key, value|
          key = key.as String
          value = value.as String
          if first
            first = false
            value = key if value.empty?
            key_id = SF::Keyboard::Key.parse?(key)
            key_text = value.gsub("  ", "\n")
            key_text += '\n' unless key_text.includes? '\n'
          else
            value = value.to_f
            case key
              when "w"; w = value
              when "h"; h = value
              when "x"; x += value
              when "y"; y += value
            end
          end
        end

        button = Button.new(key_text,
          SF.float_rect((pos[0]+0.1)*scale, (pos[1]+0.1)*scale, (w-0.2)*scale, (h-0.2)*scale),
          alignment: SF.vector2(0.0, 0.5)
        )
        button.outline_thickness = 3

        @buttons << button
        @key_to_button[key_id] = button if key_id

        x += w
      end
      y += 1
    end

    @str = ""
    @text = SF::Text.new("_", FONT)
    @text.position = {(0.3 * scale).round, (y * scale).round}
  end

  def input(event)
    case event
    when SF::Event::MouseButtonPressed
      return false
    when SF::Event::KeyPressed
      @key_to_button[event.code]?.try &.outline_thickness = 6

      case event.code
      when SF::Keyboard::BackSpace
        @str = @str.rchop
      when SF::Keyboard::Return
        @str += '\n'
      when SF::Keyboard::Tab
        @str += '\t'
      end
    when SF::Event::TextEntered
      if event.unicode >= ' '.ord && event.unicode != 0x7f # control chars and delete
        @str += event.unicode.chr
      end
      @text.string = @str + "_"
    end
    true
  end

  def frame()
    @key_to_button.each do |key, btn|
      if SF::Keyboard.key_pressed?(key)
        btn.fill_color = SF.color(255, 128, 0)
        btn.text.color = SF.color(0, 0, 0)
      else
        btn.fill_color = SF.color(0, 128, 0)
        btn.text.color = SF.color(255, 255, 255)
      end
      btn.outline_thickness = {btn.outline_thickness * 0.9, 3}.max
    end

    @buttons.each do |btn|
      @window.draw btn
    end
    @window.draw @text
  end
end

class ControllerView < View
  TITLE = "Controller"

  @js : Int32

  def initialize(@window : SF::RenderWindow)
    @js = (0...SF::Joystick::Count).find { |js|
      SF::Joystick.connected?(js)
    } .not_nil!
    @text = SF::Text.new(SF::Joystick.get_identification(@js).name, FONT, 24)
  end

  def input(event)
    case event
    when SF::Event::KeyPressed, SF::Event::MouseButtonPressed
      return false
    end
    true
  end

  def frame()
    @window.draw @text

    scale = ((@window.view.size.x + @window.view.size.y) / 70).to_i

    shape = SF::CircleShape.new(scale)
    shape.origin = {shape.radius, shape.radius}

    text = SF::Text.new("", FONT, scale + 5)
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

      shape.position = @window.view.size / 2 + SF.vector2(*pos) * scale
      text.position = shape.position
      shape.fill_color = SF::Joystick.button_pressed?(@js, btn) ? SF.color(255, 128, 0) : SF.color(0, 128, 0)

      @window.draw shape
      @window.draw text if SF::Joystick.button_pressed?(@js, btn)
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
      shape.position = @window.view.size / 2 + (SF.vector2(*pos) + SF.vector2(*state) * max) * scale

      @window.draw shape
    end
  end
end


class Button < SF::RectangleShape
  def initialize(message, geometry, alignment = SF.vector2(0.5, 0.5))
    super({geometry.width, geometry.height})

    line_count = message.count('\n') + 1.15
    dimension = size.to_a.min
    font_size = (1..200).bsearch { |size|
      FONT.get_line_spacing(size) * 1.1 * line_count > dimension
    } || 200

    @text = SF::Text.new(message, FONT, font_size)

    self.position = {geometry.left, geometry.top}
    self.fill_color = SF.color(0, 128, 0)

    text_size = SF.vector2(
      @text.local_bounds.width,
      FONT.get_line_spacing(font_size) * line_count
    )
    @text.position = {
      (3 + (size.x - text_size.x - 6) * alignment.x + position.x.round).round - position.x,
      (3 + (size.y - text_size.y - 6) * alignment.y + position.y.round).round - position.y
    }
  end

  getter text

  def draw(target, states)
    super(target, states)
    states.transform *= transform
    target.draw(@text, states)
  end
end


class DiagnosticsApplication < SF::RenderWindow
  @view : View?

  def initialize
    super(
      SF::VideoMode.new(1280, 720), "Diagnostic information",
      settings: SF::ContextSettings.new(depth: 24, antialiasing: 8)
    )

    geometry = SF::Rect.new(size.x / 4, 25, width: size.x / 2, height: 50)

    @buttons = {} of Button => View.class
    {% for cls in View.all_subclasses %}
      {% if cls.subclasses.empty? %}
        @buttons[Button.new({{cls}}::TITLE, geometry)] = {{cls}}
        geometry.top += geometry.height * 3 / 2
      {% end %}
    {% end %}

    @version_text = SF::Text.new("SFML v#{SF::SFML_VERSION}\nCrSFML v#{SF::VERSION}", FONT, 20)
    @version_text.origin = {0, @version_text.local_bounds.height.round + 10}
    @version_text.position = {5, size.y - 5}

    @view = nil

    self.framerate_limit = 60
  end

  def run
    while open?
      clear(SF::Color::Black)

      while event = poll_event()
        if event.is_a? SF::Event::Closed
          close()
        end

        if (view = @view)
          if !view.input(event)
            @view = nil
          end
        else
          if event.is_a? SF::Event::MouseButtonPressed
            coord = map_pixel_to_coords({event.x, event.y})

            @buttons.each do |btn, cls|
              if btn.global_bounds.contains? coord
                @view = cls.new(self) rescue btn.fill_color = SF.color(128, 0, 0)
              end
            end
          end
        end
      end

      if (view = @view)
        view.frame()
      else
        @buttons.each_key do |btn|
          draw btn
        end
        draw @version_text
      end

      display()
    end
  end
end

DiagnosticsApplication.new.run()
