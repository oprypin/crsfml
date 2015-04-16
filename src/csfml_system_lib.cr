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


@[Link("csfml-system")]

lib CSFML
  ifdef x86_64
    alias Size_t = UInt64
  else
    alias Size_t = UInt32
  end

  struct Time
    # Represents a time value
    microseconds: Int64
  end
  
  alias BitMaskU32 = UInt32
  
  fun time_as_seconds = sfTime_asSeconds(time: Time): Float32
    # Return a time value as a number of seconds
    # 
    # Arguments:
    # - time:  Time value
    # 
    # Returns: Time in seconds
  
  fun time_as_milliseconds = sfTime_asMilliseconds(time: Time): Int32
    # Return a time value as a number of milliseconds
    # 
    # Arguments:
    # - time:  Time value
    # 
    # Returns: Time in milliseconds
  
  fun time_as_microseconds = sfTime_asMicroseconds(time: Time): Int64
    # Return a time value as a number of microseconds
    # 
    # Arguments:
    # - time:  Time value
    # 
    # Returns: Time in microseconds
  
  fun seconds = sfSeconds(amount: Float32): Time
    # Construct a time value from a number of seconds
    # 
    # Arguments:
    # - amount:  Number of seconds
    # 
    # Returns: Time value constructed from the amount of seconds
  
  fun milliseconds = sfMilliseconds(amount: Int32): Time
    # Construct a time value from a number of milliseconds
    # 
    # Arguments:
    # - amount:  Number of milliseconds
    # 
    # Returns: Time value constructed from the amount of milliseconds
  
  fun microseconds = sfMicroseconds(amount: Int64): Time
    # Construct a time value from a number of microseconds
    # 
    # Arguments:
    # - amount:  Number of microseconds
    # 
    # Returns: Time value constructed from the amount of microseconds
  
  type Clock = Void*
  
  type Mutex = Void*
  
  type Thread = Void*
  
  fun clock_create = sfClock_create(): Clock
    # Create a new clock and start it
    # 
    # Returns: A new Clock object
  
  fun clock_copy = sfClock_copy(clock: Clock): Clock
    # Create a new clock by copying an existing one
    # 
    # Arguments:
    # - clock:  Clock to copy
    # 
    # Returns: A new Clock object which is a copy of `clock`
  
  fun clock_destroy = sfClock_destroy(clock: Clock): Void
    # Destroy a clock
    # 
    # Arguments:
    # - clock:  Clock to destroy
  
  fun clock_get_elapsed_time = sfClock_getElapsedTime(clock: Clock): Time
    # Get the time elapsed in a clock
    # 
    # This function returns the time elapsed since the last call
    # to Clock_restart (or the construction of the object if
    # Clock_restart has not been called).
    # 
    # Arguments:
    # - clock:  Clock object
    # 
    # Returns: Time elapsed
  
  fun clock_restart = sfClock_restart(clock: Clock): Time
    # Restart a clock
    # 
    # This function puts the time counter back to zero.
    # It also returns the time elapsed since the clock was started.
    # 
    # Arguments:
    # - clock:  Clock object
    # 
    # Returns: Time elapsed
  
  alias InputStreamReadFunc = (Void*, Int64, Void*) -> Int64
  alias InputStreamSeekFunc = (Int64, Void*) -> Int64
  alias InputStreamTellFunc = (Void*) -> Int64
  alias InputStreamGetSizeFunc = (Void*) -> Int64
  struct InputStream
    # Set of callbacks that allow users to define custom file streams
    read: InputStreamReadFunc
    seek: InputStreamSeekFunc
    tell: InputStreamTellFunc
    get_size: InputStreamGetSizeFunc
    user_data: Void*
  end
  
  fun sleep = sfSleep(duration: Time): Void
    # Make the current thread sleep for a given duration
    # 
    # Sleep is the best way to block a program or one of its
    # threads, as it doesn't consume any CPU power.
    # 
    # Arguments:
    # - duration:  Time to sleep
  
  struct Vector2i
    # 2-component vector of integers
    x: Int32
    y: Int32
  end
  
  struct Vector2f
    # 2-component vector of floats
    x: Float32
    y: Float32
  end
  
  struct Vector3f
    # 3-component vector of floats
    x: Float32
    y: Float32
    z: Float32
  end
  
end