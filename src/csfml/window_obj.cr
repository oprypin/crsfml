require "./window_lib"
require "./common_obj"

module SF
  extend self

  class Context
    include Wrapper
    
    # Create a new context
    # 
    # This function activates the new context.
    # 
    # *Returns*: New Context object
    def initialize()
      @owned = true
      @this = CSFML.context_create()
    end
    
    # Destroy a context
    # 
    # *Arguments*:
    # 
    # * `context`: Context to destroy
    def finalize()
      CSFML.context_destroy(@this) if @owned
    end
    
    # Activate or deactivate explicitely a context
    # 
    # *Arguments*:
    # 
    # * `context`: Context object
    # * `active`: True to activate, False to deactivate
    def active=(active: Bool)
      active = active ? 1 : 0
      CSFML.context_set_active(@this, active)
    end
    
  end

  class Window
    include Wrapper
    
    # Construct a new window (with a UTF-32 title)
    # 
    # This function creates the window with the size and pixel
    # depth defined in `mode`. An optional style can be passed to
    # customize the look and behaviour of the window (borders,
    # title bar, resizable, closable, ...). If `style` contains
    # Fullscreen, then `mode` must be a valid video mode.
    # 
    # The fourth parameter is a pointer to a structure specifying
    # advanced OpenGL context settings such as antialiasing,
    # depth-buffer bits, etc.
    # 
    # *Arguments*:
    # 
    # * `mode`: Video mode to use (defines the width, height and depth of the rendering area of the window)
    # * `title`: Title of the window (UTF-32)
    # * `style`: Window style
    # * `settings`: Additional settings for the underlying OpenGL context
    # 
    # *Returns*: A new Window object
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
    
    # Construct a window from an existing control
    # 
    # Use this constructor if you want to create an OpenGL
    # rendering area into an already existing control.
    # 
    # The second parameter is a pointer to a structure specifying
    # advanced OpenGL context settings such as antialiasing,
    # depth-buffer bits, etc.
    # 
    # *Arguments*:
    # 
    # * `handle`: Platform-specific handle of the control
    # * `settings`: Additional settings for the underlying OpenGL context
    # 
    # *Returns*: A new Window object
    def initialize(handle: WindowHandle, settings)
      if settings
        csettings = settings; psettings = pointerof(csettings)
      else
        psettings = nil
      end
      @owned = true
      @this = CSFML.window_create_from_handle(handle, psettings)
    end
    
    # Destroy a window
    # 
    # *Arguments*:
    # 
    # * `window`: Window to destroy
    def finalize()
      CSFML.window_destroy(@this) if @owned
    end
    
    # Close a window and destroy all the attached resources
    # 
    # After calling this function, the Window object remains
    # valid, you must call Window_destroy to actually delete it.
    # All other functions such as Window_pollEvent or Window_display
    # will still work (i.e. you don't have to test Window_isOpen
    # every time), and will have no effect on closed windows.
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    def close()
      CSFML.window_close(@this)
    end
    
    # Tell whether or not a window is opened
    # 
    # This function returns whether or not the window exists.
    # Note that a hidden window (Window_setVisible(False)) will return
    # True.
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    # 
    # *Returns*: True if the window is opened, False if it has been closed
    def open
      CSFML.window_is_open(@this) != 0
    end
    
    # Get the settings of the OpenGL context of a window
    # 
    # Note that these settings may be different from what was
    # passed to the Window_create function,
    # if one or more settings were not supported. In this case,
    # SFML chose the closest match.
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    # 
    # *Returns*: Structure containing the OpenGL context settings
    def settings
      CSFML.window_get_settings(@this)
    end
    
    # Pop the event on top of event queue, if any, and return it
    # 
    # This function is not blocking: if there's no pending event then
    # it will return false and leave `event` unmodified.
    # Note that more than one event may be present in the event queue,
    # thus you should always call this function in a loop
    # to make sure that you process every pending event.
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    # * `event`: Event to be returned
    # 
    # *Returns*: True if an event was returned, or False if the event queue was empty
    def poll_event(event: Event*)
      CSFML.window_poll_event(@this, event) != 0
    end
    
    # Wait for an event and return it
    # 
    # This function is blocking: if there's no pending event then
    # it will wait until an event is received.
    # After this function returns (and no error occured),
    # the `event` object is always valid and filled properly.
    # This function is typically used when you have a thread that
    # is dedicated to events handling: you want to make this thread
    # sleep as long as no new event is received.
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    # * `event`: Event to be returned
    # 
    # *Returns*: False if any error occured
    def wait_event(event: Event*)
      CSFML.window_wait_event(@this, event) != 0
    end
    
    # Get the position of a window
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    # 
    # *Returns*: Position in pixels
    def position
      CSFML.window_get_position(@this)
    end
    
    # Change the position of a window on screen
    # 
    # This function only works for top-level windows
    # (i.e. it will be ignored for windows created from
    # the handle of a child window/control).
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    # * `position`: New position of the window, in pixels
    def position=(position: Vector2i)
      CSFML.window_set_position(@this, position)
    end
    
    # Get the size of the rendering region of a window
    # 
    # The size doesn't include the titlebar and borders
    # of the window.
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    # 
    # *Returns*: Size in pixels
    def size
      CSFML.window_get_size(@this)
    end
    
    # Change the size of the rendering region of a window
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    # * `size`: New size, in pixels
    def size=(size: Vector2i)
      CSFML.window_set_size(@this, size)
    end
    
    # Change the title of a window (with a UTF-32 string)
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    # * `title`: New title
    def title=(title: String)
      title = title.chars; title << '\0'
      CSFML.window_set_unicode_title(@this, title)
    end
    
    # Change a window's icon
    # 
    # `pixels` must be an array of `width` x `height` pixels
    # in 32-bits RGBA format.
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    # * `width`: Icon's width, in pixels
    # * `height`: Icon's height, in pixels
    # * `pixels`: Pointer to the array of pixels in memory
    def set_icon(width: Int32, height: Int32, pixels)
      if pixels
        cpixels = pixels; ppixels = pointerof(cpixels)
      else
        ppixels = nil
      end
      CSFML.window_set_icon(@this, width, height, ppixels)
    end
    
    # Show or hide a window
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    # * `visible`: True to show the window, False to hide it
    def visible=(visible: Bool)
      visible = visible ? 1 : 0
      CSFML.window_set_visible(@this, visible)
    end
    
    # Show or hide the mouse cursor
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    # * `visible`: True to show, False to hide
    def mouse_cursor_visible=(visible: Bool)
      visible = visible ? 1 : 0
      CSFML.window_set_mouse_cursor_visible(@this, visible)
    end
    
    # Enable or disable vertical synchronization
    # 
    # Activating vertical synchronization will limit the number
    # of frames displayed to the refresh rate of the monitor.
    # This can avoid some visual artifacts, and limit the framerate
    # to a good value (but not constant across different computers).
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    # * `enabled`: True to enable v-sync, False to deactivate
    def vertical_sync_enabled=(enabled: Bool)
      enabled = enabled ? 1 : 0
      CSFML.window_set_vertical_sync_enabled(@this, enabled)
    end
    
    # Enable or disable automatic key-repeat
    # 
    # If key repeat is enabled, you will receive repeated
    # KeyPress events while keeping a key pressed. If it is disabled,
    # you will only get a single event when the key is pressed.
    # 
    # Key repeat is enabled by default.
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    # * `enabled`: True to enable, False to disable
    def key_repeat_enabled=(enabled: Bool)
      enabled = enabled ? 1 : 0
      CSFML.window_set_key_repeat_enabled(@this, enabled)
    end
    
    # Activate or deactivate a window as the current target
    # for OpenGL rendering
    # 
    # A window is active only on the current thread, if you want to
    # make it active on another thread you have to deactivate it
    # on the previous thread first if it was active.
    # Only one window can be active on a thread at a time, thus
    # the window previously active (if any) automatically gets deactivated.
    # This is not to be confused with Window_requestFocus().
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    # * `active`: True to activate, False to deactivate
    # 
    # *Returns*: True if operation was successful, False otherwise
    def active=(active: Bool)
      active = active ? 1 : 0
      CSFML.window_set_active(@this, active) != 0
    end
    
    # Request the current window to be made the active
    # foreground window
    # 
    # At any given time, only one window may have the input focus
    # to receive input events such as keystrokes or mouse events.
    # If a window requests focus, it only hints to the operating
    # system, that it would like to be focused. The operating system
    # is free to deny the request.
    # This is not to be confused with Window_setActive().
    def request_focus()
      CSFML.window_request_focus(@this)
    end
    
    # Check whether the window has the input focus
    # 
    # At any given time, only one window may have the input focus
    # to receive input events such as keystrokes or most mouse
    # events.
    # 
    # *Returns*: True if window has focus, false otherwise
    def has_focus()
      CSFML.window_has_focus(@this) != 0
    end
    
    # Display on screen what has been rendered to the
    # window so far
    # 
    # This function is typically called after all OpenGL rendering
    # has been done for the current frame, in order to show
    # it on screen.
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    def display()
      CSFML.window_display(@this)
    end
    
    # Limit the framerate to a maximum fixed frequency
    # 
    # If a limit is set, the window will use a small delay after
    # each call to Window_display to ensure that the current frame
    # lasted long enough to match the framerate limit.
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    # * `limit`: Framerate limit, in frames per seconds (use 0 to disable limit)
    def framerate_limit=(limit: Int32)
      CSFML.window_set_framerate_limit(@this, limit)
    end
    
    # Change the joystick threshold
    # 
    # The joystick threshold is the value below which
    # no JoyMoved event will be generated.
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    # * `threshold`: New threshold, in the range [0, 100]
    def joystick_threshold=(threshold)
      threshold = threshold.to_f32
      CSFML.window_set_joystick_threshold(@this, threshold)
    end
    
    # Get the OS-specific handle of the window
    # 
    # The type of the returned handle is WindowHandle,
    # which is a typedef to the handle type defined by the OS.
    # You shouldn't need to use this function, unless you have
    # very specific stuff to implement that SFML doesn't support,
    # or implement a temporary workaround until a bug is fixed.
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    # 
    # *Returns*: System handle of the window
    def system_handle
      CSFML.window_get_system_handle(@this)
    end
    
  end

  alias JoystickIdentification = CSFML::JoystickIdentification

  # Axes supported by SFML joysticks
  #
  # * Joystick_X
  # * Joystick_Y
  # * Joystick_Z
  # * Joystick_R
  # * Joystick_U
  # * Joystick_V
  # * Joystick_PovX
  # * Joystick_PovY
  alias JoystickAxis = CSFML::JoystickAxis
    Joystick_X = CSFML::JoystickAxis::X
    Joystick_Y = CSFML::JoystickAxis::Y
    Joystick_Z = CSFML::JoystickAxis::Z
    Joystick_R = CSFML::JoystickAxis::R
    Joystick_U = CSFML::JoystickAxis::U
    Joystick_V = CSFML::JoystickAxis::V
    Joystick_PovX = CSFML::JoystickAxis::PovX
    Joystick_PovY = CSFML::JoystickAxis::PovY

  class Joystick
    # Check if a joystick is connected
    # 
    # *Arguments*:
    # 
    # * `joystick`: Index of the joystick to check
    # 
    # *Returns*: True if the joystick is connected, False otherwise
    def self.is_connected(joystick: Int32)
      CSFML.joystick_is_connected(joystick) != 0
    end
    
    # Return the number of buttons supported by a joystick
    # 
    # If the joystick is not connected, this function returns 0.
    # 
    # *Arguments*:
    # 
    # * `joystick`: Index of the joystick
    # 
    # *Returns*: Number of buttons supported by the joystick
    def self.get_button_count(joystick: Int32)
      CSFML.joystick_get_button_count(joystick)
    end
    
    # Check if a joystick supports a given axis
    # 
    # If the joystick is not connected, this function returns false.
    # 
    # *Arguments*:
    # 
    # * `joystick`: Index of the joystick
    # * `axis`: Axis to check
    # 
    # *Returns*: True if the joystick supports the axis, False otherwise
    def self.has_axis(joystick: Int32, axis: JoystickAxis)
      CSFML.joystick_has_axis(joystick, axis) != 0
    end
    
    # Check if a joystick button is pressed
    # 
    # If the joystick is not connected, this function returns false.
    # 
    # *Arguments*:
    # 
    # * `joystick`: Index of the joystick
    # * `button`: Button to check
    # 
    # *Returns*: True if the button is pressed, False otherwise
    def self.is_button_pressed(joystick: Int32, button: Int32)
      CSFML.joystick_is_button_pressed(joystick, button) != 0
    end
    
    # Get the current position of a joystick axis
    # 
    # If the joystick is not connected, this function returns 0.
    # 
    # *Arguments*:
    # 
    # * `joystick`: Index of the joystick
    # * `axis`: Axis to check
    # 
    # *Returns*: Current position of the axis, in range [-100 .. 100]
    def self.get_axis_position(joystick: Int32, axis: JoystickAxis)
      CSFML.joystick_get_axis_position(joystick, axis)
    end
    
    # Get the joystick information
    # 
    # The result of this function will only remain valid until
    # the next time the function is called.
    # 
    # *Arguments*:
    # 
    # * `joystick`: Index of the joystick
    # 
    # *Returns*: Structure containing joystick information.
    def self.get_identification(joystick: Int32)
      CSFML.joystick_get_identification(joystick)
    end
    
    # Update the states of all joysticks
    # 
    # This function is used internally by SFML, so you normally
    # don't have to call it explicitely. However, you may need to
    # call it if you have no window yet (or no window at all):
    # in this case the joysticks states are not updated automatically.
    def self.update()
      CSFML.joystick_update()
    end
    
  end

  # Key codes
  #
  # * Keyboard_Unknown
  # * Keyboard_A
  # * Keyboard_B
  # * Keyboard_C
  # * Keyboard_D
  # * Keyboard_E
  # * Keyboard_F
  # * Keyboard_G
  # * Keyboard_H
  # * Keyboard_I
  # * Keyboard_J
  # * Keyboard_K
  # * Keyboard_L
  # * Keyboard_M
  # * Keyboard_N
  # * Keyboard_O
  # * Keyboard_P
  # * Keyboard_Q
  # * Keyboard_R
  # * Keyboard_S
  # * Keyboard_T
  # * Keyboard_U
  # * Keyboard_V
  # * Keyboard_W
  # * Keyboard_X
  # * Keyboard_Y
  # * Keyboard_Z
  # * Keyboard_Num0
  # * Keyboard_Num1
  # * Keyboard_Num2
  # * Keyboard_Num3
  # * Keyboard_Num4
  # * Keyboard_Num5
  # * Keyboard_Num6
  # * Keyboard_Num7
  # * Keyboard_Num8
  # * Keyboard_Num9
  # * Keyboard_Escape
  # * Keyboard_LControl
  # * Keyboard_LShift
  # * Keyboard_LAlt
  # * Keyboard_LSystem
  # * Keyboard_RControl
  # * Keyboard_RShift
  # * Keyboard_RAlt
  # * Keyboard_RSystem
  # * Keyboard_Menu
  # * Keyboard_LBracket
  # * Keyboard_RBracket
  # * Keyboard_SemiColon
  # * Keyboard_Comma
  # * Keyboard_Period
  # * Keyboard_Quote
  # * Keyboard_Slash
  # * Keyboard_BackSlash
  # * Keyboard_Tilde
  # * Keyboard_Equal
  # * Keyboard_Dash
  # * Keyboard_Space
  # * Keyboard_Return
  # * Keyboard_Back
  # * Keyboard_Tab
  # * Keyboard_PageUp
  # * Keyboard_PageDown
  # * Keyboard_End
  # * Keyboard_Home
  # * Keyboard_Insert
  # * Keyboard_Delete
  # * Keyboard_Add
  # * Keyboard_Subtract
  # * Keyboard_Multiply
  # * Keyboard_Divide
  # * Keyboard_Left
  # * Keyboard_Right
  # * Keyboard_Up
  # * Keyboard_Down
  # * Keyboard_Numpad0
  # * Keyboard_Numpad1
  # * Keyboard_Numpad2
  # * Keyboard_Numpad3
  # * Keyboard_Numpad4
  # * Keyboard_Numpad5
  # * Keyboard_Numpad6
  # * Keyboard_Numpad7
  # * Keyboard_Numpad8
  # * Keyboard_Numpad9
  # * Keyboard_F1
  # * Keyboard_F2
  # * Keyboard_F3
  # * Keyboard_F4
  # * Keyboard_F5
  # * Keyboard_F6
  # * Keyboard_F7
  # * Keyboard_F8
  # * Keyboard_F9
  # * Keyboard_F10
  # * Keyboard_F11
  # * Keyboard_F12
  # * Keyboard_F13
  # * Keyboard_F14
  # * Keyboard_F15
  # * Keyboard_Pause
  # * Keyboard_Count
  alias KeyCode = CSFML::KeyCode
    Keyboard_Unknown = CSFML::KeyCode::Unknown
    Keyboard_A = CSFML::KeyCode::A
    Keyboard_B = CSFML::KeyCode::B
    Keyboard_C = CSFML::KeyCode::C
    Keyboard_D = CSFML::KeyCode::D
    Keyboard_E = CSFML::KeyCode::E
    Keyboard_F = CSFML::KeyCode::F
    Keyboard_G = CSFML::KeyCode::G
    Keyboard_H = CSFML::KeyCode::H
    Keyboard_I = CSFML::KeyCode::I
    Keyboard_J = CSFML::KeyCode::J
    Keyboard_K = CSFML::KeyCode::K
    Keyboard_L = CSFML::KeyCode::L
    Keyboard_M = CSFML::KeyCode::M
    Keyboard_N = CSFML::KeyCode::N
    Keyboard_O = CSFML::KeyCode::O
    Keyboard_P = CSFML::KeyCode::P
    Keyboard_Q = CSFML::KeyCode::Q
    Keyboard_R = CSFML::KeyCode::R
    Keyboard_S = CSFML::KeyCode::S
    Keyboard_T = CSFML::KeyCode::T
    Keyboard_U = CSFML::KeyCode::U
    Keyboard_V = CSFML::KeyCode::V
    Keyboard_W = CSFML::KeyCode::W
    Keyboard_X = CSFML::KeyCode::X
    Keyboard_Y = CSFML::KeyCode::Y
    Keyboard_Z = CSFML::KeyCode::Z
    Keyboard_Num0 = CSFML::KeyCode::Num0
    Keyboard_Num1 = CSFML::KeyCode::Num1
    Keyboard_Num2 = CSFML::KeyCode::Num2
    Keyboard_Num3 = CSFML::KeyCode::Num3
    Keyboard_Num4 = CSFML::KeyCode::Num4
    Keyboard_Num5 = CSFML::KeyCode::Num5
    Keyboard_Num6 = CSFML::KeyCode::Num6
    Keyboard_Num7 = CSFML::KeyCode::Num7
    Keyboard_Num8 = CSFML::KeyCode::Num8
    Keyboard_Num9 = CSFML::KeyCode::Num9
    Keyboard_Escape = CSFML::KeyCode::Escape
    Keyboard_LControl = CSFML::KeyCode::LControl
    Keyboard_LShift = CSFML::KeyCode::LShift
    Keyboard_LAlt = CSFML::KeyCode::LAlt
    Keyboard_LSystem = CSFML::KeyCode::LSystem
    Keyboard_RControl = CSFML::KeyCode::RControl
    Keyboard_RShift = CSFML::KeyCode::RShift
    Keyboard_RAlt = CSFML::KeyCode::RAlt
    Keyboard_RSystem = CSFML::KeyCode::RSystem
    Keyboard_Menu = CSFML::KeyCode::Menu
    Keyboard_LBracket = CSFML::KeyCode::LBracket
    Keyboard_RBracket = CSFML::KeyCode::RBracket
    Keyboard_SemiColon = CSFML::KeyCode::SemiColon
    Keyboard_Comma = CSFML::KeyCode::Comma
    Keyboard_Period = CSFML::KeyCode::Period
    Keyboard_Quote = CSFML::KeyCode::Quote
    Keyboard_Slash = CSFML::KeyCode::Slash
    Keyboard_BackSlash = CSFML::KeyCode::BackSlash
    Keyboard_Tilde = CSFML::KeyCode::Tilde
    Keyboard_Equal = CSFML::KeyCode::Equal
    Keyboard_Dash = CSFML::KeyCode::Dash
    Keyboard_Space = CSFML::KeyCode::Space
    Keyboard_Return = CSFML::KeyCode::Return
    Keyboard_Back = CSFML::KeyCode::Back
    Keyboard_Tab = CSFML::KeyCode::Tab
    Keyboard_PageUp = CSFML::KeyCode::PageUp
    Keyboard_PageDown = CSFML::KeyCode::PageDown
    Keyboard_End = CSFML::KeyCode::End
    Keyboard_Home = CSFML::KeyCode::Home
    Keyboard_Insert = CSFML::KeyCode::Insert
    Keyboard_Delete = CSFML::KeyCode::Delete
    Keyboard_Add = CSFML::KeyCode::Add
    Keyboard_Subtract = CSFML::KeyCode::Subtract
    Keyboard_Multiply = CSFML::KeyCode::Multiply
    Keyboard_Divide = CSFML::KeyCode::Divide
    Keyboard_Left = CSFML::KeyCode::Left
    Keyboard_Right = CSFML::KeyCode::Right
    Keyboard_Up = CSFML::KeyCode::Up
    Keyboard_Down = CSFML::KeyCode::Down
    Keyboard_Numpad0 = CSFML::KeyCode::Numpad0
    Keyboard_Numpad1 = CSFML::KeyCode::Numpad1
    Keyboard_Numpad2 = CSFML::KeyCode::Numpad2
    Keyboard_Numpad3 = CSFML::KeyCode::Numpad3
    Keyboard_Numpad4 = CSFML::KeyCode::Numpad4
    Keyboard_Numpad5 = CSFML::KeyCode::Numpad5
    Keyboard_Numpad6 = CSFML::KeyCode::Numpad6
    Keyboard_Numpad7 = CSFML::KeyCode::Numpad7
    Keyboard_Numpad8 = CSFML::KeyCode::Numpad8
    Keyboard_Numpad9 = CSFML::KeyCode::Numpad9
    Keyboard_F1 = CSFML::KeyCode::F1
    Keyboard_F2 = CSFML::KeyCode::F2
    Keyboard_F3 = CSFML::KeyCode::F3
    Keyboard_F4 = CSFML::KeyCode::F4
    Keyboard_F5 = CSFML::KeyCode::F5
    Keyboard_F6 = CSFML::KeyCode::F6
    Keyboard_F7 = CSFML::KeyCode::F7
    Keyboard_F8 = CSFML::KeyCode::F8
    Keyboard_F9 = CSFML::KeyCode::F9
    Keyboard_F10 = CSFML::KeyCode::F10
    Keyboard_F11 = CSFML::KeyCode::F11
    Keyboard_F12 = CSFML::KeyCode::F12
    Keyboard_F13 = CSFML::KeyCode::F13
    Keyboard_F14 = CSFML::KeyCode::F14
    Keyboard_F15 = CSFML::KeyCode::F15
    Keyboard_Pause = CSFML::KeyCode::Pause
    Keyboard_Count = CSFML::KeyCode::Count

  class Keyboard
    # Check if a key is pressed
    # 
    # *Arguments*:
    # 
    # * `key`: Key to check
    # 
    # *Returns*: True if the key is pressed, False otherwise
    def self.is_key_pressed(key: KeyCode)
      CSFML.keyboard_is_key_pressed(key) != 0
    end
    
  end

  # Mouse buttons
  #
  # * Mouse_Left
  # * Mouse_Right
  # * Mouse_Middle
  # * Mouse_XButton1
  # * Mouse_XButton2
  # * Mouse_ButtonCount
  alias MouseButton = CSFML::MouseButton
    Mouse_Left = CSFML::MouseButton::Left
    Mouse_Right = CSFML::MouseButton::Right
    Mouse_Middle = CSFML::MouseButton::Middle
    Mouse_XButton1 = CSFML::MouseButton::XButton1
    Mouse_XButton2 = CSFML::MouseButton::XButton2
    Mouse_ButtonCount = CSFML::MouseButton::Count

  class Mouse
    # Check if a mouse button is pressed
    # 
    # *Arguments*:
    # 
    # * `button`: Button to check
    # 
    # *Returns*: True if the button is pressed, False otherwise
    def self.is_button_pressed(button: MouseButton)
      CSFML.mouse_is_button_pressed(button) != 0
    end
    
    # Get the current position of the mouse
    # 
    # This function returns the current position of the mouse
    # cursor relative to the given window, or desktop if NULL is passed.
    # 
    # *Arguments*:
    # 
    # * `relative_to`: Reference window
    # 
    # *Returns*: Position of the mouse cursor, relative to the given window
    def self.get_position(relative_to: Window)
      CSFML.mouse_get_position(relative_to)
    end
    
    # Set the current position of the mouse
    # 
    # This function sets the current position of the mouse
    # cursor relative to the given window, or desktop if NULL is passed.
    # 
    # *Arguments*:
    # 
    # * `position`: New position of the mouse
    # * `relative_to`: Reference window
    def self.set_position(position: Vector2i, relative_to: Window)
      CSFML.mouse_set_position(position, relative_to)
    end
    
  end

  # Sensor Types
  #
  # * Sensor_Accelerometer
  # * Sensor_Gyroscope
  # * Sensor_Magnetometer
  # * Sensor_Gravity
  # * Sensor_UserAcceleration
  # * Sensor_Orientation
  # * Sensor_Count
  alias SensorType = CSFML::SensorType
    Sensor_Accelerometer = CSFML::SensorType::Accelerometer
    Sensor_Gyroscope = CSFML::SensorType::Gyroscope
    Sensor_Magnetometer = CSFML::SensorType::Magnetometer
    Sensor_Gravity = CSFML::SensorType::Gravity
    Sensor_UserAcceleration = CSFML::SensorType::UserAcceleration
    Sensor_Orientation = CSFML::SensorType::Orientation
    Sensor_Count = CSFML::SensorType::Count

  class Sensor
    # Check if a sensor is available on the underlying platform
    # 
    # *Arguments*:
    # 
    # * `sensor`: Sensor to check
    # 
    # *Returns*: True if the sensor is available, False otherwise
    def self.is_available(sensor: SensorType)
      CSFML.sensor_is_available(sensor) != 0
    end
    
    # Enable or disable a sensor
    # 
    # All sensors are disabled by default, to avoid consuming too
    # much battery power. Once a sensor is enabled, it starts
    # sending events of the corresponding type.
    # 
    # This function does nothing if the sensor is unavailable.
    # 
    # *Arguments*:
    # 
    # * `sensor`: Sensor to enable
    # * `enabled`: True to enable, False to disable
    def self.set_enabled(sensor: SensorType, enabled: Bool)
      enabled = enabled ? 1 : 0
      CSFML.sensor_set_enabled(sensor, enabled)
    end
    
    # Get the current sensor value
    # 
    # *Arguments*:
    # 
    # * `sensor`: Sensor to read
    # 
    # *Returns*: The current sensor value
    def self.get_value(sensor: SensorType)
      CSFML.sensor_get_value(sensor)
    end
    
  end

  # Definition of all the event types
  #
  # * Event_Closed
  # * Event_Resized
  # * Event_LostFocus
  # * Event_GainedFocus
  # * Event_TextEntered
  # * Event_KeyPressed
  # * Event_KeyReleased
  # * Event_MouseWheelMoved
  # * Event_MouseButtonPressed
  # * Event_MouseButtonReleased
  # * Event_MouseMoved
  # * Event_MouseEntered
  # * Event_MouseLeft
  # * Event_JoystickButtonPressed
  # * Event_JoystickButtonReleased
  # * Event_JoystickMoved
  # * Event_JoystickConnected
  # * Event_JoystickDisconnected
  # * Event_TouchBegan
  # * Event_TouchMoved
  # * Event_TouchEnded
  # * Event_SensorChanged
  # * Event_Count
  alias EventType = CSFML::EventType
    Event_Closed = CSFML::EventType::Closed
    Event_Resized = CSFML::EventType::Resized
    Event_LostFocus = CSFML::EventType::LostFocus
    Event_GainedFocus = CSFML::EventType::GainedFocus
    Event_TextEntered = CSFML::EventType::TextEntered
    Event_KeyPressed = CSFML::EventType::KeyPressed
    Event_KeyReleased = CSFML::EventType::KeyReleased
    Event_MouseWheelMoved = CSFML::EventType::MouseWheelMoved
    Event_MouseButtonPressed = CSFML::EventType::MouseButtonPressed
    Event_MouseButtonReleased = CSFML::EventType::MouseButtonReleased
    Event_MouseMoved = CSFML::EventType::MouseMoved
    Event_MouseEntered = CSFML::EventType::MouseEntered
    Event_MouseLeft = CSFML::EventType::MouseLeft
    Event_JoystickButtonPressed = CSFML::EventType::JoystickButtonPressed
    Event_JoystickButtonReleased = CSFML::EventType::JoystickButtonReleased
    Event_JoystickMoved = CSFML::EventType::JoystickMoved
    Event_JoystickConnected = CSFML::EventType::JoystickConnected
    Event_JoystickDisconnected = CSFML::EventType::JoystickDisconnected
    Event_TouchBegan = CSFML::EventType::TouchBegan
    Event_TouchMoved = CSFML::EventType::TouchMoved
    Event_TouchEnded = CSFML::EventType::TouchEnded
    Event_SensorChanged = CSFML::EventType::SensorChanged
    Event_Count = CSFML::EventType::Count

  # Keyboard event parameters
  alias KeyEvent = CSFML::KeyEvent

  # Text event parameters
  alias TextEvent = CSFML::TextEvent

  # Mouse move event parameters
  alias MouseMoveEvent = CSFML::MouseMoveEvent

  # Mouse buttons events parameters
  alias MouseButtonEvent = CSFML::MouseButtonEvent

  # Mouse wheel events parameters
  alias MouseWheelEvent = CSFML::MouseWheelEvent

  # Joystick axis move event parameters
  alias JoystickMoveEvent = CSFML::JoystickMoveEvent

  # Joystick buttons events parameters
  alias JoystickButtonEvent = CSFML::JoystickButtonEvent

  # Joystick connection/disconnection event parameters
  alias JoystickConnectEvent = CSFML::JoystickConnectEvent

  # Size events parameters
  alias SizeEvent = CSFML::SizeEvent

  # Touch events parameters
  alias TouchEvent = CSFML::TouchEvent

  # Sensor event parameters
  alias SensorEvent = CSFML::SensorEvent

  # Event defines a system event and its parameters
  alias Event = CSFML::Event

  # VideoMode defines a video mode (width, height, bpp, frequency)
  # and provides functions for getting modes supported
  # by the display device
  alias VideoMode = CSFML::VideoMode
    # Get the current desktop video mode
    # 
    # *Returns*: Current desktop video mode
    def self.get_desktop_mode()
      CSFML.video_mode_get_desktop_mode()
    end
    
    # Retrieve all the video modes supported in fullscreen mode
    # 
    # When creating a fullscreen window, the video mode is restricted
    # to be compatible with what the graphics driver and monitor
    # support. This function returns the complete list of all video
    # modes that can be used in fullscreen mode.
    # The returned array is sorted from best to worst, so that
    # the first element will always give the best mode (higher
    # width, height and bits-per-pixel).
    # 
    # *Arguments*:
    # 
    # * `count`: Pointer to a variable that will be filled with the number of modes in the array
    # 
    # *Returns*: Pointer to an array containing all the supported fullscreen modes
    def self.get_fullscreen_modes(count: Size_t*)
      CSFML.video_mode_get_fullscreen_modes(count)
    end
    
    # Tell whether or not a video mode is valid
    # 
    # The validity of video modes is only relevant when using
    # fullscreen windows; otherwise any video mode can be used
    # with no restriction.
    # 
    # *Arguments*:
    # 
    # * `mode`: Video mode
    # 
    # *Returns*: True if the video mode is valid for fullscreen mode
    def self.is_valid(mode: VideoMode)
      CSFML.video_mode_is_valid(mode) != 0
    end
    

  # Enumeration of window creation styles
  #
  # * None
  # * Titlebar
  # * Resize
  # * Close
  # * DefaultStyle
  # * Fullscreen
  alias WindowStyle = CSFML::WindowStyle
    None = CSFML::WindowStyle::None
    Titlebar = CSFML::WindowStyle::Titlebar
    Resize = CSFML::WindowStyle::Resize
    Close = CSFML::WindowStyle::Close
    DefaultStyle = CSFML::WindowStyle::Default
    Fullscreen = CSFML::WindowStyle::Fullscreen

  # Structure defining the window's creation settings
  alias ContextSettings = CSFML::ContextSettings


end
