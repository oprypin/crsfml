require "./lib"
require "../common"
module SF
  extend self
  # Represents a time value
  #
  # `SF::Time` encapsulates a time value in a flexible way.
  # It allows to define a time value either as a number of
  # seconds, milliseconds or microseconds. It also works the
  # other way round: you can read a time value as either
  # a number of seconds, milliseconds or microseconds.
  #
  # By using such a flexible interface, the API doesn't
  # impose any fixed type or resolution for time values,
  # and let the user choose its own favorite representation.
  #
  # Time values support the usual mathematical operations:
  # you can add or subtract two times, multiply or divide
  # a time by a number, compare two times, etc.
  #
  # Since they represent a time span and not an absolute time
  # value, times can also be negative.
  #
  # Usage example:
  # ```crystal
  # t1 = SF.seconds(0.1)
  # milli = t1.as_milliseconds # 100
  #
  # t2 = SF.milliseconds(30)
  # micro = t2.as_microseconds # 30000
  #
  # t3 = SF.microseconds(-800000)
  # sec = t3.as_seconds # -0.8
  # ```
  #
  # ```crystal
  # def update(elapsed : SF::Time)
  #   @position += @speed * elapsed.as_seconds
  # end
  #
  # update(SF.milliseconds(100))
  # ```
  #
  # *See also:* `SF::Clock`
  struct Time
    @microseconds : Int64
    # Default constructor
    #
    # Sets the time value to zero.
    def initialize()
      @microseconds = uninitialized Int64
      SFMLExt.sfml_time_initialize(to_unsafe)
    end
    # Return the time value as a number of seconds
    #
    # *Returns:* Time in seconds
    #
    # *See also:* `as_milliseconds`, `as_microseconds`
    def as_seconds() : Float32
      SFMLExt.sfml_time_asseconds(to_unsafe, out result)
      return result
    end
    # Return the time value as a number of milliseconds
    #
    # *Returns:* Time in milliseconds
    #
    # *See also:* `as_seconds`, `as_microseconds`
    def as_milliseconds() : Int32
      SFMLExt.sfml_time_asmilliseconds(to_unsafe, out result)
      return result
    end
    # Return the time value as a number of microseconds
    #
    # *Returns:* Time in microseconds
    #
    # *See also:* `as_seconds`, `as_milliseconds`
    def as_microseconds() : Int64
      SFMLExt.sfml_time_asmicroseconds(to_unsafe, out result)
      return result
    end
    @microseconds : Int64
    # Overload of == operator to compare two time values
    #
    # * *left* - Left operand (a time)
    # * *right* - Right operand (a time)
    #
    # *Returns:* True if both time values are equal
    def ==(right : Time) : Bool
      SFMLExt.sfml_operator_eq_f4Tf4T(to_unsafe, right, out result)
      return result
    end
    # Overload of != operator to compare two time values
    #
    # * *left* - Left operand (a time)
    # * *right* - Right operand (a time)
    #
    # *Returns:* True if both time values are different
    def !=(right : Time) : Bool
      SFMLExt.sfml_operator_ne_f4Tf4T(to_unsafe, right, out result)
      return result
    end
    # Overload of &lt; operator to compare two time values
    #
    # * *left* - Left operand (a time)
    # * *right* - Right operand (a time)
    #
    # *Returns:* True if *left* is lesser than *right*
    def <(right : Time) : Bool
      SFMLExt.sfml_operator_lt_f4Tf4T(to_unsafe, right, out result)
      return result
    end
    # Overload of &gt; operator to compare two time values
    #
    # * *left* - Left operand (a time)
    # * *right* - Right operand (a time)
    #
    # *Returns:* True if *left* is greater than *right*
    def >(right : Time) : Bool
      SFMLExt.sfml_operator_gt_f4Tf4T(to_unsafe, right, out result)
      return result
    end
    # Overload of &lt;= operator to compare two time values
    #
    # * *left* - Left operand (a time)
    # * *right* - Right operand (a time)
    #
    # *Returns:* True if *left* is lesser or equal than *right*
    def <=(right : Time) : Bool
      SFMLExt.sfml_operator_le_f4Tf4T(to_unsafe, right, out result)
      return result
    end
    # Overload of &gt;= operator to compare two time values
    #
    # * *left* - Left operand (a time)
    # * *right* - Right operand (a time)
    #
    # *Returns:* True if *left* is greater or equal than *right*
    def >=(right : Time) : Bool
      SFMLExt.sfml_operator_ge_f4Tf4T(to_unsafe, right, out result)
      return result
    end
    # Overload of unary - operator to negate a time value
    #
    # * *right* - Right operand (a time)
    #
    # *Returns:* Opposite of the time value
    def -() : Time
      result = Time.allocate
      SFMLExt.sfml_operator_sub_f4T(to_unsafe, result)
      return result
    end
    # Overload of binary + operator to add two time values
    #
    # * *left* - Left operand (a time)
    # * *right* - Right operand (a time)
    #
    # *Returns:* Sum of the two times values
    def +(right : Time) : Time
      result = Time.allocate
      SFMLExt.sfml_operator_add_f4Tf4T(to_unsafe, right, result)
      return result
    end
    # Overload of binary - operator to subtract two time values
    #
    # * *left* - Left operand (a time)
    # * *right* - Right operand (a time)
    #
    # *Returns:* Difference of the two times values
    def -(right : Time) : Time
      result = Time.allocate
      SFMLExt.sfml_operator_sub_f4Tf4T(to_unsafe, right, result)
      return result
    end
    # Overload of binary * operator to scale a time value
    #
    # * *left* - Left operand (a time)
    # * *right* - Right operand (a number)
    #
    # *Returns:* *left* multiplied by *right*
    def *(right : Number) : Time
      result = Time.allocate
      SFMLExt.sfml_operator_mul_f4TBw9(to_unsafe, LibC::Float.new(right), result)
      return result
    end
    # Overload of binary * operator to scale a time value
    #
    # * *left* - Left operand (a time)
    # * *right* - Right operand (a number)
    #
    # *Returns:* *left* multiplied by *right*
    def *(right : Int) : Time
      result = Time.allocate
      SFMLExt.sfml_operator_mul_f4TG4x(to_unsafe, Int64.new(right), result)
      return result
    end
    # Overload of binary / operator to scale a time value
    #
    # * *left* - Left operand (a time)
    # * *right* - Right operand (a number)
    #
    # *Returns:* *left* divided by *right*
    def /(right : Number) : Time
      result = Time.allocate
      SFMLExt.sfml_operator_div_f4TBw9(to_unsafe, LibC::Float.new(right), result)
      return result
    end
    # Overload of binary / operator to scale a time value
    #
    # * *left* - Left operand (a time)
    # * *right* - Right operand (a number)
    #
    # *Returns:* *left* divided by *right*
    def /(right : Int) : Time
      result = Time.allocate
      SFMLExt.sfml_operator_div_f4TG4x(to_unsafe, Int64.new(right), result)
      return result
    end
    # Overload of binary / operator to compute the ratio of two time values
    #
    # * *left* - Left operand (a time)
    # * *right* - Right operand (a time)
    #
    # *Returns:* *left* divided by *right*
    def /(right : Time) : Float32
      SFMLExt.sfml_operator_div_f4Tf4T(to_unsafe, right, out result)
      return result
    end
    # Overload of binary % operator to compute remainder of a time value
    #
    # * *left* - Left operand (a time)
    # * *right* - Right operand (a time)
    #
    # *Returns:* *left* modulo *right*
    def %(right : Time) : Time
      result = Time.allocate
      SFMLExt.sfml_operator_mod_f4Tf4T(to_unsafe, right, result)
      return result
    end
    # :nodoc:
    def to_unsafe()
      pointerof(@microseconds).as(Void*)
    end
    # :nodoc:
    def initialize(copy : Time)
      @microseconds = uninitialized Int64
      SFMLExt.sfml_time_initialize_PxG(to_unsafe, copy)
    end
    def dup() : Time
      return Time.new(self)
    end
  end
  # Construct a time value from a number of seconds
  #
  # * *amount* - Number of seconds
  #
  # *Returns:* Time value constructed from the amount of seconds
  #
  # *See also:* `milliseconds`, `microseconds`
  def seconds(amount : Number) : Time
    result = Time.allocate
    SFMLExt.sfml_seconds_Bw9(LibC::Float.new(amount), result)
    return result
  end
  # Construct a time value from a number of milliseconds
  #
  # * *amount* - Number of milliseconds
  #
  # *Returns:* Time value constructed from the amount of milliseconds
  #
  # *See also:* `seconds`, `microseconds`
  def milliseconds(amount : Int) : Time
    result = Time.allocate
    SFMLExt.sfml_milliseconds_qe2(Int32.new(amount), result)
    return result
  end
  # Construct a time value from a number of microseconds
  #
  # * *amount* - Number of microseconds
  #
  # *Returns:* Time value constructed from the amount of microseconds
  #
  # *See also:* `seconds`, `milliseconds`
  def microseconds(amount : Int) : Time
    result = Time.allocate
    SFMLExt.sfml_microseconds_G4x(Int64.new(amount), result)
    return result
  end
  # Utility class that measures the elapsed time
  #
  # `SF::Clock` is a lightweight class for measuring time.
  #
  # Its provides the most precise time that the underlying
  # OS can achieve (generally microseconds or nanoseconds).
  # It also ensures monotonicity, which means that the returned
  # time can never go backward, even if the system time is
  # changed.
  #
  # Usage example:
  # ```crystal
  # clock = SF::Clock.new
  # # [...]
  # time1 = clock.elapsed_time
  # # [...]
  # time2 = clock.restart
  # ```
  #
  # The `SF::Time` value returned by the clock can then be
  # converted to a number of seconds, milliseconds or even
  # microseconds.
  #
  # *See also:* `SF::Time`
  class Clock
    @this : Void*
    def finalize()
      SFMLExt.sfml_clock_finalize(to_unsafe)
      SFMLExt.sfml_clock_free(@this)
    end
    # Default constructor
    #
    # The clock starts automatically after being constructed.
    def initialize()
      SFMLExt.sfml_clock_allocate(out @this)
      SFMLExt.sfml_clock_initialize(to_unsafe)
    end
    # Get the elapsed time
    #
    # This function returns the time elapsed since the last call
    # to `restart()` (or the construction of the instance if `restart()`
    # has not been called).
    #
    # *Returns:* Time elapsed
    def elapsed_time() : Time
      result = Time.allocate
      SFMLExt.sfml_clock_getelapsedtime(to_unsafe, result)
      return result
    end
    # Restart the clock
    #
    # This function puts the time counter back to zero.
    # It also returns the time elapsed since the clock was started.
    #
    # *Returns:* Time elapsed
    def restart() : Time
      result = Time.allocate
      SFMLExt.sfml_clock_restart(to_unsafe, result)
      return result
    end
    # :nodoc:
    def to_unsafe()
      @this
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
    # :nodoc:
    def initialize(copy : Clock)
      SFMLExt.sfml_clock_allocate(out @this)
      SFMLExt.sfml_clock_initialize_LuC(to_unsafe, copy)
    end
    def dup() : Clock
      return Clock.new(self)
    end
  end
  SFMLExt.sfml_inputstream_read_callback(->(self : Void*, data : Void*, size : Int64, result : Int64*) {
    output = self.as(InputStream).read(Slice(UInt8).new(data.as(UInt8*), size))
    result.value = Int64.new(output)
  })
  SFMLExt.sfml_inputstream_seek_callback(->(self : Void*, position : Int64, result : Int64*) {
    output = self.as(InputStream).seek(position)
    result.value = Int64.new(output)
  })
  SFMLExt.sfml_inputstream_tell_callback(->(self : Void*, result : Int64*) {
    output = self.as(InputStream).tell()
    result.value = Int64.new(output)
  })
  SFMLExt.sfml_inputstream_getsize_callback(->(self : Void*, result : Int64*) {
    output = self.as(InputStream).size()
    result.value = Int64.new(output)
  })
  # Abstract class for custom file input streams
  #
  # This class allows users to define their own file input sources
  # from which SFML can load resources.
  #
  # SFML resource classes like `SF::Texture` and
  # `SF::SoundBuffer` provide load_from_file and load_from_memory functions,
  # which read data from conventional sources. However, if you
  # have data coming from a different source (over a network,
  # embedded, encrypted, compressed, etc) you can derive your
  # own class from `SF::InputStream` and load SFML resources with
  # their load_from_stream function.
  #
  # Usage example:
  # ```crystal
  # # custom stream class that reads from inside a zip file
  # class ZipStream < SF::InputStream
  #   def initialize(archive : String)
  #   end
  #
  #   def open(filename : String)
  #   end
  #
  #   def read(data : Slice) : Int64
  #   end
  #
  #   def seek(position : Int) : Int64
  #   end
  #
  #   def tell : Int64
  #   end
  #
  #   def size : Int64
  #   end
  #
  #   # [...]
  # end
  #
  # # now you can load textures...
  # stream = ZipStream.new("resources.zip")
  # stream.open("images/img.png")
  # texture = SF::Texture.from_stream(stream)
  #
  # # musics...
  # stream = ZipStream.new("resources.zip")
  # stream.open("musics/msc.ogg")
  # music = SF::Music.from_stream(stream)
  #
  # # etc.
  # ```
  abstract class InputStream
    @this : Void*
    def initialize()
      SFMLExt.sfml_inputstream_allocate(out @this)
      SFMLExt.sfml_inputstream_initialize(to_unsafe)
      SFMLExt.sfml_inputstream_parent(@this, self.as(Void*))
    end
    def finalize()
      SFMLExt.sfml_inputstream_finalize(to_unsafe)
      SFMLExt.sfml_inputstream_free(@this)
    end
    # Read data from the stream
    #
    # After reading, the stream's reading position must be
    # advanced by the amount of bytes read.
    #
    # * *data* - Buffer where to copy the read data
    #
    # *Returns:* The number of bytes actually read, or -1 on error
    abstract def read(data : Slice) : Int64
    # Change the current reading position
    #
    # * *position* - The position to seek to, from the beginning
    #
    # *Returns:* The position actually sought to, or -1 on error
    abstract def seek(position : Int) : Int64
    # Get the current reading position in the stream
    #
    # *Returns:* The current position, or -1 on error.
    abstract def tell() : Int64
    # Return the size of the stream
    #
    # *Returns:* The total number of bytes available in the stream, or -1 on error
    abstract def size() : Int64
    # :nodoc:
    def to_unsafe()
      @this
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
  end
  # Empty module that indicates the objects of the class can't be copied
  module NonCopyable
  end
  # Implementation of input stream based on a file
  #
  # This class is a specialization of `InputStream` that
  # reads from a file on disk.
  #
  # It wraps a file in the common `InputStream` interface
  # and therefore allows to use generic classes or functions
  # that accept such a stream, with a file on disk as the data
  # source.
  #
  # In addition to the virtual functions inherited from
  # `InputStream`, `FileInputStream` adds a function to
  # specify the file to open.
  #
  # SFML resource classes can usually be loaded directly from
  # a filename, so this class shouldn't be useful to you unless
  # you create your own algorithms that operate on an `InputStream`
  #
  # Usage example:
  # ```crystal
  # def process(stream : InputStream)
  # end
  #
  # stream = SF::FileInputStream.open("some_file.dat")
  # process(stream)
  # ```
  #
  # See also: `InputStream`, `MemoryInputStream`
  class FileInputStream < InputStream
    @this : Void*
    # Default constructor
    def initialize()
      SFMLExt.sfml_fileinputstream_allocate(out @this)
      SFMLExt.sfml_fileinputstream_initialize(to_unsafe)
    end
    # Default destructor
    def finalize()
      SFMLExt.sfml_fileinputstream_finalize(to_unsafe)
      SFMLExt.sfml_fileinputstream_free(@this)
    end
    # Open the stream from a file path
    #
    # * *filename* - Name of the file to open
    #
    # *Returns:* True on success, false on error
    def open(filename : String) : Bool
      SFMLExt.sfml_fileinputstream_open_zkC(to_unsafe, filename.bytesize, filename, out result)
      return result
    end
    # Shorthand for `file_input_stream = FileInputStream.new; file_input_stream.open(...); file_input_stream`
    #
    # Raises `InitError` on failure
    def self.open(*args, **kwargs) : self
      obj = new
      if !obj.open(*args, **kwargs)
        raise InitError.new("FileInputStream.open failed")
      end
      obj
    end
    # Read data from the stream
    #
    # After reading, the stream's reading position must be
    # advanced by the amount of bytes read.
    #
    # * *data* - Buffer where to copy the read data
    #
    # *Returns:* The number of bytes actually read, or -1 on error
    def read(data : Slice) : Int64
      SFMLExt.sfml_fileinputstream_read_xALG4x(to_unsafe, data, data.bytesize, out result)
      return result
    end
    # Change the current reading position
    #
    # * *position* - The position to seek to, from the beginning
    #
    # *Returns:* The position actually sought to, or -1 on error
    def seek(position : Int) : Int64
      SFMLExt.sfml_fileinputstream_seek_G4x(to_unsafe, Int64.new(position), out result)
      return result
    end
    # Get the current reading position in the stream
    #
    # *Returns:* The current position, or -1 on error.
    def tell() : Int64
      SFMLExt.sfml_fileinputstream_tell(to_unsafe, out result)
      return result
    end
    # Return the size of the stream
    #
    # *Returns:* The total number of bytes available in the stream, or -1 on error
    def size() : Int64
      SFMLExt.sfml_fileinputstream_getsize(to_unsafe, out result)
      return result
    end
    include NonCopyable
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
  end
  # Implementation of input stream based on a memory chunk
  #
  # This class is a specialization of `InputStream` that
  # reads from data in memory.
  #
  # It wraps a memory chunk in the common `InputStream` interface
  # and therefore allows to use generic classes or functions
  # that accept such a stream, with content already loaded in memory.
  #
  # In addition to the virtual functions inherited from
  # `InputStream`, `MemoryInputStream` adds a function to
  # specify the pointer and size of the data in memory.
  #
  # SFML resource classes can usually be loaded directly from
  # memory, so this class shouldn't be useful to you unless
  # you create your own algorithms that operate on an InputStream.
  #
  # Usage example:
  # ```crystal
  # def process(stream : InputStream)
  # end
  #
  # stream = SF::MemoryInputStream.open(slice)
  # process(stream)
  # ```
  #
  # See also: `InputStream`, `FileInputStream`
  class MemoryInputStream < InputStream
    @this : Void*
    def finalize()
      SFMLExt.sfml_memoryinputstream_finalize(to_unsafe)
      SFMLExt.sfml_memoryinputstream_free(@this)
    end
    # Default constructor
    def initialize()
      SFMLExt.sfml_memoryinputstream_allocate(out @this)
      SFMLExt.sfml_memoryinputstream_initialize(to_unsafe)
    end
    # Open the stream from its data
    #
    # * *data* - Pointer to the data in memory
    def open(data : Slice)
      SFMLExt.sfml_memoryinputstream_open_5h8vgv(to_unsafe, data, data.bytesize)
    end
    # Shorthand for `memory_input_stream = MemoryInputStream.new; memory_input_stream.open(...); memory_input_stream`
    def self.open(*args, **kwargs) : self
      obj = new
      obj.open(*args, **kwargs)
      obj
    end
    # Read data from the stream
    #
    # After reading, the stream's reading position must be
    # advanced by the amount of bytes read.
    #
    # * *data* - Buffer where to copy the read data
    #
    # *Returns:* The number of bytes actually read, or -1 on error
    def read(data : Slice) : Int64
      SFMLExt.sfml_memoryinputstream_read_xALG4x(to_unsafe, data, data.bytesize, out result)
      return result
    end
    # Change the current reading position
    #
    # * *position* - The position to seek to, from the beginning
    #
    # *Returns:* The position actually sought to, or -1 on error
    def seek(position : Int) : Int64
      SFMLExt.sfml_memoryinputstream_seek_G4x(to_unsafe, Int64.new(position), out result)
      return result
    end
    # Get the current reading position in the stream
    #
    # *Returns:* The current position, or -1 on error.
    def tell() : Int64
      SFMLExt.sfml_memoryinputstream_tell(to_unsafe, out result)
      return result
    end
    # Return the size of the stream
    #
    # *Returns:* The total number of bytes available in the stream, or -1 on error
    def size() : Int64
      SFMLExt.sfml_memoryinputstream_getsize(to_unsafe, out result)
      return result
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
    # :nodoc:
    def initialize(copy : MemoryInputStream)
      SFMLExt.sfml_memoryinputstream_allocate(out @this)
      SFMLExt.sfml_memoryinputstream_initialize_kYd(to_unsafe, copy)
    end
    def dup() : MemoryInputStream
      return MemoryInputStream.new(self)
    end
  end
  # Blocks concurrent access to shared resources
  # from multiple threads
  #
  # Mutex stands for "MUTual EXclusion". A mutex is a
  # synchronization object, used when multiple threads are involved.
  #
  # When you want to protect a part of the code from being accessed
  # simultaneously by multiple threads, you typically use a
  # mutex. When a thread is locked by a mutex, any other thread
  # trying to lock it will be blocked until the mutex is released
  # by the thread that locked it. This way, you can allow only
  # one thread at a time to access a critical region of your code.
  #
  # Usage example:
  # ```crystal
  # @database = Database.new # this is a critical resource that needs some protection
  # @mutex = SF::Mutex.new
  #
  # def thread1
  #   @mutex.lock # this call will block the thread if the mutex is already locked by thread2
  #   @database.write(...)
  #   @mutex.unlock # if thread2 was waiting, it will now be unblocked
  # end
  #
  # def thread2
  #   @mutex.lock # this call will block the thread if the mutex is already locked by thread1
  #   @database.write(...)
  #   @mutex.unlock # if thread1 was waiting, it will now be unblocked
  # end
  # ```
  #
  # Be very careful with mutexes. A bad usage can lead to bad problems,
  # like deadlocks (two threads are waiting for each other and the
  # application is globally stuck).
  #
  # To make the usage of mutexes more robust, particularly in
  # environments where exceptions can be thrown, you should
  # use the helper method `synchronize` to lock/unlock mutexes.
  #
  # SFML mutexes are recursive, which means that you can lock
  # a mutex multiple times in the same thread without creating
  # a deadlock. In this case, the first call to `lock()` behaves
  # as usual, and the following ones have no effect.
  # However, you must call `unlock()` exactly as many times as you
  # called `lock()`. If you don't, the mutex won't be released.
  # However, you must call unlock() exactly as many times as you
  # called lock(). If you don't, the mutex won't be released.
  #
  # *See also:* `SF::Lock`
  class Mutex
    @this : Void*
    # Default constructor
    def initialize()
      SFMLExt.sfml_mutex_allocate(out @this)
      SFMLExt.sfml_mutex_initialize(to_unsafe)
    end
    # Destructor
    def finalize()
      SFMLExt.sfml_mutex_finalize(to_unsafe)
      SFMLExt.sfml_mutex_free(@this)
    end
    # Lock the mutex
    #
    # If the mutex is already locked in another thread,
    # this call will block the execution until the mutex
    # is released.
    #
    # *See also:* `unlock`
    def lock()
      SFMLExt.sfml_mutex_lock(to_unsafe)
    end
    # Unlock the mutex
    #
    # *See also:* `lock`
    def unlock()
      SFMLExt.sfml_mutex_unlock(to_unsafe)
    end
    include NonCopyable
    # :nodoc:
    def to_unsafe()
      @this
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
  end
  # Make the current thread sleep for a given duration
  #
  # `SF.sleep` is the best way to block a program or one of its
  # threads, as it doesn't consume any CPU power.
  #
  # * *duration* - Time to sleep
  def sleep(duration : Time)
    SFMLExt.sfml_sleep_f4T(duration)
  end
  # Utility class to manipulate threads
  #
  # Threads provide a way to run multiple parts of the code
  # in parallel. When you launch a new thread, the execution
  # is split and both the new thread and the caller run
  # in parallel.
  #
  # To use a `SF::Thread`, you construct it directly with the
  # function to execute as the entry point of the thread.
  # `SF::Thread` has multiple template constructors, which means
  # that you can use several types of entry points:
  #
  # * non-member functions with no argument
  # * non-member functions with one argument of any type
  # * functors with no argument (this one is particularly useful for compatibility with boost/std::%bind)
  # * functors with one argument of any type
  # * member functions from any class with no argument
  #
  # The function argument, if any, is copied in the `SF::Thread`
  # instance, as well as the functor (if the corresponding
  # constructor is used). Class instances, however, are passed
  # by pointer so you must make sure that the object won't be
  # destroyed while the thread is still using it.
  #
  # The thread ends when its function is terminated. If the
  # owner `SF::Thread` instance is destroyed before the
  # thread is finished, the destructor will wait (see `wait()`)
  #
  # Usage examples:
  # ```c++
  # # example 1: non member function with one argument
  #
  # void threadFunc(int argument)
  #     // [...]
  # end
  #
  # thread = SF::Thread.new(&threadFunc, 5)
  # thread.launch() # start the thread (internally calls threadFunc(5))
  # ```
  #
  # ```c++
  # # example 2: member function
  #
  # class Task
  # public:
  #     void run()
  #         // [...]
  #     end
  # end
  #
  # Task task
  # thread = SF::Thread.new(&Task.run, &task)
  # thread.launch() # start the thread (internally calls task.run())
  # ```
  #
  # ```c++
  # # example 3: functor
  #
  # struct Task
  #     void operator()()
  #         // [...]
  #     end
  # end
  #
  # thread = SF::Thread.new(Task())
  # thread.launch() # start the thread (internally calls operator() on the Task instance)
  # ```
  #
  # Creating parallel threads of execution can be dangerous:
  # all threads inside the same process share the same memory space,
  # which means that you may end up accessing the same variable
  # from multiple threads at the same time. To prevent this
  # kind of situations, you can use mutexes (see `SF::Mutex`).
  #
  # *See also:* `SF::Mutex`
  class Thread
    @this : Void*
    # Construct the thread from a functor with an argument
    #
    # This constructor works for function objects, as well
    # as free functions.
    # It is a template, which means that the argument can
    # have any type (int, std::string, void*, Toto, ...).
    #
    # Use this constructor for this kind of function:
    # ```c++
    # void function(int arg)
    #
    # # --- or ----
    #
    # struct Functor
    #     void operator()(std::string arg)
    # end
    # ```
    #
    # Note: this does *not* run the thread, use `launch()`.
    #
    # * *function* - Functor or free function to use as the entry point of the thread
    # * *argument* - argument to forward to the function
    def initialize(function : ->)
      SFMLExt.sfml_thread_allocate(out @this)
      @function = Box.box(function)
      SFMLExt.sfml_thread_initialize_XPcbdx(to_unsafe, ->(argument) { Box(->).unbox(argument).call }, @function)
    end
    # Destructor
    #
    # This destructor calls `wait()`, so that the internal thread
    # cannot survive after its `SF::Thread` instance is destroyed.
    def finalize()
      SFMLExt.sfml_thread_finalize(to_unsafe)
      SFMLExt.sfml_thread_free(@this)
    end
    # Run the thread
    #
    # This function starts the entry point passed to the
    # thread's constructor, and returns immediately.
    # After this function returns, the thread's function is
    # running in parallel to the calling code.
    def launch()
      SFMLExt.sfml_thread_launch(to_unsafe)
    end
    # Wait until the thread finishes
    #
    # This function will block the execution until the
    # thread's function ends.
    #
    # WARNING: If the thread function never ends, the calling
    # thread will block forever.
    # If this function is called from its owner thread, it
    # returns without doing anything.
    def wait()
      SFMLExt.sfml_thread_wait(to_unsafe)
    end
    # Terminate the thread
    #
    # This function immediately stops the thread, without waiting
    # for its function to finish.
    # Terminating a thread with this function is not safe,
    # and can lead to local variables not being destroyed
    # on some operating systems. You should rather try to make
    # the thread function terminate by itself.
    def terminate()
      SFMLExt.sfml_thread_terminate(to_unsafe)
    end
    include NonCopyable
    # :nodoc:
    def to_unsafe()
      @this
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
  end
  SFMLExt.sfml_system_version(out major, out minor, out patch)
  if SFML_VERSION != (ver = "#{major}.#{minor}.#{patch}")
    STDERR.puts "Warning: CrSFML was built for SFML #{SFML_VERSION}, found SFML #{ver}"
  end
end
