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

  alias Time = CSFML::Time
     
  class Clock
    def self.wrap_ptr(p)
      result = self.allocate()
      result.this = p
      result
    end
    def to_unsafe
      @this
    end
    def initialize()
      @owned = true
      @this = CSFML.clock_create()
    end
    def copy()
      self.wrap_ptr(CSFML.clock_copy(@this))
    end
    def finalize()
      CSFML.clock_destroy(@this) if @owned
    end
    def elapsed_time
      CSFML.clock_get_elapsed_time(@this)
    end
    def restart()
      CSFML.clock_restart(@this)
    end
  end

  class Mutex
    def self.wrap_ptr(p)
      result = self.allocate()
      result.this = p
      result
    end
    def to_unsafe
      @this
    end
  end

  class Thread
    def self.wrap_ptr(p)
      result = self.allocate()
      result.this = p
      result
    end
    def to_unsafe
      @this
    end
  end

  alias InputStream = CSFML::InputStream
     
  alias Vector2i = CSFML::Vector2i
     
  alias Vector2f = CSFML::Vector2f
     
  alias Vector3f = CSFML::Vector3f
     
  def as_seconds(time: Time)
    CSFML.time_as_seconds(time)
  end
  def as_milliseconds(time: Time)
    CSFML.time_as_milliseconds(time)
  end
  def as_microseconds(time: Time)
    CSFML.time_as_microseconds(time)
  end
  def seconds(amount)
    amount = amount.to_f32
    CSFML.seconds(amount)
  end
  def milliseconds(amount: Int32)
    CSFML.milliseconds(amount)
  end
  def microseconds(amount: Int64)
    CSFML.microseconds(amount)
  end
  def sleep(duration: Time)
    CSFML.sleep(duration)
  end
end