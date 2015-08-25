require "./system_lib"
require "./common_obj"

module SF
  extend self

  # Represents a time value
  alias Time = CSFML::Time

  struct CSFML::Time
    # Return a time value as a number of seconds
    # 
    # *Arguments*:
    # 
    # * `time`: Time value
    # 
    # *Returns*: Time in seconds
    def as_seconds()
      CSFML.time_as_seconds(self)
    end
    
    # Return a time value as a number of milliseconds
    # 
    # *Arguments*:
    # 
    # * `time`: Time value
    # 
    # *Returns*: Time in milliseconds
    def as_milliseconds()
      CSFML.time_as_milliseconds(self)
    end
    
    # Return a time value as a number of microseconds
    # 
    # *Arguments*:
    # 
    # * `time`: Time value
    # 
    # *Returns*: Time in microseconds
    def as_microseconds()
      CSFML.time_as_microseconds(self)
    end
    
  end

  class Clock
    include Wrapper(CSFML::Clock)
    
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
    def dup()
      Clock.transfer_ptr(CSFML.clock_copy(@this))
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
    include Wrapper(CSFML::Mutex)
    
    # Create a new mutex
    # 
    # *Returns*: A new Mutex object
    def initialize()
      @owned = true
      @this = CSFML.mutex_create()
    end
    
    # Destroy a mutex
    # 
    # *Arguments*:
    # 
    # * `mutex`: Mutex to destroy
    def finalize()
      CSFML.mutex_destroy(@this) if @owned
    end
    
    # Lock a mutex
    # 
    # *Arguments*:
    # 
    # * `mutex`: Mutex object
    def lock()
      CSFML.mutex_lock(@this)
    end
    
    # Unlock a mutex
    # 
    # *Arguments*:
    # 
    # * `mutex`: Mutex object
    def unlock()
      CSFML.mutex_unlock(@this)
    end
    
  end

  class Thread
    include Wrapper(CSFML::Thread)
    
    # Destroy a thread
    # 
    # This function calls Thread_wait, so that the internal thread
    # cannot survive after the Thread object is destroyed.
    # 
    # *Arguments*:
    # 
    # * `thread`: Thread to destroy
    def finalize()
      CSFML.thread_destroy(@this) if @owned
    end
    
    # Run a thread
    # 
    # This function starts the entry point passed to the
    # thread's constructor, and returns immediately.
    # After this function returns, the thread's function is
    # running in parallel to the calling code.
    # 
    # *Arguments*:
    # 
    # * `thread`: Thread object
    def launch()
      CSFML.thread_launch(@this)
    end
    
    # Wait until a thread finishes
    # 
    # This function will block the execution until the
    # thread's function ends.
    # Warning: if the thread function never ends, the calling
    # thread will block forever.
    # If this function is called from its owner thread, it
    # returns without doing anything.
    # 
    # *Arguments*:
    # 
    # * `thread`: Thread object
    def wait()
      CSFML.thread_wait(@this)
    end
    
    # Terminate a thread
    # 
    # This function immediately stops the thread, without waiting
    # for its function to finish.
    # Terminating a thread with this function is not safe,
    # and can lead to local variables not being destroyed
    # on some operating systems. You should rather try to make
    # the thread function terminate by itself.
    # 
    # *Arguments*:
    # 
    # * `thread`: Thread object
    def terminate()
      CSFML.thread_terminate(@this)
    end
    
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
  def seconds(amount: Number)
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
  def microseconds(amount: Int)
    amount = amount.to_i64
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
