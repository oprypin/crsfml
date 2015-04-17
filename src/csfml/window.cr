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


require "./window_lib"

module SF
  extend self

  class Context
    def self.wrap_ptr(p)
      result = self.allocate()
      result.this = p
      result
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
    def active=(active: Bool)
      active = active ? 1 : 0
      CSFML.context_set_active(@this, active)
    end
  end

  class Window
    def self.wrap_ptr(p)
      result = self.allocate()
      result.this = p
      result
    end
    def to_unsafe
      @this
    end
    def initialize(mode: VideoMode, title: String, style: WindowStyle, settings)
      title = title.chars; title << '\0'
      if settings
        csettings = settings; psettings = pointerof(csettings)
      else
        psettings = nil
      end
      @owned = true
      @this = CSFML.window_create_unicode(mode, title, style, psettings)
    end
    def initialize(handle: WindowHandle, settings)
      if settings
        csettings = settings; psettings = pointerof(csettings)
      else
        psettings = nil
      end
      @owned = true
      @this = CSFML.window_create_from_handle(handle, psettings)
    end
    def finalize()
      CSFML.window_destroy(@this) if @owned
    end
    def close()
      CSFML.window_close(@this)
    end
    def open
      CSFML.window_is_open(@this) != 0
    end
    def settings
      CSFML.window_get_settings(@this)
    end
    def poll_event(event: Event*)
      CSFML.window_poll_event(@this, event) != 0
    end
    def wait_event(event: Event*)
      CSFML.window_wait_event(@this, event) != 0
    end
    def position
      CSFML.window_get_position(@this)
    end
    def position=(position: Vector2i)
      CSFML.window_set_position(@this, position)
    end
    def size
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
      if pixels
        cpixels = pixels; ppixels = pointerof(cpixels)
      else
        ppixels = nil
      end
      CSFML.window_set_icon(@this, width, height, ppixels)
    end
    def visible=(visible: Bool)
      visible = visible ? 1 : 0
      CSFML.window_set_visible(@this, visible)
    end
    def mouse_cursor_visible=(visible: Bool)
      visible = visible ? 1 : 0
      CSFML.window_set_mouse_cursor_visible(@this, visible)
    end
    def vertical_sync_enabled=(enabled: Bool)
      enabled = enabled ? 1 : 0
      CSFML.window_set_vertical_sync_enabled(@this, enabled)
    end
    def key_repeat_enabled=(enabled: Bool)
      enabled = enabled ? 1 : 0
      CSFML.window_set_key_repeat_enabled(@this, enabled)
    end
    def active=(active: Bool)
      active = active ? 1 : 0
      CSFML.window_set_active(@this, active) != 0
    end
    def request_focus()
      CSFML.window_request_focus(@this)
    end
    def has_focus()
      CSFML.window_has_focus(@this) != 0
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
    def system_handle
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
     
  def joystick_is_connected(joystick: Int32)
    CSFML.joystick_is_connected(joystick) != 0
  end
  def joystick_get_button_count(joystick: Int32)
    CSFML.joystick_get_button_count(joystick)
  end
  def joystick_has_axis(joystick: Int32, axis: JoystickAxis)
    CSFML.joystick_has_axis(joystick, axis) != 0
  end
  def joystick_is_button_pressed(joystick: Int32, button: Int32)
    CSFML.joystick_is_button_pressed(joystick, button) != 0
  end
  def joystick_get_axis_position(joystick: Int32, axis: JoystickAxis)
    CSFML.joystick_get_axis_position(joystick, axis)
  end
  def joystick_get_identification(joystick: Int32)
    CSFML.joystick_get_identification(joystick)
  end
  def joystick_update()
    CSFML.joystick_update()
  end
  def keyboard_is_key_pressed(key: KeyCode)
    CSFML.keyboard_is_key_pressed(key) != 0
  end
  def mouse_is_button_pressed(button: MouseButton)
    CSFML.mouse_is_button_pressed(button) != 0
  end
  def mouse_get_position()
    CSFML.mouse_get_position(@this)
  end
  def mouse_set_position(position: Vector2i, relative_to: Window)
    CSFML.mouse_set_position(position, relative_to)
  end
  def sensor_is_available(sensor: SensorType)
    CSFML.sensor_is_available(sensor) != 0
  end
  def sensor_set_enabled(sensor: SensorType, enabled: Bool)
    enabled = enabled ? 1 : 0
    CSFML.sensor_set_enabled(sensor, enabled)
  end
  def sensor_get_value(sensor: SensorType)
    CSFML.sensor_get_value(sensor)
  end
  def get_desktop_mode()
    CSFML.video_mode_get_desktop_mode()
  end
  def video_mode_get_fullscreen_modes(count: Size_t*)
    CSFML.video_mode_get_fullscreen_modes(count)
  end
  def validmode: VideoMode
    CSFML.video_mode_is_valid(mode) != 0
  end
end