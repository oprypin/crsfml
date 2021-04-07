module SF
  # Utility generic struct for manipulating 2-dimensional vectors
  #
  # `SF::Vector2` is a simple struct that defines a mathematical
  # vector with two coordinates (x and y). It can be used to
  # represent anything that has two dimensions: a size, a point,
  # a velocity, etc.
  #
  # The generic parameter T is the type of the coordinates. It
  # can be any type that supports arithmetic operations (+, -, /, *)
  # and comparisons (==, !=), for example `Int` or `Float`.
  #
  # You generally don't have to care about the generic form,
  # the most common specializations have special aliases:
  #
  # * `SF::Vector2(Float32)` is `SF::Vector2f`
  # * `SF::Vector2(Int32)` is `SF::Vector2i`
  #
  # See also: `SF.vector2f`, `SF.vector2i`.
  #
  # The `SF::Vector2` struct has a small and simple interface, its
  # `x` and `y` members can be accessed directly and it contains no
  # mathematical function like dot product, cross product, length, etc.
  #
  # Usage example:
  # ```
  # v1 = SF.vector2f(16.5, 24)
  # v1.x = 18.2_f32
  # y = v1.y
  #
  # v2 = v1 * 5
  # v3 = v1 + v2
  #
  # different = (v2 != v3)
  # ```
  #
  # Note: for 3-dimensional vectors, see `SF::Vector3`.
  struct Vector2(T)
    include Enumerable(T)

    # The *x* coordinate
    property x : T
    # The *y* coordinate
    property y : T

    # Default constructor: equivalent to `new(0, 0)`
    def initialize()
      @x = @y = T.zero
    end
    # Construct the vector from its coordinates.
    def initialize(@x : T, @y : T)
    end

    # Yields `x`, then `y`
    def each
      yield @x
      yield @y
    end
    # Returns `2`
    def size : Int32
      2
    end
    # Get a coordinate by its index: 0 is `x`, 1 is `y`.
    #
    # Raises `IndexError` for other indices.
    def [](i : Int) : T
      case i
      when 0; @x
      when 1; @y
      else; raise IndexError.new
      end
    end

    # Memberwise addition of two vectors
    def +(other)
      ox, oy = other
      SF.vector2(x + ox, y + oy)
    end
    # Memberwise subtraction of two vectors
    def -(other)
      ox, oy = other
      SF.vector2(x - ox, y - oy)
    end
    # Memberwise opposite of the vector
    def -()
      SF.vector2(-x, -y)
    end
    # Memberwise multiplication of two vectors
    def *(other)
      ox, oy = other
      SF.vector2(x * ox, y * oy)
    end
    # Memberwise multiplication by a scalar
    def *(n : Number)
      SF.vector2(x * n, y * n)
    end
    # Memberwise division by a scalar
    def /(n : Number)
      SF.vector2(x / n, y / n)
    end
    # Returns true if both corresponding coordinates of two vectors are equal
    def ==(other : Vector2)
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
  def vector2(x : Float32, y : Int32|Float64)
    Vector2.new(x, y.to_f32)
  end
  # :nodoc:
  def vector2(x : Int32|Float64, y : Float32)
    Vector2.new(x.to_f32, y)
  end
  # :nodoc:
  def vector2(x : Float64, y : Int32)
    Vector2.new(x, y.to_f64)
  end
  # :nodoc:
  def vector2(x : Int32, y : Float64)
    Vector2.new(x.to_f64, y)
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
  # Shorthand for `Vector2u.new`
  #
  # Converts arguments to `UInt32`
  def vector2u(x : Int, y : Int)
    Vector2i.new(x.to_u32.to_i32!, y.to_u32.to_i32!)
  end

  # Utility generic struct for manipulating 2-dimensional vectors
  #
  # `SF::Vector3` is a simple struct that defines a mathematical
  # vector with three coordinates (x, y and z). It can be used to
  # represent anything that has three dimensions: a size, a point,
  # a velocity, etc.
  #
  # The generic parameter T is the type of the coordinates. It
  # can be any type that supports arithmetic operations (+, -, /, *)
  # and comparisons (==, !=), for example `Int` or `Float`.
  #
  # You generally don't have to care about the generic form,
  # the most common specialization has a special alias:
  #
  # * `SF::Vector3(Float32)` is `SF::Vector3f`
  #
  # The `SF::Vector3` struct has a small and simple interface, its
  # `x`, `y`, `z` members can be accessed directly and it contains no
  # mathematical function like dot product, cross product, length, etc.
  #
  # Note: for 2-dimensional vectors, see `SF::Vector2`.
  struct Vector3(T)
    include Enumerable(T)

    # The *x* coordinate
    property x : T
    # The *y* coordinate
    property y : T
    # The *z* coordinate
    property z : T

    # Default constructor: equivalent to `new(0, 0, 0)`
    def initialize()
      @x = @y = @z = T.zero
    end
    # Construct the vector from its coordinates.
    def initialize(@x : T, @y : T, @z : T)
    end

    # Yields `x`, then `y`, then `z`
    def each
      yield @x
      yield @y
      yield @z
    end
    # Returns `3`
    def size
      3
    end
    # Get a coordinate by its index: 0 is `x`, 1 is `y`, 2 is `z`.
    #
    # Raises `IndexError` for other indices.
    def [](i)
      case i
      when 0; @x
      when 1; @y
      when 2; @z
      else; raise IndexError.new
      end
    end

    # Memberwise addition of two vectors
    def +(other)
      ox, oy, oz = other
      SF.vector3(x + ox, y + oy, z + oz)
    end
    # Memberwise subtraction of two vectors
    def -(other)
      ox, oy, oz = other
      SF.vector3(x - ox, y - oy, z - oz)
    end
    # Memberwise opposite of the vector
    def -()
      SF.vector3(-x, -y, -z)
    end
    # Memberwise multiplication by a scalar
    def *(n : Number)
      SF.vector3(x * n, y * n, z * n)
    end
    # Memberwise division by a scalar
    def /(n : Number)
      SF.vector3(x / n, y / n, z / n)
    end
    # Returns true if all corresponding coordinates of two vectors are equal
    def ==(other : Vector3)
      ox, oy, oz = other
      x == ox && y == oy && z == oz
    end

    # :nodoc:
    def to_unsafe()
      pointerof(@x).as(Void*)
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
    # Predefined "zero" time value
    Zero = new
  end

  class Mutex
    # Lock the mutex, execute the block, then unlock the mutex
    # (even if an exception is raised).
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
