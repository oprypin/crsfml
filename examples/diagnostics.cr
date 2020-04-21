require "yaml"
require "crsfml"
require "crsfml/audio"
require "./text_input"


FONT = SF::Font.from_file("resources/font/Cantarell-Regular.otf")

module Color
  BLACK = SF::Color::Black
  WHITE = SF::Color::White
  GREEN = SF.color(0, 200, 0)
  ORANGE = SF.color(255, 128, 0)
  PURPLE = SF.color(128, 0, 255)
  DARK_GREEN = SF.color(0, 128, 0)
  DARK_RED = SF.color(128, 0, 0)
end

abstract class View
  def initialize(@window : SF::RenderWindow)
  end

  abstract def frame()

  # React to an event, return false to close the view
  def input(event : SF::Event) : Bool
    case event
    when SF::Event::KeyPressed, SF::Event::MouseButtonPressed
      false
    else
      true
    end
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
    when SF::Event::MouseWheelScrolled
      case event.wheel
      when SF::Mouse::HorizontalWheel
        @wheel_delta.x += event.delta
      else
        @wheel_delta.y += event.delta
      end
    else
      true
    end
  end

  def frame()
    @wheel_delta *= 0.9

    pos = @window.map_pixel_to_coords(SF::Mouse.get_position(@window))

    body = SF::CircleShape.new(15).center!
    body.scale(0.9, 1.1)
    body.position = pos
    body.fill_color = Color::GREEN
    @window.draw body

    button = SF::CircleShape.new(8).center!
    button.fill_color = Color::ORANGE
    {
      SF::Mouse::Left => {-0.7, -0.7},
      SF::Mouse::Right => {0.7, -0.7},
      SF::Mouse::Middle => {0, -1},
      SF::Mouse::XButton1 => {-1, 0},
      SF::Mouse::XButton2 => {1, 0},
    }.each do |btn, offset|
      if SF::Mouse.button_pressed?(btn)
        button.position = pos + SF.vector2(20, 20) * offset
        @window.draw button
      end
    end

    arrow = SF::ConvexShape.new(3)
    arrow.fill_color = Color::PURPLE
    arrow.position = pos - {0, 4}
    arrow[0] = {-8, 0}
    arrow[1] = {8, 0}
    arrow[2] = {0, -@wheel_delta.y*5}
    @window.draw arrow
    arrow[0] = {0, -8}
    arrow[1] = {0, 8}
    arrow[2] = {-@wheel_delta.x*5, 0}
    @window.draw arrow
  end
end

class KeyboardView < View
  TITLE = "Keyboard"

  def initialize(@window : SF::RenderWindow)
    @typing = TypingWidget.new(FONT, 30)
    @typing.color = Color::WHITE
    @typing.selection_color = Color::PURPLE

    @buttons = [] of Button
    @key_to_button = {} of SF::Keyboard::Key => Button

    @outline_thickness = 0
    rescale()
  end

  private def rescale()
    @buttons.clear

    zoom = 55.5
    scale = zoom * @window.size.x / 1280
    margin = SF.vector2f(0.1, 0.1)
    @outline_thickness = (3 ** (scale / zoom)).round.to_i

    yaml = YAML.parse(File.read("resources/keyboard-layout.yaml"))
    y = margin.y * 3
    yaml.as_a.each do |line|
      x = margin.x * 3
      line.as_a.each do |item|
        w = h = 1
        key_id = nil
        key_text = ""
        pos = SF.vector2(x, y)
        first = true

        item.as_h.each do |key, value|
          key = key.as_s
          if first
            first = false
            value = (value.raw || key).as(String)
            key_id = SF::Keyboard::Key.parse?(key)
            key_text = value.to_s.gsub("  ", "\n")
            if h == 1 && !key_text.includes?('\n')
              key_text += '\n'
            end
          else
            value = value.raw.as(Number)
            case key
              when "w"; w = value
              when "h"; h = value
              when "x"; x += value
              when "y"; y += value
              else
            end
          end
        end

        button = Button.new(
          key_text,
          size: (SF.vector2f(w, h) - margin*2) * scale,
          alignment: SF.vector2(0.0, 0.5)
        )
        button.position = ((pos + margin) * scale).round
        button.outline_thickness = @outline_thickness

        @buttons << button
        @key_to_button[key_id] = button if key_id

        x += w
      end
      y += 1
    end

    @typing.position = SF.vector2(margin.x * 3 * scale, y * scale).round
  end

  def input(event)
    case event
    when SF::Event::MouseButtonPressed
      return false if event.button.right?
    when SF::Event::KeyPressed
      return false if event.code.escape?
      @key_to_button[event.code]?.try &.outline_thickness = @outline_thickness * 2
    when SF::Event::Resized
      rescale()
    else
    end
    @typing.input(event)
    true
  end

  def frame()
    @key_to_button.each do |key, btn|
      if SF::Keyboard.key_pressed?(key)
        btn.fill_color = Color::ORANGE
        btn.text.color = Color::BLACK
      else
        btn.fill_color = Color::DARK_GREEN
        btn.text.color = Color::WHITE
      end
      btn.outline_thickness = {btn.outline_thickness * 0.9, @outline_thickness}.max
    end

    @buttons.each do |btn|
      @window.draw btn
    end
    @window.draw @typing
  end
end

class ControllerView < View
  TITLE = "Controller"

  @js : Int32

  def initialize(@window : SF::RenderWindow)
    @js = (0...SF::Joystick::Count).find { |js|
      SF::Joystick.connected?(js)
    } || raise "Couldn't detect any joystick"
    @text = SF::Text.new(SF::Joystick.get_identification(@js).name, FONT, 24)
  end

  def input(event)
    case event
    when SF::Event::KeyPressed, SF::Event::MouseButtonPressed
      false
    else
      true
    end
  end

  def frame()
    @window.draw @text

    scale = ((@window.view.size.x + @window.view.size.y) / 70).to_i

    button = SF::CircleShape.new(scale).center!

    text = SF::Text.new("", FONT, scale + 5)
    text.color = Color::BLACK

    button_pos = [
      {10, 2}, {12, 0}, {8, 0}, {10, -2},
      {-10, -6}, {10, -6},
      {-4, -1}, {4, -1},
      {0, 0},
      {-5, 4}, {5, 4},
    ]
    SF::Joystick.get_button_count(@js).times do |btn|
      text.string = (btn + 1).to_s
      text.center!
      pos = button_pos[btn]? || {0, -2 * (btn - button_pos.size + 1)}

      button.position = @window.view.size / 2 + SF.vector2(*pos) * scale
      text.position = button.position
      button.fill_color = SF::Joystick.button_pressed?(@js, btn) ? Color::ORANGE : Color::DARK_GREEN

      @window.draw button
      @window.draw text if SF::Joystick.button_pressed?(@js, btn)
    end

    hat = SF::CircleShape.new(scale * 3/4).center!
    hat.fill_color = Color::PURPLE

    {
      {SF::Joystick::X, SF::Joystick::Y} => {-5, 4},
      {SF::Joystick::U, SF::Joystick::V} => {5, 4},
      {SF::Joystick::PovX, SF::Joystick::PovY} => {-10, 0},
      {nil, SF::Joystick::Z} => {-10, -8}, {nil, SF::Joystick::R} => {10, -8},
    }.each do |axes, pos|
      state = axes.map { |a| a ? SF::Joystick.get_axis_position(@js, a) / 100 : 0 }

      max = axes.all? ? 1.75 : 1.0
      hat.position = @window.view.size / 2 + (SF.vector2(*pos) + SF.vector2(*state) * max) * scale

      @window.draw hat
    end
  end
end

class FullscreenModesView < View
  TITLE = "Fullscreen modes"

  def initialize(@window : SF::RenderWindow)
    @text = SF::Text.new("Fullscreen modes:", FONT, 24)

    @text.string = SF::VideoMode.fullscreen_modes.group_by { |mode|
      {mode.width, mode.height}
    }.map { |(width, height), devices|
      bpps = devices.map(&.bits_per_pixel).join('/')
      "- #{width} x #{height} @ #{bpps} bpp"
    }.join('\n')
  end

  def frame()
    @window.draw @text
  end
end

class AudioDevicesView < View
  TITLE = "Audio devices"

  def initialize(@window : SF::RenderWindow)
    @text = SF::Text.new("Audio devices:", FONT, 24)

    @text.string = SF::SoundRecorder.available_devices.map { |device|
      "- #{device}"
    }.join('\n')
  end

  def frame()
    @window.draw @text
  end
end


struct SF::Vector2
  def round
    SF::Vector2.new(@x.round, @y.round)
  end
end

struct SF::Rect
  def center
    SF::Vector2.new(left + width/2, top + height/2)
  end
end

class SF::Transformable
  def center!
    self.origin = local_bounds.center
    self
  end
end


class Button < SF::RectangleShape
  def initialize(string, size, alignment = SF.vector2(0.5, 0.5))
    super(size)

    line_count = string.count('\n') + 1.15
    dimension = size.to_a.min
    font_size = (1..200).bsearch { |size|
      FONT.get_line_spacing(size) * 1.1 * line_count > dimension
    } || 200

    padding = SF.vector2(3, 3)
    @text = SF::Text.new(string, FONT, font_size)
    text_size = SF.vector2(
      @text.local_bounds.width + (@text.local_bounds.left*2),
      FONT.get_line_spacing(font_size) * line_count
    )
    @text.position = (padding + (self.size - text_size - padding*2) * alignment).round

    self.fill_color = Color::DARK_GREEN
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
    @view = nil

    @buttons = {} of Button => View.class
    {% for cls in View.all_subclasses %}
      {% if cls.subclasses.empty? %}
        btn = Button.new({{cls}}::TITLE, {size.x / 2, 50}).center!
        @buttons[btn] = {{cls}}
      {% end %}
    {% end %}

    @version_text = SF::Text.new("SFML v#{SF::SFML_VERSION}\nCrSFML v#{SF::VERSION}", FONT, 20)
    rescale()

    self.framerate_limit = 60
  end

  private def rescale()
    y = 50.0
    @buttons.each_key do |btn|
      btn.position = SF.vector2(size.x / 2.0, y).round
      y += btn.size.y * 1.5
    end

    @version_text.position = SF.vector2(5, size.y - @version_text.local_bounds.height - 12).round
  end

  def run
    while open?
      clear(Color::BLACK)

      while event = poll_event()
        if event.is_a? SF::Event::Closed
          close()
        elsif event.is_a? SF::Event::Resized
          self.view = SF::View.new(SF.float_rect(0, 0, event.width, event.height))
          rescale()
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
                begin
                  @view = cls.new(self)
                rescue e
                  btn.fill_color = Color::DARK_RED
                  puts e.inspect_with_backtrace
                end
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

def main()  # Overriding the `main` of `text_input.cr`
  DiagnosticsApplication.new.run()
end
