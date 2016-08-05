module SF
  struct Rect(T)
    property left : T, top : T, width : T, height : T

    def initialize()
      @left = @top = @width = @height = 0
    end
    def initialize(@left : T, @top : T, @width : T, @height : T)
    end
    def initialize(position : Vector2(T), size : Vector2(T))
      @left, @top = position
      @width, @height = size
    end

    def contains(x : Number, y : Number) : Bool
      horz = {left, left + width}
      vert = {top, top + height}
      (horz.min <= x < horz.max) && (vert.min <= y < vert.max)
    end
    def contains(point) : Bool
      contains(*point)
    end

    def intersects(other : Rect) : Rect?
      horz1, horz2 = {left, left+width}, {other.left, other.left+width}
      vert1, vert2 = {top, top+height}, {other.top, other.top+height}
      x1 = {horz1.min, horz2.min}.max
      y1 = {vert1.min, vert2.min}.max
      x2 = {horz1.max, horz2.max}.min
      y2 = {vert1.max, vert2.max}.min
      Rect.new(x1, y1, x2-x1, y2-y1) if x1 < x2 && y1 < y2
    end

    # :nodoc:
    def to_unsafe()
      @left.as(Void*)
    end
  end

  alias FloatRect = Rect(Float32)

  # Shorthand for `FloatRect.new`
  def float_rect(left : Number, top : Number, width : Number, height : Number)
    FloatRect.new(left.to_f32, top.to_f32, width.to_f32, height.to_f32)
  end

  alias IntRect = Rect(Int32)

  # Shorthand for `IntRect.new`
  def int_rect(left : Int, top : Int, width : Int, height : Int)
    IntRect.new(left.to_i32, top.to_i32, width.to_i32, height.to_i32)
  end
end

require "./obj"

module SF
  struct Color
    Black = Color.new(0u8, 0u8, 0u8)
    White = Color.new(255u8, 255u8, 255u8)
    Red = Color.new(255u8, 0u8, 0u8)
    Green = Color.new(0u8, 255u8, 0u8)
    Blue = Color.new(0u8, 0u8, 255u8)
    Yellow = Color.new(255u8, 255u8, 0u8)
    Magenta = Color.new(255u8, 0u8, 255u8)
    Cyan = Color.new(0u8, 255u8, 255u8)
    Transparent = Color.new(0u8, 0u8, 0u8, 0u8)
  end
  # Shorthand for `Color.new`
  def color(*args, **kwargs)
    SF::Color.new(*args, **kwargs)
  end

  struct RenderStates
    Default = RenderStates.new()
  end

  class Shader
    struct CurrentTextureType
    end

    CurrentTexture = CurrentTextureType.new

    # Forwards calls like `shader.param(arg1, arg2)` to
    # `shader.set_parameter("param", arg1, arg2)`
    macro method_missing(call)
      set_parameter {{call.name.stringify}}, {{call.args.argify}}
    end
  end

  class ConvexShape < SF::Shape
    def [](index)
      get_point(index)
    end
    def []=(index, point)
      set_point(index, point)
    end

    def texture=(texture : Texture)
      set_texture(texture, false)
    end
  end

  module Drawable
    abstract def draw(target : RenderTarget, states : RenderStates)
  end

  class RenderWindow
    def draw(drawable : Drawable, states : RenderStates = RenderStates::Default)
      drawable.draw(self as RenderWindow, states)
    end
  end
  class RenderTexture
    def draw(drawable : Drawable, states : RenderStates = RenderStates::Default)
      drawable.draw(self as RenderTexture, states)
    end
  end

  struct Transform
    Identity = new
  end

  class Sprite
    # Alias of `#set_texture`
    def texture=(texture : Texture)
      set_texture(texture)
    end
  end

  class Shape
    # Alias of `#set_texture`
    def texture=(texture : Texture)
      set_texture(texture)
    end
  end
end
