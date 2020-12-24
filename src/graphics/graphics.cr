module SF
  # Utility struct for manipulating 2D axis aligned rectangles
  #
  # A rectangle is defined by its top-left corner and its size.
  # It is a very simple struct defined for convenience, so
  # its member variables (`left`, `top`, `width` and `height`)
  # can be accessed directly, just like the vector classes
  # (`Vector2` and `Vector3`).
  #
  # To keep things simple, `SF::Rect` doesn't define
  # functions to emulate the properties that are not directly
  # members (such as right, bottom, center, etc.), it rather
  # only provides intersection functions.
  #
  # `SF::Rect` uses the usual rules for its boundaries:
  #
  # * The left and top edges are included in the rectangle's area
  # * The right (left + width) and bottom (top + height) edges are excluded from the rectangle's area
  #
  # This means that `SF::IntRect.new(0, 0, 1, 1)` and
  # `SF::IntRect.new(1, 1, 1, 1)` don't intersect.
  #
  # `SF::Rect` is a generic and may be used with any numeric type, but
  # for simplicity the instantiations used by SFML are aliased:
  #
  # * `SF::Rect(Int32)` is `SF::IntRect`
  # * `SF::Rect(Float32)` is `SF::FloatRect`
  #
  # So that you don't have to care about the template syntax.
  #
  # See also: `SF.int_rect`, `SF.float_rect`.
  #
  # Usage example:
  # ```
  # # Define a rectangle, located at (0, 0) with a size of 20x5
  # r1 = SF.int_rect(0, 0, 20, 5)
  #
  # # Define another rectangle, located at (4, 2) with a size of 18x10
  # position = SF.vector2i(4, 2)
  # size = SF.vector2i(18, 10)
  # r2 = SF::IntRect.new(position, size)
  #
  # # Test intersections with the point (3, 1)
  # r1.contains?(3, 1) #=> true
  # r2.contains?(3, 1) #=> false
  #
  # # Test the intersection between r1 and r2
  # r1.intersects?(r2) #=> (4, 2, 16, 3)
  # ```
  struct Rect(T)
    # Left coordinate of the rectangle
    property left : T
    # Top coordinate of the rectangle
    property top : T
    # Width of the rectangle
    property width : T
    # Height of the rectangle
    property height : T

    # Default constructor: equivalent to `new(0, 0, 0, 0)`
    def initialize()
      @left = @top = @width = @height = T.zero
    end
    # Construct the rectangle from its coordinates
    #
    # Be careful, the last two parameters are the width
    # and height, not the right and bottom coordinates!
    def initialize(@left : T, @top : T, @width : T, @height : T)
    end
    # Construct the rectangle from position and size
    #
    # Be careful, the last parameter is the size,
    # not the bottom-right corner!
    def initialize(position : Vector2(T), size : Vector2(T))
      @left, @top = position
      @width, @height = size
    end

    # Returns true if a point is inside the rectangle's area
    def contains?(x : Number, y : Number) : Bool
      horz = {left, left + width}
      vert = {top, top + height}
      (horz.min <= x < horz.max) && (vert.min <= y < vert.max)
    end
    # Returns true if a point is inside the rectangle's area
    def contains?(point : Vector2|Tuple) : Bool
      x, y = point
      contains?(x, y)
    end

    # Check the intersection between two rectangles
    #
    # Returns the overlapped rectangle or nil if there is no overlap.
    def intersects?(other : Rect(T)) : Rect(T)?
      horz1, horz2 = {left, left + width}, {other.left, other.left + other.width}
      vert1, vert2 = {top, top + height}, {other.top, other.top + other.height}
      x1 = {horz1.min, horz2.min}.max
      y1 = {vert1.min, vert2.min}.max
      x2 = {horz1.max, horz2.max}.min
      y2 = {vert1.max, vert2.max}.min
      Rect.new(x1, y1, x2 - x1, y2 - y1) if x1 < x2 && y1 < y2
    end

    # Returns true if all corresponding coordinates of two rects are equal
    def ==(other : self) : Bool
      left == other.left && top == other.top &&
      width == other.width && height == other.height
    end

    # :nodoc:
    def to_unsafe()
      pointerof(@left).as(Void*)
    end
  end

  alias FloatRect = Rect(Float32)
  alias IntRect = Rect(Int32)

  # Shorthand for `FloatRect.new`
  #
  # Converts arguments to `Float32`
  def float_rect(left : Number, top : Number, width : Number, height : Number)
    FloatRect.new(left.to_f32, top.to_f32, width.to_f32, height.to_f32)
  end
  # Shorthand for `IntRect.new`
  #
  # Converts arguments to `Int32`
  def int_rect(left : Int, top : Int, width : Int, height : Int)
    IntRect.new(left.to_i32, top.to_i32, width.to_i32, height.to_i32)
  end
end

require "./obj"

module SF
  struct Color
    # Black predefined color
    Black = new(0, 0, 0)
    # White predefined color
    White = new(255, 255, 255)
    # Red predefined color
    Red = new(255, 0, 0)
    # Green predefined color
    Green = new(0, 255, 0)
    # Blue predefined color
    Blue = new(0, 0, 255)
    # Yellow predefined color
    Yellow = new(255, 255, 0)
    # Magenta predefined color
    Magenta = new(255, 0, 255)
    # Cyan predefined color
    Cyan = new(0, 255, 255)
    # Transparent (black) predefined color
    Transparent = new(0, 0, 0, 0)

    def inspect(io)
      io << {{@type.name}} << "(" << @r << ", " << @g << ", " << @b
      io << ", a: " << @a if @a != 255
      io << ")"
    end
  end
  # Shorthand for `Color.new`
  def color(*args, **kwargs)
    SF::Color.new(*args, **kwargs)
  end

  struct RenderStates
    # Special instance holding the default render states
    Default = new

    def inspect(io)
      io << {{@type.name}} << "(@blend_mode="
      @blend_mode.inspect(io)
      io << ", @transform="
      @transform.inspect(io)
      io << ", texture="
      @_renderstates_texture.inspect(io)
      io << ", shader="
      @_renderstates_shader.inspect(io)
      io << ")"
    end
  end

  class Shader
    # Special type that can be passed to `Shader#set_parameter` that
    # represents the texture of the object being drawn.
    struct CurrentTextureType
    end

    # Represents the texture of the object being drawn
    CurrentTexture = CurrentTextureType.new

    # Forwards calls like `shader.param(arg1, arg2)` to
    # `shader.set_parameter("param", arg1, arg2)`
    macro method_missing(call)
      set_parameter {{call.name.stringify}}, {{call.args.splat}}
    end
  end

  class ConvexShape < Shape
    # Shorthand for `get_point`
    def [](index)
      get_point(index)
    end
    # Shorthand for `set_point`
    def []=(index, point)
      set_point(index, point)
    end
  end

  module Drawable
    # Draw the object to a render target.
    #
    # This is an abstract method that has to be implemented by the
    # including class to define how the drawable should be drawn.
    # * *target* - Render target to draw to
    # * *states* - Current render states
    abstract def draw(target : RenderTarget, states : RenderStates)
  end

  module RenderTarget
    # Draw a drawable object to the render target.
    #
    # Shorthand for `Drawable#draw(self, states)`
    #
    # * *drawable* - Object to draw
    # * *states* - Render states to use for drawing
    def draw(drawable : Drawable, states : RenderStates = RenderStates::Default)
    end
  end
  class RenderWindow
    # :nodoc:
    def draw(drawable : Drawable, states : RenderStates = RenderStates::Default)
      drawable.draw(self.as(RenderWindow), states)
    end
  end
  class RenderTexture
    # :nodoc:
    def draw(drawable : Drawable, states : RenderStates = RenderStates::Default)
      drawable.draw(self.as(RenderTexture), states)
    end
  end

  struct Transform
    # The identity transform (does nothing)
    Identity = new

    def inspect(io)
      io << {{@type.name}} << "("
      {% for index, i in [0, 4, 12, 1, 5, 13, 3, 7, 15] %}
        {% if i > 0 %}
          io << ",{% if i % 3 == 0 %} {% end %}"
        {% end %}
        io << @matrix[{{index}}]
      {% end %}
      io << ")"
    end
  end

  class Sprite
    # Shorthand for `#set_texture`
    def texture=(texture : Texture)
      set_texture(texture)
    end
  end

  class Shape
    # Shorthand for `set_texture`
    def texture=(texture : Texture)
      set_texture(texture)
    end
  end

  struct BlendMode
    # Blend source and dest according to dest alpha
    BlendAlpha = BlendMode.new(BlendMode::SrcAlpha, BlendMode::OneMinusSrcAlpha, BlendMode::Add,
                              BlendMode::One, BlendMode::OneMinusSrcAlpha, BlendMode::Add)
    # Add source to dest
    BlendAdd = BlendMode.new(BlendMode::SrcAlpha, BlendMode::One, BlendMode::Add,
                            BlendMode::One, BlendMode::One, BlendMode::Add)
    # Multiply source and dest
    BlendMultiply = BlendMode.new(BlendMode::DstColor, BlendMode::Zero)
    # Overwrite dest with source
    BlendNone = BlendMode.new(BlendMode::One, BlendMode::Zero)
  end
  Util.extract BlendMode
end
