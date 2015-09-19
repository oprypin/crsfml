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


module SF
  class Error < Exception
  end

  class NullResult < Error
  end

  # :nodoc:
  module Wrapper(T)
    # Every wrapper class has these methods
    macro included
      private def initialize(@this: T, @owned: Bool)
      end

      # Get the underlying pointer
      def to_unsafe
        @this
      end

      # Put the pointer into the wrapper object.
      # The pointer will **not** be freed on GC.
      def self.wrap_ptr(ptr: T)
        new(ptr, false)
      end

      # Put the pointer into the wrapper object.
      # The pointer will **not** be freed on GC.
      #
      # Returns nil instead of `null` pointer.
      def self.wrap_ptr?(ptr: T)
        ptr ? new(ptr, false) : nil
      end

      # Transfer ownership of the pointer to the wrapper object.
      # The pointer will be freed on GC.
      #
      # Raises `NullResult` if the passed pointer is `null`.
      def self.transfer_ptr(ptr: T)
        raise NullResult.new unless ptr
        new(ptr, true)
      end
    end
  end
end

# Backwards compatibility
def Int8.new(value)
  value.to_i8
end
def Int16.new(value)
  value.to_i16
end
def Int32.new(value)
  value.to_i32
end
def Int64.new(value)
  value.to_i64
end
def UInt8.new(value)
  value.to_u8
end
def UInt16.new(value)
  value.to_u16
end
def UInt32.new(value)
  value.to_u32
end
def UInt64.new(value)
  value.to_u64
end
def Float32.new(value)
  value.to_f32
end
def Float64.new(value)
  value.to_f64
end
