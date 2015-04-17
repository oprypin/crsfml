require "./system_lib"

module SF
  extend self

  alias Time = CSFML::Time
     
  class Clock
    def self.wrap_ptr(p)
      result = self.allocate()
      result.this = p
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
    def elapsed_time()
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
    end
    def to_unsafe
      @this
    end
  end

  class Thread
    def self.wrap_ptr(p)
      result = self.allocate()
      result.this = p
    end
    def to_unsafe
      @this
    end
  end

  alias InputStream = CSFML::InputStream
     
  alias Vector2i = CSFML::Vector2i
     
  alias Vector2f = CSFML::Vector2f
     
  alias Vector3f = CSFML::Vector3f
     
  def as_seconds()
    CSFML.time_as_seconds(@this)
  end
  def as_milliseconds()
    CSFML.time_as_milliseconds(@this)
  end
  def as_microseconds()
    CSFML.time_as_microseconds(@this)
  end
  def seconds()
    CSFML.seconds(@this)
  end
  def milliseconds()
    CSFML.milliseconds(@this)
  end
  def microseconds()
    CSFML.microseconds(@this)
  end
  def sleep()
    CSFML.sleep(@this)
  end
end