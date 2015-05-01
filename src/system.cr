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
  
  struct Vector2(T)
    property x
    property y
    def initialize(x: T, y: T)
      @x = x
      @y = y
    end
    def each
      yield @x
      yield @y
    end
    def length
      2
    end
    def [](i)
      case i
      when 1
        @y
      else
        @x
      end
    end
    
    def +(other)
      ox, oy = other
      Vector2.new(x + ox, y + oy)
    end
    def -(other)
      ox, oy = other
      Vector2.new(x - ox, y - oy)
    end
    def *(other)
      ox, oy = other
      Vector2.new(x * ox, y * oy)
    end
    def /(other)
      ox, oy = other
      Vector2.new(x / ox, y / oy)
    end
    def ==(other)
      ox, oy = other
      x == ox && y == oy
    end
  end
  
  def vector2(x, y)
    Vector2.new(x, y)
  end
  def vector2(v)
    x, y = v
    Vector2.new(x, y)
  end
  
  def vector2f(x, y)
    Vector2f.new(x: x.to_f32, y: y.to_f32)
  end
  def vector2f(v)
    x, y = v
    vector2f(x, y)
  end
  def vector2i(x, y)
    Vector2i.new(x: x.to_i32, y: y.to_i32)
  end
  def vector2i(v)
    x, y = v
    vector2i(x, y)
  end
  
  
  
  struct CSFML::Time
    Zero = milliseconds(0)
  end
end

require "./system_obj"
