require "./system_lib"
require "./common_obj"

module SF
  extend self

  # Represents a time value
  alias Time = CSFML::Time
    # Return a time value as a number of seconds
    # 
    # *Arguments*:
    # 
    # * `time`: Time value
    # 
    # *Returns*: Time in seconds
    def self.as_seconds(time: Time)
      CSFML.time_as_seconds(time)
    end
    
    # Return a time value as a number of milliseconds
    # 
    # *Arguments*:
    # 
    # * `time`: Time value
    # 
    # *Returns*: Time in milliseconds
    def self.as_milliseconds(time: Time)
      CSFML.time_as_milliseconds(time)
    end
    
    # Return a time value as a number of microseconds
    # 
    # *Arguments*:
    # 
    # * `time`: Time value
    # 
    # *Returns*: Time in microseconds
    def self.as_microseconds(time: Time)
      CSFML.time_as_microseconds(time)
    end
    

  class Clock
    include Wrapper
    
    # Create a new clock and start it
    # 
    # *Returns*: A new Clock object
    def initialize()
      @owned = true
      @this = CSFML.clock_create()
    end
    
    # Create a new clock by copying an existing one
    # 
    # *Arguments*:
    # 
    # * `clock`: Clock to copy
    # 
    # *Returns*: A new Clock object which is a copy of `clock`
    def copy()
      result = Clock.allocate()
      result.transfer_ptr(CSFML.clock_copy(@this))
    end
    
    # Destroy a clock
    # 
    # *Arguments*:
    # 
    # * `clock`: Clock to destroy
    def finalize()
      CSFML.clock_destroy(@this) if @owned
    end
    
    # Get the time elapsed in a clock
    # 
    # This function returns the time elapsed since the last call
    # to Clock_restart (or the construction of the object if
    # Clock_restart has not been called).
    # 
    # *Arguments*:
    # 
    # * `clock`: Clock object
    # 
    # *Returns*: Time elapsed
    def elapsed_time
      CSFML.clock_get_elapsed_time(@this)
    end
    
    # Restart a clock
    # 
    # This function puts the time counter back to zero.
    # It also returns the time elapsed since the clock was started.
    # 
    # *Arguments*:
    # 
    # * `clock`: Clock object
    # 
    # *Returns*: Time elapsed
    def restart()
      CSFML.clock_restart(@this)
    end
    
  end

  class Mutex
    include Wrapper
    
  end

  class Thread
    include Wrapper
    
  end

  # Set of callbacks that allow users to define custom file streams
  alias InputStream = CSFML::InputStream

  # 2-component vector of integers
  alias Vector2i = CSFML::Vector2i

  # 2-component vector of floats
  alias Vector2f = CSFML::Vector2f

  # 3-component vector of floats
  alias Vector3f = CSFML::Vector3f

  # Construct a time value from a number of seconds
  # 
  # *Arguments*:
  # 
  # * `amount`: Number of seconds
  # 
  # *Returns*: Time value constructed from the amount of seconds
  def seconds(amount)
    amount = amount.to_f32
    CSFML.seconds(amount)
  end
  
  # Construct a time value from a number of milliseconds
  # 
  # *Arguments*:
  # 
  # * `amount`: Number of milliseconds
  # 
  # *Returns*: Time value constructed from the amount of milliseconds
  def milliseconds(amount: Int32)
    CSFML.milliseconds(amount)
  end
  
  # Construct a time value from a number of microseconds
  # 
  # *Arguments*:
  # 
  # * `amount`: Number of microseconds
  # 
  # *Returns*: Time value constructed from the amount of microseconds
  def microseconds(amount: Int64)
    CSFML.microseconds(amount)
  end
  
  # Make the current thread sleep for a given duration
  # 
  # Sleep is the best way to block a program or one of its
  # threads, as it doesn't consume any CPU power.
  # 
  # *Arguments*:
  # 
  # * `duration`: Time to sleep
  def sleep(duration: Time)
    CSFML.sleep(duration)
  end
  
end
