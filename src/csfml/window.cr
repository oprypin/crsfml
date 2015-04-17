require "./window_lib"

module SF
  extend self

  class Context
    def self.wrap_ptr(p)
      result = self.allocate()
      result.this = p
    end
    def to_unsafe
      @this
    end
    def initialize()
      @owned = true
      @this = CSFML.context_create()
    end
    def finalize()
      CSFML.context_destroy(@this) if @owned
    end
    def active=(active: Int32)
      CSFML.context_set_active(@this, active)
    end
  end

  class Window
    def self.wrap_ptr(p)
      result = self.allocate()
      result.this = p
    end
    def to_unsafe
      @this
    end
    def initialize(mode: VideoMode, title: String, style: WindowStyle, settings)
      title = title.chars; title << '\0'
      settings = pointerof(settings) if settings
      @owned = true
      @this = CSFML.window_create_unicode(mode, title, style, settings)
    end
    def initialize(handle: WindowHandle, settings)
      settings = pointerof(settings) if settings
      @owned = true
      @this = CSFML.window_create_from_handle(handle, settings)
    end
    def finalize()
      CSFML.window_destroy(@this) if @owned
    end
    def close()
      CSFML.window_close(@this)
    end
    def open()
      CSFML.window_is_open(@this)
    end
    def settings()
      CSFML.window_get_settings(@this)
    end
    def poll_event(event: Event*)
      CSFML.window_poll_event(@this, event)
    end
    def wait_event(event: Event*)
      CSFML.window_wait_event(@this, event)
    end
    def position()
      CSFML.window_get_position(@this)
    end
    def position=(position: Vector2i)
      CSFML.window_set_position(@this, position)
    end
    def size()
      CSFML.window_get_size(@this)
    end
    def size=(size: Vector2i)
      CSFML.window_set_size(@this, size)
    end
    def title=(title: String)
      title = title.chars; title << '\0'
      CSFML.window_set_unicode_title(@this, title)
    end
    def set_icon(width: Int32, height: Int32, pixels)
      pixels = pointerof(pixels) if pixels
      CSFML.window_set_icon(@this, width, height, pixels)
    end
    def visible=(visible: Int32)
      CSFML.window_set_visible(@this, visible)
    end
    def mouse_cursor_visible=(visible: Int32)
      CSFML.window_set_mouse_cursor_visible(@this, visible)
    end
    def vertical_sync_enabled=(enabled: Int32)
      CSFML.window_set_vertical_sync_enabled(@this, enabled)
    end
    def key_repeat_enabled=(enabled: Int32)
      CSFML.window_set_key_repeat_enabled(@this, enabled)
    end
    def active=(active: Int32)
      CSFML.window_set_active(@this, active)
    end
    def request_focus()
      CSFML.window_request_focus(@this)
    end
    def has_focus()
      CSFML.window_has_focus(@this)
    end
    def display()
      CSFML.window_display(@this)
    end
    def framerate_limit=(limit: Int32)
      CSFML.window_set_framerate_limit(@this, limit)
    end
    def joystick_threshold=(threshold)
      threshold = threshold.to_f32
      CSFML.window_set_joystick_threshold(@this, threshold)
    end
    def system_handle()
      CSFML.window_get_system_handle(@this)
    end
  end

  alias JoystickIdentification = CSFML::JoystickIdentification
     
  alias JoystickAxis = CSFML::JoystickAxis
     
  alias KeyCode = CSFML::KeyCode
     
  alias MouseButton = CSFML::MouseButton
     
  alias SensorType = CSFML::SensorType
     
  alias EventType = CSFML::EventType
     
  alias KeyEvent = CSFML::KeyEvent
     
  alias TextEvent = CSFML::TextEvent
     
  alias MouseMoveEvent = CSFML::MouseMoveEvent
     
  alias MouseButtonEvent = CSFML::MouseButtonEvent
     
  alias MouseWheelEvent = CSFML::MouseWheelEvent
     
  alias JoystickMoveEvent = CSFML::JoystickMoveEvent
     
  alias JoystickButtonEvent = CSFML::JoystickButtonEvent
     
  alias JoystickConnectEvent = CSFML::JoystickConnectEvent
     
  alias SizeEvent = CSFML::SizeEvent
     
  alias TouchEvent = CSFML::TouchEvent
     
  alias SensorEvent = CSFML::SensorEvent
     
  alias VideoMode = CSFML::VideoMode
     
  alias WindowStyle = CSFML::WindowStyle
     
  alias ContextSettings = CSFML::ContextSettings
     
  def joystick_is_connected()
    CSFML.joystick_is_connected(@this)
  end
  def joystick_get_button_count()
    CSFML.joystick_get_button_count(@this)
  end
  def joystick_has_axis(axis: JoystickAxis)
    CSFML.joystick_has_axis(@this, axis)
  end
  def joystick_is_button_pressed(button: Int32)
    CSFML.joystick_is_button_pressed(@this, button)
  end
  def joystick_get_axis_position(axis: JoystickAxis)
    CSFML.joystick_get_axis_position(@this, axis)
  end
  def joystick_get_identification()
    CSFML.joystick_get_identification(@this)
  end
  def joystick_update()
    CSFML.joystick_update()
  end
  def keyboard_is_key_pressed()
    CSFML.keyboard_is_key_pressed(@this)
  end
  def mouse_is_button_pressed()
    CSFML.mouse_is_button_pressed(@this)
  end
  def mouse_get_position()
    CSFML.mouse_get_position(@this)
  end
  def mouse_set_position(relative_to: Window)
    CSFML.mouse_set_position(@this, relative_to)
  end
  def sensor_is_available()
    CSFML.sensor_is_available(@this)
  end
  def sensor_set_enabled(enabled: Int32)
    CSFML.sensor_set_enabled(@this, enabled)
  end
  def sensor_get_value()
    CSFML.sensor_get_value(@this)
  end
  def get_desktop_mode()
    CSFML.video_mode_get_desktop_mode()
  end
  def video_mode_get_fullscreen_modes()
    CSFML.video_mode_get_fullscreen_modes(@this)
  end
  def valid()
    CSFML.video_mode_is_valid(@this)
  end
end