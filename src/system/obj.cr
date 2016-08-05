require "./lib"
require "../common"
module SF
  extend self
  # Represents a time value
  #
  #
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
  # ```c++
  # sf::Time t1 = sf::seconds(0.1f);
  # Int32 milli = t1.asMilliseconds(); // 100
  #
  # sf::Time t2 = sf::milliseconds(30);
  # Int64 micro = t2.asMicroseconds(); // 30000
  #
  # sf::Time t3 = sf::microseconds(-800000);
  # float sec = t3.asSeconds(); // -0.8
  # ```
  #
  # ```c++
  # void update(sf::Time elapsed)
  # {
  #    position += speed * elapsed.asSeconds();
  # }
  #
  # update(sf::milliseconds(100));
  # ```
  #
  # *See also:* `SF::Clock`
  struct Time
    @m_microseconds : Int64
    # Default constructor
    #
    # Sets the time value to zero.
    def initialize()
      @m_microseconds = uninitialized Int64
      VoidCSFML.time_initialize(to_unsafe)
    end
    # Return the time value as a number of seconds
    #
    # *Returns:* Time in seconds
    #
    # *See also:* asMilliseconds, asMicroseconds
    def as_seconds() : Float32
      VoidCSFML.time_asseconds(to_unsafe, out result)
      return result
    end
    # Return the time value as a number of milliseconds
    #
    # *Returns:* Time in milliseconds
    #
    # *See also:* asSeconds, asMicroseconds
    def as_milliseconds() : Int32
      VoidCSFML.time_asmilliseconds(to_unsafe, out result)
      return result
    end
    # Return the time value as a number of microseconds
    #
    # *Returns:* Time in microseconds
    #
    # *See also:* asSeconds, asMilliseconds
    def as_microseconds() : Int64
      VoidCSFML.time_asmicroseconds(to_unsafe, out result)
      return result
    end
    @m_microseconds : Int64
    #
    # Overload of == operator to compare two time values
    #
    # * *left* -  Left operand (a time)
    # * *right* - Right operand (a time)
    #
    # *Returns:* True if both time values are equal
    def ==(right : Time) : Bool
      VoidCSFML.operator_eq_f4Tf4T(to_unsafe, right, out result)
      return result
    end
    #
    # Overload of != operator to compare two time values
    #
    # * *left* -  Left operand (a time)
    # * *right* - Right operand (a time)
    #
    # *Returns:* True if both time values are different
    def !=(right : Time) : Bool
      VoidCSFML.operator_ne_f4Tf4T(to_unsafe, right, out result)
      return result
    end
    #
    # Overload of &lt; operator to compare two time values
    #
    # * *left* -  Left operand (a time)
    # * *right* - Right operand (a time)
    #
    # *Returns:* True if *left* is lesser than *right*
    def <(right : Time) : Bool
      VoidCSFML.operator_lt_f4Tf4T(to_unsafe, right, out result)
      return result
    end
    #
    # Overload of &gt; operator to compare two time values
    #
    # * *left* -  Left operand (a time)
    # * *right* - Right operand (a time)
    #
    # *Returns:* True if *left* is greater than *right*
    def >(right : Time) : Bool
      VoidCSFML.operator_gt_f4Tf4T(to_unsafe, right, out result)
      return result
    end
    #
    # Overload of &lt;= operator to compare two time values
    #
    # * *left* -  Left operand (a time)
    # * *right* - Right operand (a time)
    #
    # *Returns:* True if *left* is lesser or equal than *right*
    def <=(right : Time) : Bool
      VoidCSFML.operator_le_f4Tf4T(to_unsafe, right, out result)
      return result
    end
    #
    # Overload of &gt;= operator to compare two time values
    #
    # * *left* -  Left operand (a time)
    # * *right* - Right operand (a time)
    #
    # *Returns:* True if *left* is greater or equal than *right*
    def >=(right : Time) : Bool
      VoidCSFML.operator_ge_f4Tf4T(to_unsafe, right, out result)
      return result
    end
    #
    # Overload of unary - operator to negate a time value
    #
    # * *right* - Right operand (a time)
    #
    # *Returns:* Opposite of the time value
    def -() : Time
      result = Time.allocate
      VoidCSFML.operator_sub_f4T(to_unsafe, result)
      return result
    end
    #
    # Overload of binary + operator to add two time values
    #
    # * *left* -  Left operand (a time)
    # * *right* - Right operand (a time)
    #
    # *Returns:* Sum of the two times values
    def +(right : Time) : Time
      result = Time.allocate
      VoidCSFML.operator_add_f4Tf4T(to_unsafe, right, result)
      return result
    end
    #
    # Overload of binary - operator to subtract two time values
    #
    # * *left* -  Left operand (a time)
    # * *right* - Right operand (a time)
    #
    # *Returns:* Difference of the two times values
    def -(right : Time) : Time
      result = Time.allocate
      VoidCSFML.operator_sub_f4Tf4T(to_unsafe, right, result)
      return result
    end
    #
    # Overload of binary * operator to scale a time value
    #
    # * *left* -  Left operand (a time)
    # * *right* - Right operand (a number)
    #
    # *Returns:* *left* multiplied by *right*
    def *(right : Number) : Time
      result = Time.allocate
      VoidCSFML.operator_mul_f4TBw9(to_unsafe, LibC::Float.new(right), result)
      return result
    end
    #
    # Overload of binary * operator to scale a time value
    #
    # * *left* -  Left operand (a time)
    # * *right* - Right operand (a number)
    #
    # *Returns:* *left* multiplied by *right*
    def *(right : Int64) : Time
      result = Time.allocate
      VoidCSFML.operator_mul_f4TG4x(to_unsafe, right, result)
      return result
    end
    #
    # Overload of binary / operator to scale a time value
    #
    # * *left* -  Left operand (a time)
    # * *right* - Right operand (a number)
    #
    # *Returns:* *left* divided by *right*
    def /(right : Number) : Time
      result = Time.allocate
      VoidCSFML.operator_div_f4TBw9(to_unsafe, LibC::Float.new(right), result)
      return result
    end
    #
    # Overload of binary / operator to scale a time value
    #
    # * *left* -  Left operand (a time)
    # * *right* - Right operand (a number)
    #
    # *Returns:* *left* divided by *right*
    def /(right : Int64) : Time
      result = Time.allocate
      VoidCSFML.operator_div_f4TG4x(to_unsafe, right, result)
      return result
    end
    #
    # Overload of binary / operator to compute the ratio of two time values
    #
    # * *left* -  Left operand (a time)
    # * *right* - Right operand (a time)
    #
    # *Returns:* *left* divided by *right*
    def /(right : Time) : Float32
      VoidCSFML.operator_div_f4Tf4T(to_unsafe, right, out result)
      return result
    end
    #
    # Overload of binary % operator to compute remainder of a time value
    #
    # * *left* -  Left operand (a time)
    # * *right* - Right operand (a time)
    #
    # *Returns:* *left* modulo *right*
    def %(right : Time) : Time
      result = Time.allocate
      VoidCSFML.operator_mod_f4Tf4T(to_unsafe, right, result)
      return result
    end
    # :nodoc:
    def to_unsafe()
      pointerof(@m_microseconds).as(Void*)
    end
    # :nodoc:
    def initialize(copy : Time)
      @m_microseconds = uninitialized Int64
      as(Void*).copy_from(copy.as(Void*), instance_sizeof(typeof(self)))
      VoidCSFML.time_initialize_PxG(to_unsafe, copy)
    end
    def dup() : self
      return typeof(self).new(self)
    end
  end
  #
  # Construct a time value from a number of seconds
  #
  # * *amount* - Number of seconds
  #
  # *Returns:* Time value constructed from the amount of seconds
  #
  # *See also:* milliseconds, microseconds
  def seconds(amount : Number) : Time
    result = Time.allocate
    VoidCSFML.seconds_Bw9(LibC::Float.new(amount), result)
    return result
  end
  #
  # Construct a time value from a number of milliseconds
  #
  # * *amount* - Number of milliseconds
  #
  # *Returns:* Time value constructed from the amount of milliseconds
  #
  # *See also:* seconds, microseconds
  def milliseconds(amount : Int32) : Time
    result = Time.allocate
    VoidCSFML.milliseconds_qe2(amount, result)
    return result
  end
  #
  # Construct a time value from a number of microseconds
  #
  # * *amount* - Number of microseconds
  #
  # *Returns:* Time value constructed from the amount of microseconds
  #
  # *See also:* seconds, milliseconds
  def microseconds(amount : Int64) : Time
    result = Time.allocate
    VoidCSFML.microseconds_G4x(amount, result)
    return result
  end
  # Utility class that measures the elapsed time
  #
  #
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
  # ```c++
  # sf::Clock clock;
  # ...
  # Time time1 = clock.getElapsedTime();
  # ...
  # Time time2 = clock.restart();
  # ```
  #
  # The `SF::Time` value returned by the clock can then be
  # converted to a number of seconds, milliseconds or even
  # microseconds.
  #
  # *See also:* `SF::Time`
  class Clock
    @_clock : VoidCSFML::Clock_Buffer = VoidCSFML::Clock_Buffer.new(0u8)
    # Default constructor
    #
    # The clock starts automatically after being constructed.
    def initialize()
      @_clock = uninitialized VoidCSFML::Clock_Buffer
      VoidCSFML.clock_initialize(to_unsafe)
    end
    # Get the elapsed time
    #
    # This function returns the time elapsed since the last call
    # to restart() (or the construction of the instance if restart()
    # has not been called).
    #
    # *Returns:* Time elapsed
    def elapsed_time() : Time
      result = Time.allocate
      VoidCSFML.clock_getelapsedtime(to_unsafe, result)
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
      VoidCSFML.clock_restart(to_unsafe, result)
      return result
    end
    # :nodoc:
    def to_unsafe()
      pointerof(@_clock).as(Void*)
    end
    # :nodoc:
    def initialize(copy : Clock)
      @_clock = uninitialized VoidCSFML::Clock_Buffer
      as(Void*).copy_from(copy.as(Void*), instance_sizeof(typeof(self)))
      VoidCSFML.clock_initialize_LuC(to_unsafe, copy)
    end
    def dup() : self
      return typeof(self).new(self)
    end
  end
  VoidCSFML.inputstream_read_callback = ->(self : Void*, data : Void*, size : Int64, result : Int64*) {
    output = (self - 4).as(Union(InputStream)).read(Slice(UInt8).new(data.as(UInt8*), size))
    result.value = Int64.new(output)
  }
  VoidCSFML.inputstream_seek_callback = ->(self : Void*, position : Int64, result : Int64*) {
    output = (self - 4).as(Union(InputStream)).seek(position)
    result.value = Int64.new(output)
  }
  VoidCSFML.inputstream_tell_callback = ->(self : Void*, result : Int64*) {
    output = (self - 4).as(Union(InputStream)).tell()
    result.value = Int64.new(output)
  }
  VoidCSFML.inputstream_getsize_callback = ->(self : Void*, result : Int64*) {
    output = (self - 4).as(Union(InputStream)).size()
    result.value = Int64.new(output)
  }
  # Abstract class for custom file input streams
  #
  #
  #
  # This class allows users to define their own file input sources
  # from which SFML can load resources.
  #
  # SFML resource classes like `SF::Texture` and
  # `SF::SoundBuffer` provide loadFromFile and loadFromMemory functions,
  # which read data from conventional sources. However, if you
  # have data coming from a different source (over a network,
  # embedded, encrypted, compressed, etc) you can derive your
  # own class from `SF::InputStream` and load SFML resources with
  # their loadFromStream function.
  #
  # Usage example:
  # ```c++
  # // custom stream class that reads from inside a zip file
  # class ZipStream : public sf::InputStream
  # {
  # public:
  #
  #     ZipStream(std::string archive);
  #
  #     bool open(std::string filename);
  #
  #     Int64 read(void* data, Int64 size);
  #
  #     Int64 seek(Int64 position);
  #
  #     Int64 tell();
  #
  #     Int64 getSize();
  #
  # private:
  #
  #     ...
  # };
  #
  # // now you can load textures...
  # sf::Texture texture;
  # ZipStream stream("resources.zip");
  # stream.open("images/img.png");
  # texture.loadFromStream(stream);
  #
  # // musics...
  # sf::Music music;
  # ZipStream stream("resources.zip");
  # stream.open("musics/msc.ogg");
  # music.openFromStream(stream);
  #
  # // etc.
  # ```
  abstract class InputStream
    @_inputstream : VoidCSFML::InputStream_Buffer = VoidCSFML::InputStream_Buffer.new(0u8)
    def initialize()
      @_inputstream = uninitialized VoidCSFML::InputStream_Buffer
      {% if !flag?(:release) %}
      raise "Unexpected memory layout" if as(Void*) + 4 != to_unsafe
      {% end %} #}
      VoidCSFML.inputstream_initialize(to_unsafe)
    end
    # Virtual destructor
    #
    # Read data from the stream
    #
    # After reading, the stream's reading position must be
    # advanced by the amount of bytes read.
    #
    # * *data* - Buffer where to copy the read data
    # * *size* - Desired number of bytes to read
    #
    # *Returns:* The number of bytes actually read, or -1 on error
    abstract def read(data : Slice) : Int64
    # Change the current reading position
    #
    # * *position* - The position to seek to, from the beginning
    #
    # *Returns:* The position actually sought to, or -1 on error
    abstract def seek(position : Int64) : Int64
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
      pointerof(@_inputstream).as(Void*)
    end
    # :nodoc:
    def initialize(copy : InputStream)
      @_inputstream = uninitialized VoidCSFML::InputStream_Buffer
      {% if !flag?(:release) %}
      raise "Unexpected memory layout" if as(Void*) + 4 != to_unsafe
      {% end %} #}
      as(Void*).copy_from(copy.as(Void*), instance_sizeof(typeof(self)))
      VoidCSFML.inputstream_initialize_mua(to_unsafe, copy)
    end
    def dup() : self
      return typeof(self).new(self)
    end
  end
  # Utility class that makes any derived
  #        class non-copyable
  #
  #
  #
  # This class makes its instances non-copyable, by explicitly
  # disabling its copy constructor and its assignment operator.
  #
  # To create a non-copyable class, simply inherit from
  # `SF::NonCopyable`.
  #
  # The type of inheritance (public or private) doesn't matter,
  # the copy constructor and assignment operator are declared private
  # in `SF::NonCopyable` so they will end up being inaccessible in both
  # cases. Thus you can use a shorter syntax for inheriting from it
  # (see below).
  #
  # Usage example:
  # ```c++
  # class MyNonCopyableClass : sf::NonCopyable
  # {
  #     ...
  # };
  # ```
  #
  # Deciding whether the instances of a class can be copied
  # or not is a very important design choice. You are strongly
  # encouraged to think about it before writing a class,
  # and to use `SF::NonCopyable` when necessary to prevent
  # many potential future errors when using it. This is also
  # a very important indication to users of your class.
  module NonCopyable
  end
  # Implementation of input stream based on a file
  #
  #
  #
  # This class is a specialization of InputStream that
  # reads from a file on disk.
  #
  # It wraps a file in the common InputStream interface
  # and therefore allows to use generic classes or functions
  # that accept such a stream, with a file on disk as the data
  # source.
  #
  # In addition to the virtual functions inherited from
  # InputStream, FileInputStream adds a function to
  # specify the file to open.
  #
  # SFML resource classes can usually be loaded directly from
  # a filename, so this class shouldn't be useful to you unless
  # you create your own algorithms that operate on a InputStream.
  #
  # Usage example:
  # ```c++
  # void process(InputStream& stream);
  #
  # FileStream stream;
  # if (stream.open("some_file.dat"))
  #    process(stream);
  # ```
  #
  # InputStream, MemoryStream
  class FileInputStream < InputStream
    @_fileinputstream : VoidCSFML::FileInputStream_Buffer = VoidCSFML::FileInputStream_Buffer.new(0u8)
    # Default constructor
    def initialize()
      @_inputstream = uninitialized VoidCSFML::InputStream_Buffer
      @_fileinputstream = uninitialized VoidCSFML::FileInputStream_Buffer
      VoidCSFML.fileinputstream_initialize(to_unsafe)
    end
    # Default destructor
    def finalize()
      VoidCSFML.fileinputstream_finalize(to_unsafe)
    end
    # Open the stream from a file path
    #
    # * *filename* - Name of the file to open
    #
    # *Returns:* True on success, false on error
    def open(filename : String) : Bool
      VoidCSFML.fileinputstream_open_zkC(to_unsafe, filename.bytesize, filename, out result)
      return result
    end
    # Read data from the stream
    #
    # After reading, the stream's reading position must be
    # advanced by the amount of bytes read.
    #
    # * *data* - Buffer where to copy the read data
    # * *size* - Desired number of bytes to read
    #
    # *Returns:* The number of bytes actually read, or -1 on error
    def read(data : Slice) : Int64
      VoidCSFML.fileinputstream_read_xALG4x(to_unsafe, data, data.bytesize, out result)
      return result
    end
    # Change the current reading position
    #
    # * *position* - The position to seek to, from the beginning
    #
    # *Returns:* The position actually sought to, or -1 on error
    def seek(position : Int64) : Int64
      VoidCSFML.fileinputstream_seek_G4x(to_unsafe, position, out result)
      return result
    end
    # Get the current reading position in the stream
    #
    # *Returns:* The current position, or -1 on error.
    def tell() : Int64
      VoidCSFML.fileinputstream_tell(to_unsafe, out result)
      return result
    end
    # Return the size of the stream
    #
    # *Returns:* The total number of bytes available in the stream, or -1 on error
    def size() : Int64
      VoidCSFML.fileinputstream_getsize(to_unsafe, out result)
      return result
    end
    include NonCopyable
    # :nodoc:
    def to_unsafe()
      pointerof(@_inputstream).as(Void*)
    end
  end
  # Automatic wrapper for locking and unlocking mutexes
  #
  #
  #
  # `SF::Lock` is a RAII wrapper for `SF::Mutex`. By unlocking
  # it in its destructor, it ensures that the mutex will
  # always be released when the current scope (most likely
  # a function) ends.
  # This is even more important when an exception or an early
  # return statement can interrupt the execution flow of the
  # function.
  #
  # For maximum robustness, `SF::Lock` should always be used
  # to lock/unlock a mutex.
  #
  # Usage example:
  # ```c++
  # sf::Mutex mutex;
  #
  # void function()
  # {
  #     sf::Lock lock(mutex); // mutex is now locked
  #
  #     functionThatMayThrowAnException(); // mutex is unlocked if this function throws
  #
  #     if (someCondition)
  #         return; // mutex is unlocked
  #
  # } // mutex is unlocked
  # ```
  #
  # Because the mutex is not explicitly unlocked in the code,
  # it may remain locked longer than needed. If the region
  # of the code that needs to be protected by the mutex is
  # not the entire function, a good practice is to create a
  # smaller, inner scope so that the lock is limited to this
  # part of the code.
  #
  # ```c++
  # sf::Mutex mutex;
  #
  # void function()
  # {
  #     {
  #       sf::Lock lock(mutex);
  #       codeThatRequiresProtection();
  #
  #     } // mutex is unlocked here
  #
  #     codeThatDoesntCareAboutTheMutex();
  # }
  # ```
  #
  # Having a mutex locked longer than required is a bad practice
  # which can lead to bad performances. Don't forget that when
  # a mutex is locked, other threads may be waiting doing nothing
  # until it is released.
  #
  # *See also:* `SF::Mutex`
  class Lock
    @_lock : VoidCSFML::Lock_Buffer = VoidCSFML::Lock_Buffer.new(0u8)
    # Construct the lock with a target mutex
    #
    # The mutex passed to `SF::Lock` is automatically locked.
    #
    # * *mutex* - Mutex to lock
    def initialize() : Mutex
      @_lock = uninitialized VoidCSFML::Lock_Buffer
      VoidCSFML.lock_initialize_D4m(to_unsafe, mutex)
      return mutex
    end
    # Destructor
    #
    # The destructor of `SF::Lock` automatically unlocks its mutex.
    def finalize()
      VoidCSFML.lock_finalize(to_unsafe)
    end
    include NonCopyable
    # :nodoc:
    def to_unsafe()
      pointerof(@_lock).as(Void*)
    end
  end
  # Implementation of input stream based on a memory chunk
  #
  #
  #
  # This class is a specialization of InputStream that
  # reads from data in memory.
  #
  # It wraps a memory chunk in the common InputStream interface
  # and therefore allows to use generic classes or functions
  # that accept such a stream, with content already loaded in memory.
  #
  # In addition to the virtual functions inherited from
  # InputStream, MemoryInputStream adds a function to
  # specify the pointer and size of the data in memory.
  #
  # SFML resource classes can usually be loaded directly from
  # memory, so this class shouldn't be useful to you unless
  # you create your own algorithms that operate on a InputStream.
  #
  # Usage example:
  # ```c++
  # void process(InputStream& stream);
  #
  # MemoryStream stream;
  # stream.open(thePtr, theSize);
  # process(stream);
  # ```
  #
  # InputStream, FileStream
  class MemoryInputStream < InputStream
    @_memoryinputstream : VoidCSFML::MemoryInputStream_Buffer = VoidCSFML::MemoryInputStream_Buffer.new(0u8)
    # Default constructor
    def initialize()
      @_inputstream = uninitialized VoidCSFML::InputStream_Buffer
      @_memoryinputstream = uninitialized VoidCSFML::MemoryInputStream_Buffer
      VoidCSFML.memoryinputstream_initialize(to_unsafe)
    end
    # Open the stream from its data
    #
    # * *data* -        Pointer to the data in memory
    # * *size_in_bytes* - Size of the data, in bytes
    def open(data : Slice)
      VoidCSFML.memoryinputstream_open_5h8vgv(to_unsafe, data, data.bytesize)
    end
    # Read data from the stream
    #
    # After reading, the stream's reading position must be
    # advanced by the amount of bytes read.
    #
    # * *data* - Buffer where to copy the read data
    # * *size* - Desired number of bytes to read
    #
    # *Returns:* The number of bytes actually read, or -1 on error
    def read(data : Slice) : Int64
      VoidCSFML.memoryinputstream_read_xALG4x(to_unsafe, data, data.bytesize, out result)
      return result
    end
    # Change the current reading position
    #
    # * *position* - The position to seek to, from the beginning
    #
    # *Returns:* The position actually sought to, or -1 on error
    def seek(position : Int64) : Int64
      VoidCSFML.memoryinputstream_seek_G4x(to_unsafe, position, out result)
      return result
    end
    # Get the current reading position in the stream
    #
    # *Returns:* The current position, or -1 on error.
    def tell() : Int64
      VoidCSFML.memoryinputstream_tell(to_unsafe, out result)
      return result
    end
    # Return the size of the stream
    #
    # *Returns:* The total number of bytes available in the stream, or -1 on error
    def size() : Int64
      VoidCSFML.memoryinputstream_getsize(to_unsafe, out result)
      return result
    end
    # :nodoc:
    def to_unsafe()
      pointerof(@_inputstream).as(Void*)
    end
    # :nodoc:
    def initialize(copy : MemoryInputStream)
      @_inputstream = uninitialized VoidCSFML::InputStream_Buffer
      @_memoryinputstream = uninitialized VoidCSFML::MemoryInputStream_Buffer
      as(Void*).copy_from(copy.as(Void*), instance_sizeof(typeof(self)))
      VoidCSFML.memoryinputstream_initialize_kYd(to_unsafe, copy)
    end
    def dup() : self
      return typeof(self).new(self)
    end
  end
  # Blocks concurrent access to shared resources
  #        from multiple threads
  #
  #
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
  # ```c++
  # Database database; // this is a critical resource that needs some protection
  # sf::Mutex mutex;
  #
  # void thread1()
  # {
  #     mutex.lock(); // this call will block the thread if the mutex is already locked by thread2
  #     database.write(...);
  #     mutex.unlock(); // if thread2 was waiting, it will now be unblocked
  # }
  #
  # void thread2()
  # {
  #     mutex.lock(); // this call will block the thread if the mutex is already locked by thread1
  #     database.write(...);
  #     mutex.unlock(); // if thread1 was waiting, it will now be unblocked
  # }
  # ```
  #
  # Be very careful with mutexes. A bad usage can lead to bad problems,
  # like deadlocks (two threads are waiting for each other and the
  # application is globally stuck).
  #
  # To make the usage of mutexes more robust, particularly in
  # environments where exceptions can be thrown, you should
  # use the helper class `SF::Lock` to lock/unlock mutexes.
  #
  # SFML mutexes are recursive, which means that you can lock
  # a mutex multiple times in the same thread without creating
  # a deadlock. In this case, the first call to lock() behaves
  # as usual, and the following ones have no effect.
  # However, you must call unlock() exactly as many times as you
  # called lock(). If you don't, the mutex won't be released.
  #
  # *See also:* `SF::Lock`
  class Mutex
    @_mutex : VoidCSFML::Mutex_Buffer = VoidCSFML::Mutex_Buffer.new(0u8)
    # Default constructor
    def initialize()
      @_mutex = uninitialized VoidCSFML::Mutex_Buffer
      VoidCSFML.mutex_initialize(to_unsafe)
    end
    # Destructor
    def finalize()
      VoidCSFML.mutex_finalize(to_unsafe)
    end
    # Lock the mutex
    #
    # If the mutex is already locked in another thread,
    # this call will block the execution until the mutex
    # is released.
    #
    # *See also:* unlock
    def lock()
      VoidCSFML.mutex_lock(to_unsafe)
    end
    # Unlock the mutex
    #
    # *See also:* lock
    def unlock()
      VoidCSFML.mutex_unlock(to_unsafe)
    end
    include NonCopyable
    # :nodoc:
    def to_unsafe()
      pointerof(@_mutex).as(Void*)
    end
  end
  #
  # Make the current thread sleep for a given duration
  #
  # `SF::sleep` is the best way to block a program or one of its
  # threads, as it doesn't consume any CPU power.
  #
  # * *duration* - Time to sleep
  def sleep(duration : Time)
    VoidCSFML.sleep_f4T(duration)
  end
  # Utility class to manipulate threads
  #
  #
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
  # thread is finished, the destructor will wait (see wait())
  #
  # Usage examples:
  # ```c++
  # // example 1: non member function with one argument
  #
  # void threadFunc(int argument)
  # {
  #     ...
  # }
  #
  # sf::Thread thread(&threadFunc, 5);
  # thread.launch(); // start the thread (internally calls threadFunc(5))
  # ```
  #
  # ```c++
  # // example 2: member function
  #
  # class Task
  # {
  # public:
  #     void run()
  #     {
  #         ...
  #     }
  # };
  #
  # Task task;
  # sf::Thread thread(&Task::run, &task);
  # thread.launch(); // start the thread (internally calls task.run())
  # ```
  #
  # ```c++
  # // example 3: functor
  #
  # struct Task
  # {
  #     void operator()()
  #     {
  #         ...
  #     }
  # };
  #
  # sf::Thread thread(Task());
  # thread.launch(); // start the thread (internally calls operator() on the Task instance)
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
    @_thread : VoidCSFML::Thread_Buffer = VoidCSFML::Thread_Buffer.new(0u8)
    # Construct the thread from a functor with an argument
    #
    # This constructor works for function objects, as well
    # as free functions.
    # It is a template, which means that the argument can
    # have any type (int, std::string, void*, Toto, ...).
    #
    # Use this constructor for this kind of function:
    # ```c++
    # void function(int arg);
    #
    # // --- or ----
    #
    # struct Functor
    # {
    #     void operator()(std::string arg);
    # };
    # ```
    # Note: this does *not* run the thread, use launch().
    #
    # * *function* - Functor or free function to use as the entry point of the thread
    # * *argument* - argument to forward to the function
    def initialize(function : ->)
      @_thread = uninitialized VoidCSFML::Thread_Buffer
      @function = Box.box(function)
      VoidCSFML.thread_initialize_XPcbdx(to_unsafe, ->(argument) { Box(->).unbox(argument).call }, @function)
    end
    # Destructor
    #
    # This destructor calls wait(), so that the internal thread
    # cannot survive after its `SF::Thread` instance is destroyed.
    def finalize()
      VoidCSFML.thread_finalize(to_unsafe)
    end
    # Run the thread
    #
    # This function starts the entry point passed to the
    # thread's constructor, and returns immediately.
    # After this function returns, the thread's function is
    # running in parallel to the calling code.
    def launch()
      VoidCSFML.thread_launch(to_unsafe)
    end
    # Wait until the thread finishes
    #
    # This function will block the execution until the
    # thread's function ends.
    # Warning: if the thread function never ends, the calling
    # thread will block forever.
    # If this function is called from its owner thread, it
    # returns without doing anything.
    def wait()
      VoidCSFML.thread_wait(to_unsafe)
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
      VoidCSFML.thread_terminate(to_unsafe)
    end
    include NonCopyable
    # :nodoc:
    def to_unsafe()
      pointerof(@_thread).as(Void*)
    end
  end
  VoidCSFML.sfml_system_version(out major, out minor, out patch)
  if SFML_VERSION != (ver = "#{major}.#{minor}.#{patch}")
    STDERR.puts "Warning: CrSFML was built for SFML #{SFML_VERSION}, found SFML #{ver}"
  end
end
