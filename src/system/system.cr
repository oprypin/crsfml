module SF
  struct Vector2(T)
    include Enumerable(T)

    property x, y

    def initialize(@x : T, @y : T)
    end
    def self.new(x : Float32, y : Float64)
      Vector2.new(x, y.to_f32)
    end
    def self.new(x : Float64, y : Float32)
      Vector2.new(x.to_f32, y)
    end
    def self.new(x : Int32, y : Float32)
      Vector2.new(x.to_f32, y.to_f32)
    end
    def self.new(x : Int32, y : Float64)
      Vector2.new(x.to_f64, y.to_f64)
    end
    def self.new(x : Float32, y : Int32)
      Vector2.new(x.to_f32, y.to_f32)
    end
    def self.new(x : Float64, y : Int32)
      Vector2.new(x.to_f64, y.to_f64)
    end
    def self.new(v)
      x, y = v
      Vector2.new(x, y)
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
    def *(other)
      if other.responds_to?(:[])
        ox, oy = other
        SF.vector2(x * ox, y * oy)
      else
        SF.vector2(x * other, y * other)
      end
    end
    def /(o)
      SF.vector2(x / o, y / o)
    end
    def ==(other)
      ox, oy = other
      x == ox && y == oy
    end

    def to_unsafe
      _sf_ptr_self
    end
  end
  # Shorthand for `Vector2.new`
  def vector2(*args, **kwargs)
    Vector2.new(*args, **kwargs)
  end

  alias Vector2i = Vector2(Int32)
  alias Vector2u = Vector2i
  alias Vector2f = Vector2(Float32)


  struct Vector3(T)
    include Enumerable(T)

    property x, y, z

    def initialize(@x : T, @y : T, @z : T)
    end
    def initialize(v)
      @x, @y, @z = v
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
      when 1; @y
      when 2; @z
      else; @x
      end
    end
  end
  # Shorthand for `Vector3f.new`
  def vector3f(x : Number, y : Number, z : Number)
    SF::Vector3.new(x.to_f32, y.to_f32, z.to_f32)
  end

  alias Vector3f = Vector3(Float32)

  struct Time
    Zero = Time.new
  end
end

require "./obj"
