module SF
  struct Vector2(T)
    include Enumerable(T)

    property x : T, y : T

    def initialize(@x : T, @y : T)
    end

    def each
      yield @x
      yield @y
    end
    def size
      2
    end
    def [](i)
      case i
      when 0; @x
      when 1; @y
      else; raise IndexError.new
      end
    end

    def +(other)
      ox, oy = other
      SF.vector2(x + ox, y + oy)
    end
    def -(other)
      ox, oy = other
      SF.vector2(x - ox, y - oy)
    end
    def *(other : Enumerable)
      ox, oy = other
      SF.vector2(x * ox, y * oy)
    end
    def *(n : Number)
      SF.vector2(x * n, y * n)
    end
    def /(n)
      SF.vector2(x / n, y / n)
    end
    def ==(other)
      ox, oy = other
      x == ox && y == oy
    end

    # :nodoc:
    def to_unsafe()
      pointerof(@x).as(Void*)
    end
  end

  # Shorthand for `Vector2.new`
  #
  # If arguments are mixed between `Int32` and `Float`,
  # they are converted to match `Vector2f`
  def vector2(x, y)
    Vector2.new(x, y)
  end
  # :nodoc:
  def vector2(x : Float32, y : Float64)
    Vector2.new(x, y.to_f32)
  end
  # :nodoc:
  def vector2(x : Float64, y : Float32)
    Vector2.new(x.to_f32, y)
  end
  # :nodoc:
  def vector2(x : Int32, y : Float32)
    Vector2.new(x.to_f32, y.to_f32)
  end
  # :nodoc:
  def vector2(x : Int32, y : Float64)
    Vector2.new(x.to_f64, y.to_f64)
  end
  # :nodoc:
  def vector2(x : Float32, y : Int32)
    Vector2.new(x.to_f32, y.to_f32)
  end
  # :nodoc:
  def vector2(x : Float64, y : Int32)
    Vector2.new(x.to_f64, y.to_f64)
  end

  alias Vector2i = Vector2(Int32)
  alias Vector2u = Vector2i
  alias Vector2f = Vector2(Float32)

  # Shorthand for `Vector2f.new`
  #
  # Converts arguments to `Float32`
  def vector2f(x : Number, y : Number)
    Vector2f.new(x.to_f32, y.to_f32)
  end
  # Shorthand for `Vector2i.new`
  #
  # Converts arguments to `Int32`
  def vector2i(x : Int, y : Int)
    Vector2i.new(x.to_i32, y.to_i32)
  end

  struct Vector3(T)
    include Enumerable(T)

    property x : T, y : T, z : T

    def initialize(@x : T, @y : T, @z : T)
    end

    def each
      yield @x
      yield @y
      yield @z
    end
    def size
      3
    end
    def [](i)
      case i
      when 0; @x
      when 1; @y
      when 2; @z
      else; raise IndexError.new
      end
    end
  end

  # Shorthand for `Vector3.new`
  def vector3(x, y, z)
    SF::Vector3.new(x, y, z)
  end

  alias Vector3f = Vector3(Float32)

  # Shorthand for `Vector3f.new`
  #
  # Converts arguments to `Float32`
  def vector3f(x : Number, y : Number, z : Number)
    SF::Vector3.new(x.to_f32, y.to_f32, z.to_f32)
  end

  struct Time
    Zero = Time.new
  end

  class Mutex
    def synchronize
      lock
      begin
        yield
      ensure
        unlock
      end
    end
  end
end

require "./obj"
