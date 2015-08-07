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

module SF
  extend self
  
  module Vector2M
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
    
    include Vector2M
    
    def +(other)
      ox, oy = other
      SF.vector2(x + ox, y + oy)
    end
    def -(other)
      ox, oy = other
      SF.vector2(x - ox, y - oy)
    end
    def *(other)
      if other.responds_to? :[]
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
    include SF::Vector2M
  end
  def vector2f(x: Number, y: Number)
    Vector2f.new(x: x.to_f32, y: y.to_f32)
  end
  def vector2f(v)
    x, y = v
    vector2f(x, y)
  end
  
  struct CSFML::Vector2i
    include SF::Vector2M
  end
  def vector2i(x: Int, y: Int)
    Vector2i.new(x: x.to_i32, y: y.to_i32)
  end
  def vector2i(v)
    x, y = v
    vector2i(x, y)
  end
  
  
  
  struct CSFML::Time
    Zero = SF.milliseconds(0)
  end
end

require "./system_obj"
