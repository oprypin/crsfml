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
  
  # Every wrapper class has these methods
  module Wrapper(T)
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
