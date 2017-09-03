require "crsfml"


class TypingWidget < SF::Transformable
  include SF::Drawable

  @clipboard : String? = nil

  def initialize(font : SF::Font, character_size : Int32)
    super()
    # Text used for measurements for cursor positioning
    @cur_text = SF::Text.new("", font, character_size)
    @cur_text.color = SF::Color::Black
    @selection_color = SF::Color.new(0x3d, 0xae, 0xe9)
    @lines = [make_text("")] of SF::Text
    # Cursor position: line, column
    @y = 0
    @x = 0
    # Horizontal cursor position in pixels
    @cur_pos = 0.0f32
    # Last known cursor position in pixels that coincided with the column
    @last_cur_pos = 0.0f32
    # Selection anchor position: {line, column}
    @anchor = {0, 0}
    # Horizontal position of the selection anchor in pixels
    @anchor_pos = 0.0f32
    # Clock for periodic blinking of the cursor
    @cur_clock = SF::Clock.new

    update_cursor()
  end

  property selection_color : SF::Color

  {% for attr in %w[font character_size color] %}
    {% attr = attr.id %}
    def {{attr}}
      @cur_text.{{attr}}.not_nil!
    end
    def {{attr}}=(value)
      @cur_text.{{attr}} = value
      @lines.each &.{{attr}} = value
      update_cursor()
    end
  {% end %}

  # Get the *i*th line
  private def line(i = @y) : String
    @lines[i].string
  rescue IndexError
    ""
  end

  # Replace the current line
  private def set(s : String)
    @lines[@y].string = s
  end
  # Replace the *i*th line
  private def set(i : Int, s : String)
    @lines[i].string = s
  end
  # Replace the lines in range
  private def set(r : Range, strings)
    @lines[r] = strings.map { |s| make_text(s) }
  end

  # Make a `SF::Text` with current settings (color etc.)
  private def make_text(s : String) : SF::Text
    text = @cur_text.dup
    text.string = s
    text
  end

  # Get the horizontal pixel position of the cursor corresponging to the *x*th
  # column of the current row
  private def cursor_pos(x)
    @cur_text.string = line[0...x]
    bounds = @cur_text.local_bounds
    bounds.left + bounds.width + 1
  end
  # Recalculate the horizontal pixel position of the cursor
  private def update_cursor(keep_anchor = false, reset_last = true)
    @cur_pos = cursor_pos(@x)
    @last_cur_pos = @cur_pos if reset_last
    @cur_clock.restart
    unless keep_anchor
      @anchor = {@y, @x}
      @anchor_pos = @cur_pos
    end
  end

  # Get the current selection { {start row, start col}, { finish row, finish col } }
  def selection
    a, b = [{@y, @x}, @anchor].sort!
    {a, b}
  end

  # Select a range of text
  def select_range(selection)
    @anchor, yx = selection
    @y, @x = yx
    @anchor_pos = 0.0f32
    update_cursor(true)
  end
  # Select all text
  def select_all
    select_range({ {0, 0}, {@lines.size - 1, line(-1).size} })
  end

  # Get all text
  def text : String
    @lines.map(&.string).join('\n')
  end
  # Get all text in range
  def text(range) : String
    a, b = range
    lines = [] of String
    (a[0]..b[0]).map { |y|
      line = line(y)
      line = line[0...b[1]] if y == b[0]
      line = line[a[1]..-1] if y == a[0]
      line
    }.join('\n')
  end

  # Copy the current selection to the internal clipboard
  def copy()
    a, b = selection
    return if a == b
    @clipboard = text({a, b})
  end

  # Copy and delete the current selection
  def cut()
    if copy()
      delete_selection()
      @clipboard
    end
  end

  # Replace the current selection with the text (default: internal clipboard contents)
  def paste(text = @clipboard)
    if text
      delete_selection()
      lines = text.lines
      last_line_size = lines[-1].size
      lines[0] = line[0...@x] + lines[0]
      lines[-1] = lines[-1] + line[@x..-1]
      set @y..@y, lines
      @y += lines.size - 1
      @x = 0 if lines.size > 1
      @x += last_line_size
      update_cursor()
      text
    end
  end

  # Delete the currently selected text
  private def delete_selection()
    a, b = selection
    return false if a == b
    set a[0]..b[0], [line(a[0])[0...a[1]] + line(b[0])[b[1]..-1]]
    @y, @x = a
    update_cursor()
    true
  end

  # Is text selection in process now?
  private def selecting?
    SF::Keyboard.key_pressed?(SF::Keyboard::LShift) ||
    SF::Keyboard.key_pressed?(SF::Keyboard::RShift) ||
    SF::Mouse.button_pressed?(SF::Mouse::Left)
  end

  # Move the cursor one column to the left
  def left()
    if @x > 0
      @x -= 1
    elsif @y > 0
      @y -= 1
      @x = line.size
    end
    update_cursor(selecting?)
  end
  # Move the cursor one column to the right
  def right()
    if @x < line.size
      @x += 1
    elsif @y < @lines.size - 1
      @y += 1
      @x = 0
    end
    update_cursor(selecting?)
  end
  # Move the cursor one row up (or home if already at the top)
  def up()
    if @y > 0
      go_line(@y - 1)
    else
      go_home()
    end
  end
  # Move the cursor one row down (or end if already at the bottom)
  def down()
    if @y < @lines.size - 1
      go_line(@y + 1)
    else
      go_end()
    end
  end
  # Go to the beginning of the current row
  def go_home()
    @x = 0
    update_cursor(selecting?)
  end
  # Go to the end of the current row
  def go_end()
    @x = line.size
    update_cursor(selecting?)
  end
  # Delete the currently selected text or one character ahead
  def delete()
    return if delete_selection()
    if @x < line.size
      set line.sub(@x, "")
    elsif @y < @lines.size
      set @y..@y+1, [line(@y) + line(@y+1)]
    end
    update_cursor()
  end
  # Delete the currently selected text or one character behind
  def backspace()
    return if delete_selection()
    if @x > 0 || @y > 0
      left()
      delete()
    end
  end
  # Replace the currently selected text with a newline
  def newline()
    delete_selection()
    set @y..@y, [line[0...@x], line[@x..-1]]
    right()
    update_cursor()
  end

  # Move the cursor to the position as close as possible to these coordinates
  def click(x, y)
    spacing = font.get_line_spacing(character_size)
    @last_cur_pos = x.to_f32
    go_line({0, {(y / spacing).to_i, @lines.size - 1}.min}.max)
  end

  # Go to the row *y*, preserving the current horizontal cursor position
  def go_line(@y)
    # Find the cursor position in this line that is the closest to the previous one
    results = {} of Int32 => Float32
    (0..line.size).bsearch { |x|
      (results[x] = cursor_pos(x)) >= @last_cur_pos
    }
    @x, @cur_pos = results.min_by { |(x, cur_pos)| (cur_pos - @last_cur_pos).abs }
    update_cursor(selecting?, reset_last: false)
  end

  # Handle an event
  def input(event : SF::Event)
    case event
    when SF::Event::KeyPressed
      case event.code
      when SF::Keyboard::Left
        left()
      when SF::Keyboard::Right
        right()
      when SF::Keyboard::Up
        up()
      when SF::Keyboard::Down
        down()
      when SF::Keyboard::Home
        go_home()
      when SF::Keyboard::End
        go_end()
      when SF::Keyboard::BackSpace
        backspace()
      when SF::Keyboard::Delete
        delete()
      when SF::Keyboard::Return
        newline()
      when SF::Keyboard::X
        cut() if event.control
      when SF::Keyboard::C
        copy() if event.control
      when SF::Keyboard::V
        paste() if event.control
      when SF::Keyboard::A
        select_all() if event.control
      end
    when SF::Event::TextEntered
      if event.unicode >= ' '.ord && event.unicode != 0x7f  # control chars and delete
        delete_selection()
        set line[0...@x] + event.unicode.chr + line[@x..-1]
        @x += 1
        update_cursor()
      end
    when SF::Event::MouseButtonPressed
      click(event.x - position.x, event.y - position.y)
      update_cursor()
    when SF::Event::MouseMoved
      click(event.x - position.x, event.y - position.y) if SF::Mouse.button_pressed?(SF::Mouse::Left)
    end
  end

  def draw(target, states)
    states.transform *= transform

    rect = SF::RectangleShape.new()
    spacing = font.get_line_spacing(character_size)

    a, b = [{@y, @cur_pos}, {@anchor[0], @anchor_pos}].sort!
    if a != b
      quad = SF::VertexArray.new(SF::TriangleStrip, 4)
      (a[0]..b[0]).each do |y|
        y1 = y * spacing
        y2 = y1 + spacing
        x1 = (y == a[0] ? a[1] : 0)
        x2 = (y == b[0] ? b[1] : 100000)
        quad[0] = SF::Vertex.new({x1, y1}, @selection_color)
        quad[1] = SF::Vertex.new({x1, y2}, @selection_color)
        quad[2] = SF::Vertex.new({x2, y1}, @selection_color)
        quad[3] = SF::Vertex.new({x2, y2}, @selection_color)
        target.draw quad, states
      end
    end

    @lines.each_with_index do |line, i|
      line.position = {0, spacing*i}
      target.draw line, states
    end

    states.blend_mode = SF::BlendMode.new(SF::BlendMode::OneMinusDstColor, SF::BlendMode::Zero)
    if @cur_clock.elapsed_time.as_seconds % 1.0 < 0.5
      y1 = @y * spacing
      y2 = y1 + spacing
      target.draw [
        SF::Vertex.new({@cur_pos, y1}),
        SF::Vertex.new({@cur_pos, y2}),
        SF::Vertex.new({@cur_pos + 1, y1}),
        SF::Vertex.new({@cur_pos + 1, y2})
      ], SF::Lines, states
    end
  end
end

def main()  # A hack to allow the code above to be reused: `require` and override `main`
  window = SF::RenderWindow.new(SF::VideoMode.new(800, 600), "Typing")
  text = TypingWidget.new(SF::Font.from_file("resources/font/Cantarell-Regular.otf"), 24)

  while window.open?
    while event = window.poll_event
      case event
      when SF::Event::Closed
        window.close()
      else
        text.input(event)
      end
    end
    window.clear SF::Color::White
    window.draw text
    window.display()
  end
end

main()
