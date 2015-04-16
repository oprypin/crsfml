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


require "./csfml_system_lib"

@[Link("csfml-window")]

lib CSFML
  ifdef windows || macosx
    alias WindowHandle = Void*
  else
    alias WindowHandle = UInt64#ulong
  end

  type Context = Void*
  
  type Window = Void*
  
  fun context_create = sfContext_create(): Context
    # Create a new context
    # 
    # This function activates the new context.
    # 
    # Returns: New Context object
  
  fun context_destroy = sfContext_destroy(context: Context): Void
    # Destroy a context
    # 
    # Arguments:
    # - context:  Context to destroy
  
  fun context_set_active = sfContext_setActive(context: Context, active: Int32): Void
    # Activate or deactivate explicitely a context
    # 
    # Arguments:
    # - context:  Context object
    # - active:   True to activate, False to deactivate
  
  struct JoystickIdentification
    name: UInt8*
    vendor_id: Int32
    product_id: Int32
  end
  
  JoystickCount = 8
  JoystickButtonCount = 32
  JoystickAxisCount = 8
  enum JoystickAxis
    # Axes supported by SFML joysticks
    X, Y, Z, R, U, V, PovX, PovY
  end
  
  fun joystick_is_connected = sfJoystick_isConnected(joystick: Int32): Int32
    # Check if a joystick is connected
    # 
    # Arguments:
    # - joystick:  Index of the joystick to check
    # 
    # Returns: True if the joystick is connected, False otherwise
  
  fun joystick_get_button_count = sfJoystick_getButtonCount(joystick: Int32): Int32
    # Return the number of buttons supported by a joystick
    # 
    # If the joystick is not connected, this function returns 0.
    # 
    # Arguments:
    # - joystick:  Index of the joystick
    # 
    # Returns: Number of buttons supported by the joystick
  
  fun joystick_has_axis = sfJoystick_hasAxis(joystick: Int32, axis: JoystickAxis): Int32
    # Check if a joystick supports a given axis
    # 
    # If the joystick is not connected, this function returns false.
    # 
    # Arguments:
    # - joystick:  Index of the joystick
    # - axis:      Axis to check
    # 
    # Returns: True if the joystick supports the axis, False otherwise
  
  fun joystick_is_button_pressed = sfJoystick_isButtonPressed(joystick: Int32, button: Int32): Int32
    # Check if a joystick button is pressed
    # 
    # If the joystick is not connected, this function returns false.
    # 
    # Arguments:
    # - joystick:  Index of the joystick
    # - button:    Button to check
    # 
    # Returns: True if the button is pressed, False otherwise
  
  fun joystick_get_axis_position = sfJoystick_getAxisPosition(joystick: Int32, axis: JoystickAxis): Float32
    # Get the current position of a joystick axis
    # 
    # If the joystick is not connected, this function returns 0.
    # 
    # Arguments:
    # - joystick:  Index of the joystick
    # - axis:      Axis to check
    # 
    # Returns: Current position of the axis, in range [-100 .. 100]
  
  fun joystick_get_identification = sfJoystick_getIdentification(joystick: Int32): JoystickIdentification
    # Get the joystick information
    # 
    # The result of this function will only remain valid until
    # the next time the function is called.
    # 
    # Arguments:
    # - joystick:  Index of the joystick
    # 
    # Returns: Structure containing joystick information.
  
  fun joystick_update = sfJoystick_update(): Void
    # Update the states of all joysticks
    # 
    # This function is used internally by SFML, so you normally
    # don't have to call it explicitely. However, you may need to
    # call it if you have no window yet (or no window at all):
    # in this case the joysticks states are not updated automatically.
  
  enum KeyCode
    # Key codes
    Unknown = -1, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U,
    V, W, X, Y, Z, Num0, Num1, Num2, Num3, Num4, Num5, Num6, Num7, Num8, Num9,
    Escape, LControl, LShift, LAlt, LSystem, RControl, RShift, RAlt, RSystem,
    Menu, LBracket, RBracket, SemiColon, Comma, Period, Quote, Slash, BackSlash,
    Tilde, Equal, Dash, Space, Return, Back, Tab, PageUp, PageDown, End, Home,
    Insert, Delete, Add, Subtract, Multiply, Divide, Left, Right, Up, Down,
    Numpad0, Numpad1, Numpad2, Numpad3, Numpad4, Numpad5, Numpad6, Numpad7,
    Numpad8, Numpad9, F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, F13,
    F14, F15, Pause, Count
  end
  
  fun keyboard_is_key_pressed = sfKeyboard_isKeyPressed(key: KeyCode): Int32
    # Check if a key is pressed
    # 
    # Arguments:
    # - key:  Key to check
    # 
    # Returns: True if the key is pressed, False otherwise
  
  enum MouseButton
    # Mouse buttons
    Left, Right, Middle, XButton1, XButton2, Count
  end
  
  fun mouse_is_button_pressed = sfMouse_isButtonPressed(button: MouseButton): Int32
    # Check if a mouse button is pressed
    # 
    # Arguments:
    # - button:  Button to check
    # 
    # Returns: True if the button is pressed, False otherwise
  
  fun mouse_get_position = sfMouse_getPosition(relative_to: Window): Vector2i
    # Get the current position of the mouse
    # 
    # This function returns the current position of the mouse
    # cursor relative to the given window, or desktop if NULL is passed.
    # 
    # Arguments:
    # - relative_to:  Reference window
    # 
    # Returns: Position of the mouse cursor, relative to the given window
  
  fun mouse_set_position = sfMouse_setPosition(position: Vector2i, relative_to: Window): Void
    # Set the current position of the mouse
    # 
    # This function sets the current position of the mouse
    # cursor relative to the given window, or desktop if NULL is passed.
    # 
    # Arguments:
    # - position:    New position of the mouse
    # - relative_to:  Reference window
  
  enum SensorType
    # Sensor Types
    Accelerometer, Gyroscope, Magnetometer, Gravity, UserAcceleration,
    Orientation, Count
  end
  
  fun sensor_is_available = sfSensor_isAvailable(sensor: SensorType): Int32
    # Check if a sensor is available on the underlying platform
    # 
    # Arguments:
    # - sensor:  Sensor to check
    # 
    # Returns: True if the sensor is available, False otherwise
  
  fun sensor_set_enabled = sfSensor_setEnabled(sensor: SensorType, enabled: Int32): Void
    # Enable or disable a sensor
    # 
    # All sensors are disabled by default, to avoid consuming too
    # much battery power. Once a sensor is enabled, it starts
    # sending events of the corresponding type.
    # 
    # This function does nothing if the sensor is unavailable.
    # 
    # Arguments:
    # - sensor:  Sensor to enable
    # - enabled:  True to enable, False to disable
  
  fun sensor_get_value = sfSensor_getValue(sensor: SensorType): Vector3f
    # Get the current sensor value
    # 
    # Arguments:
    # - sensor:  Sensor to read
    # 
    # Returns: The current sensor value
  
  enum EventType
    # Definition of all the event types
    Closed, Resized, LostFocus, GainedFocus, TextEntered, KeyPressed,
    KeyReleased, MouseWheelMoved, MouseButtonPressed, MouseButtonReleased,
    MouseMoved, MouseEntered, MouseLeft, JoystickButtonPressed,
    JoystickButtonReleased, JoystickMoved, JoystickConnected,
    JoystickDisconnected, TouchBegan, TouchMoved, TouchEnded, SensorChanged,
    Count
  end
  
  struct KeyEvent
    # Keyboard event parameters
    code: KeyCode
    alt: Int32
    control: Int32
    shift: Int32
    system: Int32
  end
  
  struct TextEvent
    # Text event parameters
    unicode: Char
  end
  
  struct MouseMoveEvent
    # Mouse move event parameters
    x: Int32
    y: Int32
  end
  
  struct MouseButtonEvent
    # Mouse buttons events parameters
    button: MouseButton
    x: Int32
    y: Int32
  end
  
  struct MouseWheelEvent
    # Mouse wheel events parameters
    delta: Int32
    x: Int32
    y: Int32
  end
  
  struct JoystickMoveEvent
    # Joystick axis move event parameters
    joystick_id: Int32
    axis: JoystickAxis
    position: Float32
  end
  
  struct JoystickButtonEvent
    # Joystick buttons events parameters
    joystick_id: Int32
    button: Int32
  end
  
  struct JoystickConnectEvent
    # Joystick connection/disconnection event parameters
    joystick_id: Int32
  end
  
  struct SizeEvent
    # Size events parameters
    width: Int32
    height: Int32
  end
  
  struct TouchEvent
    # Touch events parameters
    finger: Int32
    x: Int32
    y: Int32
  end
  
  struct SensorEvent
    # Sensor event parameters
    sensor_type: SensorType
    x: Float32
    y: Float32
    z: Float32
  end
  
  union Event
    # Event defines a system event and its parameters
    type: EventType
    size: SizeEvent
    key: KeyEvent
    text: TextEvent
    mouseMove: MouseMoveEvent
    mouseButton: MouseButtonEvent
    mouseWheel: MouseWheelEvent
    joystickMove: JoystickMoveEvent
    joystickButton: JoystickButtonEvent
    joystickConnect: JoystickConnectEvent
    touch: TouchEvent
    sensor: SensorEvent
  end
  
  struct VideoMode
    # VideoMode defines a video mode (width, height, bpp, frequency)
    # and provides functions for getting modes supported
    # by the display device
    width: Int32
    height: Int32
    bits_per_pixel: Int32
  end
  
  fun video_mode_get_desktop_mode = sfVideoMode_getDesktopMode(): VideoMode
    # Get the current desktop video mode
    # 
    # Returns: Current desktop video mode
  
  fun video_mode_get_fullscreen_modes = sfVideoMode_getFullscreenModes(count: Size_t*): VideoMode*
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
    # Arguments:
    # - count:  Pointer to a variable that will be filled with the number of modes in the array
    # 
    # Returns: Pointer to an array containing all the supported fullscreen modes
  
  fun video_mode_is_valid = sfVideoMode_isValid(mode: VideoMode): Int32
    # Tell whether or not a video mode is valid
    # 
    # The validity of video modes is only relevant when using
    # fullscreen windows; otherwise any video mode can be used
    # with no restriction.
    # 
    # Arguments:
    # - mode:  Video mode
    # 
    # Returns: True if the video mode is valid for fullscreen mode
  
  enum WindowStyle
    # Enumeration of window creation styles
    None = 0, Titlebar = 1, Resize = 2, Close = 4, Default = 7, Fullscreen = 8
  end
  
  struct ContextSettings
    # Structure defining the window's creation settings
    depth_bits: Int32
    stencil_bits: Int32
    antialiasing_level: Int32
    major_version: Int32
    minor_version: Int32
  end
  
  fun window_create = sfWindow_create(mode: VideoMode, title: UInt8*, style: BitMaskU32, settings: ContextSettings*): Window
    # Construct a new window
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
    # Arguments:
    # - mode:      Video mode to use (defines the width, height and depth of the rendering area of the window)
    # - title:     Title of the window
    # - style:     Window style
    # - settings:  Additional settings for the underlying OpenGL context
    # 
    # Returns: A new Window object
  
  fun window_create_unicode = sfWindow_createUnicode(mode: VideoMode, title: Char*, style: BitMaskU32, settings: ContextSettings*): Window
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
    # Arguments:
    # - mode:      Video mode to use (defines the width, height and depth of the rendering area of the window)
    # - title:     Title of the window (UTF-32)
    # - style:     Window style
    # - settings:  Additional settings for the underlying OpenGL context
    # 
    # Returns: A new Window object
  
  fun window_create_from_handle = sfWindow_createFromHandle(handle: WindowHandle, settings: ContextSettings*): Window
    # Construct a window from an existing control
    # 
    # Use this constructor if you want to create an OpenGL
    # rendering area into an already existing control.
    # 
    # The second parameter is a pointer to a structure specifying
    # advanced OpenGL context settings such as antialiasing,
    # depth-buffer bits, etc.
    # 
    # Arguments:
    # - handle:    Platform-specific handle of the control
    # - settings:  Additional settings for the underlying OpenGL context
    # 
    # Returns: A new Window object
  
  fun window_destroy = sfWindow_destroy(window: Window): Void
    # Destroy a window
    # 
    # Arguments:
    # - window:  Window to destroy
  
  fun window_close = sfWindow_close(window: Window): Void
    # Close a window and destroy all the attached resources
    # 
    # After calling this function, the Window object remains
    # valid, you must call Window_destroy to actually delete it.
    # All other functions such as Window_pollEvent or Window_display
    # will still work (i.e. you don't have to test Window_isOpen
    # every time), and will have no effect on closed windows.
    # 
    # Arguments:
    # - window:  Window object
  
  fun window_is_open = sfWindow_isOpen(window: Window): Int32
    # Tell whether or not a window is opened
    # 
    # This function returns whether or not the window exists.
    # Note that a hidden window (Window_setVisible(False)) will return
    # True.
    # 
    # Arguments:
    # - window:  Window object
    # 
    # Returns: True if the window is opened, False if it has been closed
  
  fun window_get_settings = sfWindow_getSettings(window: Window): ContextSettings
    # Get the settings of the OpenGL context of a window
    # 
    # Note that these settings may be different from what was
    # passed to the Window_create function,
    # if one or more settings were not supported. In this case,
    # SFML chose the closest match.
    # 
    # Arguments:
    # - window:  Window object
    # 
    # Returns: Structure containing the OpenGL context settings
  
  fun window_poll_event = sfWindow_pollEvent(window: Window, event: Event*): Int32
    # Pop the event on top of event queue, if any, and return it
    # 
    # This function is not blocking: if there's no pending event then
    # it will return false and leave `event` unmodified.
    # Note that more than one event may be present in the event queue,
    # thus you should always call this function in a loop
    # to make sure that you process every pending event.
    # 
    # Arguments:
    # - window:  Window object
    # - event:   Event to be returned
    # 
    # Returns: True if an event was returned, or False if the event queue was empty
  
  fun window_wait_event = sfWindow_waitEvent(window: Window, event: Event*): Int32
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
    # Arguments:
    # - window:  Window object
    # - event:   Event to be returned
    # 
    # Returns: False if any error occured
  
  fun window_get_position = sfWindow_getPosition(window: Window): Vector2i
    # Get the position of a window
    # 
    # Arguments:
    # - window:  Window object
    # 
    # Returns: Position in pixels
  
  fun window_set_position = sfWindow_setPosition(window: Window, position: Vector2i): Void
    # Change the position of a window on screen
    # 
    # This function only works for top-level windows
    # (i.e. it will be ignored for windows created from
    # the handle of a child window/control).
    # 
    # Arguments:
    # - window:    Window object
    # - position:  New position of the window, in pixels
  
  fun window_get_size = sfWindow_getSize(window: Window): Vector2i
    # Get the size of the rendering region of a window
    # 
    # The size doesn't include the titlebar and borders
    # of the window.
    # 
    # Arguments:
    # - window:  Window object
    # 
    # Returns: Size in pixels
  
  fun window_set_size = sfWindow_setSize(window: Window, size: Vector2i): Void
    # Change the size of the rendering region of a window
    # 
    # Arguments:
    # - window:  Window object
    # - size:    New size, in pixels
  
  fun window_set_title = sfWindow_setTitle(window: Window, title: UInt8*): Void
    # Change the title of a window
    # 
    # Arguments:
    # - window:  Window object
    # - title:   New title
  
  fun window_set_unicode_title = sfWindow_setUnicodeTitle(window: Window, title: Char*): Void
    # Change the title of a window (with a UTF-32 string)
    # 
    # Arguments:
    # - window:  Window object
    # - title:   New title
  
  fun window_set_icon = sfWindow_setIcon(window: Window, width: Int32, height: Int32, pixels: UInt8*): Void
    # Change a window's icon
    # 
    # `pixels` must be an array of `width` x `height` pixels
    # in 32-bits RGBA format.
    # 
    # Arguments:
    # - window:  Window object
    # - width:   Icon's width, in pixels
    # - height:  Icon's height, in pixels
    # - pixels:  Pointer to the array of pixels in memory
  
  fun window_set_visible = sfWindow_setVisible(window: Window, visible: Int32): Void
    # Show or hide a window
    # 
    # Arguments:
    # - window:   Window object
    # - visible:  True to show the window, False to hide it
  
  fun window_set_mouse_cursor_visible = sfWindow_setMouseCursorVisible(window: Window, visible: Int32): Void
    # Show or hide the mouse cursor
    # 
    # Arguments:
    # - window:   Window object
    # - visible:  True to show, False to hide
  
  fun window_set_vertical_sync_enabled = sfWindow_setVerticalSyncEnabled(window: Window, enabled: Int32): Void
    # Enable or disable vertical synchronization
    # 
    # Activating vertical synchronization will limit the number
    # of frames displayed to the refresh rate of the monitor.
    # This can avoid some visual artifacts, and limit the framerate
    # to a good value (but not constant across different computers).
    # 
    # Arguments:
    # - window:   Window object
    # - enabled:  True to enable v-sync, False to deactivate
  
  fun window_set_key_repeat_enabled = sfWindow_setKeyRepeatEnabled(window: Window, enabled: Int32): Void
    # Enable or disable automatic key-repeat
    # 
    # If key repeat is enabled, you will receive repeated
    # KeyPress events while keeping a key pressed. If it is disabled,
    # you will only get a single event when the key is pressed.
    # 
    # Key repeat is enabled by default.
    # 
    # Arguments:
    # - window:   Window object
    # - enabled:  True to enable, False to disable
  
  fun window_set_active = sfWindow_setActive(window: Window, active: Int32): Int32
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
    # Arguments:
    # - window:  Window object
    # - active:  True to activate, False to deactivate
    # 
    # Returns: True if operation was successful, False otherwise
  
  fun window_request_focus = sfWindow_requestFocus(window: Window): Void
    # Request the current window to be made the active
    # foreground window
    # 
    # At any given time, only one window may have the input focus
    # to receive input events such as keystrokes or mouse events.
    # If a window requests focus, it only hints to the operating
    # system, that it would like to be focused. The operating system
    # is free to deny the request.
    # This is not to be confused with Window_setActive().
  
  fun window_has_focus = sfWindow_hasFocus(window: Window): Int32
    # Check whether the window has the input focus
    # 
    # At any given time, only one window may have the input focus
    # to receive input events such as keystrokes or most mouse
    # events.
    # 
    # Returns: True if window has focus, false otherwise
  
  fun window_display = sfWindow_display(window: Window): Void
    # Display on screen what has been rendered to the
    # window so far
    # 
    # This function is typically called after all OpenGL rendering
    # has been done for the current frame, in order to show
    # it on screen.
    # 
    # Arguments:
    # - window:  Window object
  
  fun window_set_framerate_limit = sfWindow_setFramerateLimit(window: Window, limit: Int32): Void
    # Limit the framerate to a maximum fixed frequency
    # 
    # If a limit is set, the window will use a small delay after
    # each call to Window_display to ensure that the current frame
    # lasted long enough to match the framerate limit.
    # 
    # Arguments:
    # - window:  Window object
    # - limit:   Framerate limit, in frames per seconds (use 0 to disable limit)
  
  fun window_set_joystick_threshold = sfWindow_setJoystickThreshold(window: Window, threshold: Float32): Void
    # Change the joystick threshold
    # 
    # The joystick threshold is the value below which
    # no JoyMoved event will be generated.
    # 
    # Arguments:
    # - window:     Window object
    # - threshold:  New threshold, in the range [0, 100]
  
  fun window_get_system_handle = sfWindow_getSystemHandle(window: Window): WindowHandle
    # Get the OS-specific handle of the window
    # 
    # The type of the returned handle is WindowHandle,
    # which is a typedef to the handle type defined by the OS.
    # You shouldn't need to use this function, unless you have
    # very specific stuff to implement that SFML doesn't support,
    # or implement a temporary workaround until a bug is fixed.
    # 
    # Arguments:
    # - window:  Window object
    # 
    # Returns: System handle of the window
  
end