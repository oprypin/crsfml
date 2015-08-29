# Copyright (C) 2015 Oleh Prypin <blaxpirit@gmail.com>
# 
# This file is part of CrSFML.
# 
# This software is provided 'as-is', without any express or implied
# warranty. In no event will the authors be held liable for any damages
# arising from the use of this software.
# 
# Permission is granted to anyone to use this software for any purpose,
# including commercial applications, and to alter it and redistribute it
# freely, subject to the following restrictions:
# 
# 1. The origin of this software must not be misrepresented; you must not
#    claim that you wrote the original software. If you use this software
#    in a product, an acknowledgement in the product documentation would be
#    appreciated but is not required.
# 2. Altered source versions must be plainly marked as such, and must not be
#    misrepresented as being the original software.
# 3. This notice may not be removed or altered from any source distribution.

require "./system_lib"

lib CSFML
  fun thread_create = sfThread_create(function: (Void*) -> Void, user_data: Void*): Thread
end

module SF
  extend self
  
  module Vector2M(T)
    include Enumerable(T)
    
    def each
      yield @x
      yield @y
    end
    def length
      2
    end
    def [](i)
      case i
      when 1; @y
      else; @x
      end
    end
  end
  
  struct Vector2(T)
    property x
    property y
    def initialize(@x: T, @y: T)
    end
    
    include Vector2M(T)
    
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
  end
  
  def vector2(x: Number, y: Number)
    Vector2.new(x, y)
  end
  def vector2(x: Float32, y: Float64)
    Vector2.new(x, y.to_f32)
  end
  def vector2(x: Float64, y: Float32)
    Vector2.new(x.to_f32, y)
  end
  def vector2(x: Int32, y: Float32)
    Vector2.new(x.to_f32, y.to_f32)
  end
  def vector2(x: Int32, y: Float64)
    Vector2.new(x.to_f64, y.to_f64)
  end
  def vector2(x: Float32, y: Int32)
    Vector2.new(x.to_f32, y.to_f32)
  end
  def vector2(x: Float64, y: Int32)
    Vector2.new(x.to_f64, y.to_f64)
  end
  def vector2(v)
    x, y = v
    Vector2.new(x, y)
  end
  def vector2(v: Vector2f)
    Vector2.new(v.x, v.y)
  end
  def vector2(v: Vector2i)
    Vector2.new(v.x, v.y)
  end
  
  struct CSFML::Vector2f
    include SF::Vector2M(T)
  end
  def vector2f(x: Number, y: Number)
    Vector2f.new(x: x.to_f32, y: y.to_f32)
  end
  def vector2f(v)
    x, y = v
    vector2f(x, y)
  end
  
  struct CSFML::Vector2i
    include SF::Vector2M(T)
  end
  def vector2i(x: Int, y: Int)
    Vector2i.new(x: x.to_i32, y: y.to_i32)
  end
  def vector2i(v)
    x, y = v
    vector2i(x, y)
  end
  
  def vector3f(x: Number, y: Number, z: Number)
    SF::Vector3f.new(x: x.to_f32, y: y.to_f32, z: z.to_f32)
  end
  
  struct CSFML::Time
    Zero = SF.microseconds(0)
    
    include Comparable(Time)
    
    def <=>(other: Time)
      microseconds <=> other.microseconds
    end
    
    def -
      SF.microseconds(-microseconds)
    end
    def +(other: Time)
      SF.microseconds(microseconds + other.microseconds)
    end
    def -(other: Time)
      SF.microseconds(microseconds - other.microseconds)
    end
    def *(other: Number)
      SF.microseconds((microseconds * other).to_i64)
    end
    def /(other: Number)
      SF.microseconds((microseconds / other).to_i64)
    end
    def /(other: Time)
      microseconds.fdiv other.microseconds # /
    end
  end
  
  class Thread
    def initialize(function: ->)
      @owned = true
      @func = Box.box(function)
      @this = CSFML.thread_create(
        ->(ud) { Box(->).unbox(ud).call },
        @func
      )
    end
  end
  
  struct Lock
    def initialize(@mutex)
      @mutex.lock
    end
    def finalize
      @mutex.unlock
    end
  end
  
  abstract class InputStream
    abstract def read(buffer: Slice(UInt8)): Int
    abstract def seek(position: Int): Int
    abstract def tell(): Int
    abstract def size(): Int
    
    # :nodoc:
    alias FuncBox = Box({((Void*, Int64) -> Int64), ((Int64) -> Int64), (-> Int64), (-> Int64)})
    
    def initialize
      @funcs = FuncBox.box({
        ->(data: Void*, size: Int64) { read((data as Pointer(UInt8)).to_slice(size.to_i)).to_i64 },
        ->(position: Int64) { seek(position).to_i64 },
        -> { tell.to_i64 },
        -> { size.to_i64 }
      })
      @input_stream = CSFML::InputStream.new(
        read: ->(data: Void*, size: Int64, ud: Void*) {
          FuncBox.unbox(ud)[0].call(data, size)
        },
        seek: ->(position: Int64, ud: Void*) {
          FuncBox.unbox(ud)[1].call(position)
        },
        tell: ->(ud: Void*) {
          FuncBox.unbox(ud)[2].call()
        },
        get_size: ->(ud: Void*) {
          FuncBox.unbox(ud)[3].call()
        },
        user_data: @funcs
      )
    end
    def to_unsafe()
      pointerof(@input_stream)
    end
  end
  
  class FileInputStream < InputStream
    def initialize(@io)
      super()
      if @io.responds_to?(:"sync=")
        @io.sync = true
      end
    end
    def self.open(filename)
      self.new(File.open(filename, "rb"))
    end
    property io
    def read(buffer)
      io.read(buffer, buffer.length)
    end
    def seek(position)
      io.seek(position)
    end
    def tell
      io.tell
    end
    def size
      io.size
    end
  end
  
  class MemoryInputStream < InputStream
    def initialize(@data: Slice(UInt8))
      super()
      @position = 0
    end
    def read(buffer)
      finish = Math.min(@position + buffer.length, @data.length)
      to_read = finish - @position
      buffer.copy_from(@data.to_unsafe + @position, to_read)
      @position = finish
      to_read
    end
    def seek(position)
      return -1 unless 0 <= position < @data.length
      @position = position
    end
    def tell
      @position
    end
    def size
      @data.length
    end
  end
end

require "./system_obj"
