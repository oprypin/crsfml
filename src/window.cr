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

  def context_settings(depth=0: Int, stencil=0: Int, antialiasing=0: Int, major=2: Int, minor=0: Int, attributes=CSFML::ContextSettings::Default)
    ContextSettings.new(
      depth_bits: depth.to_i32, stencil_bits: stencil.to_i32,
      antialiasing_level: antialiasing.to_i32,
      major_version: major.to_i32, minor_version: minor.to_i32,
      attribute_flags: attributes
    )
  end

  class Mouse
    def self.position
      CSFML.mouse_get_position(nil)
    end
    def self.position=(position)
      position = SF.vector2i(position) unless position.is_a? Vector2i
      CSFML.mouse_set_position(position, nil)
    end
  end

  class Joystick
    Count = CSFML::JoystickCount
    ButtonCount = CSFML::JoystickButtonCount
    AxisCount = CSFML::JoystickAxisCount
  end

  def video_mode()
    VideoMode.new()
  end

  def video_mode(mode_width: Int, mode_height: Int, bits_per_pixel=32)
    VideoMode.new(
      width: mode_width.to_i32, height: mode_height.to_i32,
      bits_per_pixel: bits_per_pixel.to_i32
    )
  end

  struct CSFML::VideoMode
    def self.fullscreen_modes
      ptr = CSFML.video_mode_get_fullscreen_modes(out count)
      ptr.to_slice(count.to_i).to_a
    end
  end

  class Window
    def initialize(mode: VideoMode, title: String, style=CSFML::WindowStyle::Default, settings=SF.context_settings())
      initialize(mode, title, style, settings)
    end

    def poll_event()
      if CSFML.window_poll_event(@this, out event) != 0
        event
      end
    end
    def wait_event()
      if CSFML.window_wait_event(@this, out event) != 0
        event
      end
    end
  end

  struct CSFML::Event
    def alt
      key.alt
    end
    def axis
      joystick_move.axis
    end
    def button
      case type
        when MouseButtonPressed, MouseButtonReleased
          mouse_button.button
        when JoystickButtonPressed, JoystickButtonReleased
          joystick_button.button
        else raise "button"
      end
    end
    def code
      key.code
    end
    def control
      key.control
    end
    def delta
      case type
        when MouseWheelMoved
          mouse_wheel.delta
        when MouseWheelScrolled
          mouse_wheel_scroll.delta
        else raise "delta"
      end
    end
    def finger
      touch.finger
    end
    def height
      size.height
    end
    def joystick_id
      case type
        when JoystickMoved
          joystick_move.joystick_id
        when JoystickButtonPressed, JoystickButtonReleased
          joystick_button.joystick_id
        when JoystickConnected, JoystickDisconnected
          joystick_connect.joystick_id
        else raise "joystick_id"
      end
    end
    def position
      joystick_move.position
    end
    def sensor_type
      sensor.sensor_type
    end
    def shift
      key.shift
    end
    def system
      key.system
    end
    def unicode
      text.unicode
    end
    def wheel
      mouse_wheel_scroll.wheel
    end
    def width
      size.width
    end
    def x
      case type
        when MouseMoved
          mouse_move.x
        when MouseButtonPressed, MouseButtonReleased
          mouse_button.x
        when MouseWheelMoved
          mouse_wheel.x
        when MouseWheelScrolled
          mouse_wheel_scroll.x
        when TouchBegan, TouchMoved, TouchEnded
          touch.x
        when SensorChanged
          sensor.x
        else raise "x"
      end
    end
    def y
      case type
        when MouseMoved
          mouse_move.y
        when MouseButtonPressed, MouseButtonReleased
          mouse_button.y
        when MouseWheelMoved
          mouse_wheel.y
        when MouseWheelScrolled
          mouse_wheel_scroll.y
        when TouchBegan, TouchMoved, TouchEnded
          touch.y
        when SensorChanged
          sensor.y
        else raise "y"
      end
    end
    def z
      sensor.z
    end
  end
end

require "./window_obj"
