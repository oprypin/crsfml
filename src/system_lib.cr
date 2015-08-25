require "./common_lib"

@[Link("csfml-system")]

lib CSFML
  # Represents a time value
  struct Time
    microseconds: Int64
  end
  
  # Return a time value as a number of seconds
  # 
  # *Arguments*:
  # 
  # * `time`: Time value
  # 
  # *Returns*: Time in seconds
  fun time_as_seconds = sfTime_asSeconds(time: Time): Float32
  
  # Return a time value as a number of milliseconds
  # 
  # *Arguments*:
  # 
  # * `time`: Time value
  # 
  # *Returns*: Time in milliseconds
  fun time_as_milliseconds = sfTime_asMilliseconds(time: Time): Int32
  
  # Return a time value as a number of microseconds
  # 
  # *Arguments*:
  # 
  # * `time`: Time value
  # 
  # *Returns*: Time in microseconds
  fun time_as_microseconds = sfTime_asMicroseconds(time: Time): Int64
  
  # Construct a time value from a number of seconds
  # 
  # *Arguments*:
  # 
  # * `amount`: Number of seconds
  # 
  # *Returns*: Time value constructed from the amount of seconds
  fun seconds = sfSeconds(amount: Float32): Time
  
  # Construct a time value from a number of milliseconds
  # 
  # *Arguments*:
  # 
  # * `amount`: Number of milliseconds
  # 
  # *Returns*: Time value constructed from the amount of milliseconds
  fun milliseconds = sfMilliseconds(amount: Int32): Time
  
  # Construct a time value from a number of microseconds
  # 
  # *Arguments*:
  # 
  # * `amount`: Number of microseconds
  # 
  # *Returns*: Time value constructed from the amount of microseconds
  fun microseconds = sfMicroseconds(amount: Int64): Time
  
  type Clock = Void*
  
  type Mutex = Void*
  
  type Thread = Void*
  
  # Create a new clock and start it
  # 
  # *Returns*: A new Clock object
  fun clock_create = sfClock_create(): Clock
  
  # Create a new clock by copying an existing one
  # 
  # *Arguments*:
  # 
  # * `clock`: Clock to copy
  # 
  # *Returns*: A new Clock object which is a copy of `clock`
  fun clock_copy = sfClock_copy(clock: Clock): Clock
  
  # Destroy a clock
  # 
  # *Arguments*:
  # 
  # * `clock`: Clock to destroy
  fun clock_destroy = sfClock_destroy(clock: Clock)
  
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
  fun clock_get_elapsed_time = sfClock_getElapsedTime(clock: Clock): Time
  
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
  fun clock_restart = sfClock_restart(clock: Clock): Time
  
  alias InputStreamReadFunc = (Void*, Int64, Void*) -> Int64
  alias InputStreamSeekFunc = (Int64, Void*) -> Int64
  alias InputStreamTellFunc = (Void*) -> Int64
  alias InputStreamGetSizeFunc = (Void*) -> Int64
  # Set of callbacks that allow users to define custom file streams
  struct InputStream
    read: InputStreamReadFunc
    seek: InputStreamSeekFunc
    tell: InputStreamTellFunc
    get_size: InputStreamGetSizeFunc
    user_data: Void*
  end
  
  # Create a new mutex
  # 
  # *Returns*: A new Mutex object
  fun mutex_create = sfMutex_create(): Mutex
  
  # Destroy a mutex
  # 
  # *Arguments*:
  # 
  # * `mutex`: Mutex to destroy
  fun mutex_destroy = sfMutex_destroy(mutex: Mutex)
  
  # Lock a mutex
  # 
  # *Arguments*:
  # 
  # * `mutex`: Mutex object
  fun mutex_lock = sfMutex_lock(mutex: Mutex)
  
  # Unlock a mutex
  # 
  # *Arguments*:
  # 
  # * `mutex`: Mutex object
  fun mutex_unlock = sfMutex_unlock(mutex: Mutex)
  
  # Make the current thread sleep for a given duration
  # 
  # Sleep is the best way to block a program or one of its
  # threads, as it doesn't consume any CPU power.
  # 
  # *Arguments*:
  # 
  # * `duration`: Time to sleep
  fun sleep = sfSleep(duration: Time)
  
  # Destroy a thread
  # 
  # This function calls Thread_wait, so that the internal thread
  # cannot survive after the Thread object is destroyed.
  # 
  # *Arguments*:
  # 
  # * `thread`: Thread to destroy
  fun thread_destroy = sfThread_destroy(thread: Thread)
  
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
  fun thread_launch = sfThread_launch(thread: Thread)
  
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
  fun thread_wait = sfThread_wait(thread: Thread)
  
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
  fun thread_terminate = sfThread_terminate(thread: Thread)
  
  # 2-component vector of integers
  struct Vector2i
    x: Int32
    y: Int32
  end
  
  # 2-component vector of floats
  struct Vector2f
    x: Float32
    y: Float32
  end
  
  # 3-component vector of floats
  struct Vector3f
    x: Float32
    y: Float32
    z: Float32
  end
  
end
