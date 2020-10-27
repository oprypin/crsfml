Based on https://github.com/SFML/SFML/blob/2.5.1/include/SFML/Window

# SF::Clipboard

Give access to the system clipboard

`SF::Clipboard` provides an interface for getting and
setting the contents of the system clipboard.

It is important to note that due to limitations on some
operating systems, setting the clipboard contents is
only guaranteed to work if there is currently an open
window for which events are being handled.

Usage example:
```c++
// get the clipboard content as a string
sf::String string = sf::Clipboard::getString();

// or use it in the event loop
sf::Event event;
while(window.pollEvent(event))
{
    if(event.type == sf::Event::Closed)
        window.close();
    if(event.type == sf::Event::KeyPressed)
    {
        // Using Ctrl + V to paste a string into SFML
        if(event.key.control && event.key.code == sf::Keyboard::V)
            string = sf::Clipboard::getString();

        // Using Ctrl + C to copy a string out of SFML
        if(event.key.control && event.key.code == sf::Keyboard::C)
            sf::Clipboard::setString("Hello World!");
    }
}
```

*See also:* `SF::String`, `SF::Event`

## SF::Clipboard.string()

Get the content of the clipboard as string data

This function returns the content of the clipboard
as a string. If the clipboard does not contain string
it returns an empty `SF::String` object.

*Returns:* Clipboard contents as `SF::String` object

## SF::Clipboard.string=(text)

Set the content of the clipboard as string data

This function sets the content of the clipboard as a
string.

*Warning:* Due to limitations on some operating systems,
setting the clipboard contents is only
guaranteed to work if there is currently an
open window for which events are being handled.

* *text* - `SF::String` containing the data to be sent
to the clipboard

# SF::Context

Class holding a valid drawing context

If you need to make OpenGL calls without having an
active window (like in a thread), you can use an
instance of this class to get a valid context.

Having a valid context is necessary for *every* OpenGL call.

Note that a context is only active in its current thread,
if you create a new thread it will have no valid context
by default.

To use a `SF::Context` instance, just construct it and let it
live as long as you need a valid context. No explicit activation
is needed, all it has to do is to exist. Its destructor
will take care of deactivating and freeing all the attached
resources.

Usage example:
```c++
void threadFunction(void*)
   SF::Context context
   # from now on, you have a valid context

   # you can make OpenGL calls
   glClear(GL_DEPTH_BUFFER_BIT)
end
# the context is automatically deactivated and destroyed
# by the SF::Context destructor
```

## SF::Context#active=(active)

Activate or deactivate explicitly the context

* *active* - True to activate, false to deactivate

*Returns:* True on success, false on failure

## SF::Context.active_context()

Get the currently active context

This function will only return `SF::Context` objects.
Contexts created e.g. by RenderTargets or for internal
use will not be returned by this function.

*Returns:* The currently active context or NULL if none is active

## SF::Context.active_context()

:nodoc:

## SF::Context.active_context_id()

Get the currently active context's ID

The context ID is used to identify contexts when
managing unshareable OpenGL resources.

*Returns:* The active context's ID or 0 if no context is currently active

## SF::Context.extension_available?(name)

Check whether a given OpenGL extension is available

* *name* - Name of the extension to check for

*Returns:* True if available, false if unavailable

## SF::Context#finalize()

Destructor

The destructor deactivates and destroys the context

## SF::Context#initialize()

Default constructor

The constructor creates and activates the context

## SF::Context#initialize(settings,width,height)

Construct a in-memory context

This constructor is for internal use, you don't need
to bother with it.

* *settings* - Creation parameters
* *width* - Back buffer width
* *height* - Back buffer height

## SF::Context#settings()

Get the settings of the context

Note that these settings may be different than the ones
passed to the constructor; they are indeed adjusted if the
original settings are not directly supported by the system.

*Returns:* Structure containing the settings

# SF::ContextSettings

Structure defining the settings of the OpenGL
context attached to a window

ContextSettings allows to define several advanced settings
of the OpenGL context attached to a window. All these
settings with the exception of the compatibility flag
and anti-aliasing level have no impact on the regular
SFML rendering (graphics module), so you may need to use
this structure only if you're using SFML as a windowing
system for custom OpenGL rendering.

The depth_bits and stencil_bits members define the number
of bits per pixel requested for the (respectively) depth
and stencil buffers.

antialiasing_level represents the requested number of
multisampling levels for anti-aliasing.

major_version and minor_version define the version of the
OpenGL context that you want. Only versions greater or
equal to 3.0 are relevant; versions lesser than 3.0 are
all handled the same way (i.e. you can use any version
&lt; 3.0 if you don't want an OpenGL 3 context).

When requesting a context with a version greater or equal
to 3.2, you have the option of specifying whether the
context should follow the core or compatibility profile
of all newer (>= 3.2) OpenGL specifications. For versions 3.0
and 3.1 there is only the core profile. By default a
compatibility context is created. You only need to specify
the core flag if you want a core profile context to use with
your own OpenGL rendering.
**Warning: The graphics module will not function if you
request a core profile context. Make sure the attributes are
set to Default if you want to use the graphics module.**

Setting the debug attribute flag will request a context with
additional debugging features enabled. Depending on the
system, this might be required for advanced OpenGL debugging.
OpenGL debugging is disabled by default.

**Special Note for OS X:**
Apple only supports choosing between either a legacy context
(OpenGL 2.1) or a core context (OpenGL version depends on the
operating system version but is at least 3.2). Compatibility
contexts are not supported. Further information is available on the
[OpenGL Capabilities Tables](https://developer.apple.com/opengl/capabilities/index.html)
page. OS X also currently does not support debug contexts.

Please note that these values are only a hint.
No failure will be reported if one or more of these values
are not supported by the system; instead, SFML will try to
find the closest valid match. You can then retrieve the
settings that the window actually used to create its context,
with Window.settings().

## SF::ContextSettings::Attribute

Enumeration of the context attribute flags

### SF::ContextSettings::Attribute::Core

Core attribute

### SF::ContextSettings::Attribute::Debug

Debug attribute

### SF::ContextSettings::Attribute::Default

Non-debug, compatibility context (this and the core attribute are mutually exclusive)

## SF::ContextSettings#antialiasing_level()

Level of antialiasing

## SF::ContextSettings#attribute_flags()

The attribute flags to create the context with

## SF::ContextSettings#depth_bits()

Bits of the depth buffer

## SF::ContextSettings#initialize(copy)

:nodoc:

## SF::ContextSettings#initialize(depth,stencil,antialiasing,major,minor,attributes,s_rgb)

Default constructor

* *depth* - Depth buffer bits
* *stencil* - Stencil buffer bits
* *antialiasing* - Antialiasing level
* *major* - Major number of the context version
* *minor* - Minor number of the context version
* *attributes* - Attribute flags of the context
* *s_rgb* - sRGB capable framebuffer

## SF::ContextSettings#major_version()

Major number of the context version to create

## SF::ContextSettings#minor_version()

Minor number of the context version to create

## SF::ContextSettings#s_rgb_capable()

Whether the context framebuffer is sRGB capable

## SF::ContextSettings#stencil_bits()

Bits of the stencil buffer

# SF::Cursor

Cursor defines the appearance of a system cursor

*Warning:* Features related to Cursor are not supported on
iOS and Android.

This class abstracts the operating system resources
associated with either a native system cursor or a custom
cursor.

After loading the cursor the graphical appearance
with either load_from_pixels() or load_from_system(), the
cursor can be changed with `SF::Window::mouse_cursor=`().

The behaviour is undefined if the cursor is destroyed while
in use by the window.

Usage example:
```c++
sf::Window window;

// ... create window as usual ...

sf::Cursor cursor;
if (cursor.loadFromSystem(sf::Cursor::Hand))
    window.setMouseCursor(cursor);
```

*See also:* `SF::`Window`::mouse_cursor=`

## SF::Cursor::Type

Enumeration of the native system cursor types

Refer to the following table to determine which cursor
is available on which platform.

 Type                               | Linux | Mac OS X | Windows  |
------------------------------------|:-----:|:--------:|:--------:|
 `SF::Cursor::Arrow`                  |  yes  |    yes   |   yes    |
 `SF::Cursor::ArrowWait`              |  no   |    no    |   yes    |
 `SF::Cursor::Wait`                   |  yes  |    no    |   yes    |
 `SF::Cursor::Text`                   |  yes  |    yes   |   yes    |
 `SF::Cursor::Hand`                   |  yes  |    yes   |   yes    |
 `SF::Cursor::SizeHorizontal`         |  yes  |    yes   |   yes    |
 `SF::Cursor::SizeVertical`           |  yes  |    yes   |   yes    |
 `SF::Cursor::SizeTopLeftBottomRight` |  no   |    yes*  |   yes    |
 `SF::Cursor::SizeBottomLeftTopRight` |  no   |    yes*  |   yes    |
 `SF::Cursor::SizeAll`                |  yes  |    no    |   yes    |
 `SF::Cursor::Cross`                  |  yes  |    yes   |   yes    |
 `SF::Cursor::Help`                   |  yes  |    yes*  |   yes    |
 `SF::Cursor::NotAllowed`             |  yes  |    yes   |   yes    |

 * These cursor types are undocumented so may not
   be available on all versions, but have been tested on 10.13

### SF::Cursor::Type::Arrow

Arrow cursor (default)

### SF::Cursor::Type::ArrowWait

Busy arrow cursor

### SF::Cursor::Type::Cross

Crosshair cursor

### SF::Cursor::Type::Hand

Pointing hand cursor

### SF::Cursor::Type::Help

Help cursor

### SF::Cursor::Type::NotAllowed

Action not allowed cursor

### SF::Cursor::Type::SizeAll

Combination of SizeHorizontal and SizeVertical

### SF::Cursor::Type::SizeBottomLeftTopRight

Double arrow cursor going from bottom-left to top-right

### SF::Cursor::Type::SizeHorizontal

Horizontal double arrow cursor

### SF::Cursor::Type::SizeTopLeftBottomRight

Double arrow cursor going from top-left to bottom-right

### SF::Cursor::Type::SizeVertical

Vertical double arrow cursor

### SF::Cursor::Type::Text

I-beam, cursor when hovering over a field allowing text entry

### SF::Cursor::Type::Wait

Busy cursor

## SF::Cursor#finalize()

Destructor

This destructor releases the system resources
associated with this cursor, if any.

## SF::Cursor#initialize()

Default constructor

This constructor doesn't actually create the cursor;
initially the new instance is invalid and must not be
used until either load_from_pixels() or load_from_system()
is called and successfully created a cursor.

## SF::Cursor#load_from_pixels(pixels,size,hotspot)

Create a cursor with the provided image

*pixels* must be an array of *width* by *height* pixels
in 32-bit RGBA format. If not, this will cause undefined behavior.

If *pixels* is null or either *width* or *height* are 0,
the current cursor is left unchanged and the function will
return false.

In addition to specifying the pixel data, you can also
specify the location of the hotspot of the cursor. The
hotspot is the pixel coordinate within the cursor image
which will be located exactly where the mouse pointer
position is. Any mouse actions that are performed will
return the window/screen location of the hotspot.

*Warning:* On Unix, the pixels are mapped into a monochrome
bitmap: pixels with an alpha channel to 0 are
transparent, black if the RGB channel are close
to zero, and white otherwise.

* *pixels* - Array of pixels of the image
* *size* - Width and height of the image
* *hotspot* - (x,y) location of the hotspot
*Returns:* true if the cursor was successfully loaded;
false otherwise

## SF::Cursor#load_from_system(type)

Create a native system cursor

Refer to the list of cursor available on each system
(see `SF::Cursor::Type`) to know whether a given cursor is
expected to load successfully or is not supported by
the operating system.

* *type* - Native system cursor type
*Returns:* true if and only if the corresponding cursor is
natively supported by the operating system;
false otherwise

# SF::Event

Defines a system event and its parameters

`SF::Event` holds all the informations about a system event
that just happened. Events are retrieved using the
`SF::Window.poll_event` and `SF::Window.wait_event` functions.

A `SF::Event` instance contains the type of the event
(mouse moved, key pressed, window closed, ...) as well
as the details about this particular event. Please note that
the event parameters are defined in a union, which means that
only the member matching the type of the event will be properly
filled; all other members will have undefined values and must not
be read if the type of the event doesn't match. For example,
if you received a KeyPressed event, then you must read the
event.key member, all other members such as event.mouse_move
or event.text will have undefined values.

Usage example:
```
while (event = window.poll_event())
  case event
  # Request for closing the window
  when SF::Event::Closed
    window.close()

  # The escape key was pressed
  when SF::Event::KeyPressed
    if event.code == SF::Keyboard::Escape
      window.close()
    end

  # The window was resized
  when SF::Event::Resized
    do_something(event.width, event.height)

  # etc ...
  end
end
```

## SF::Event::Closed

The window requested to be closed (no data)

## SF::Event::EventType

:nodoc:
Enumeration of the different types of events

### SF::Event::EventType::Closed

The window requested to be closed (no data)

### SF::Event::EventType::Count

Keep last -- the total number of event types

### SF::Event::EventType::GainedFocus

The window gained the focus (no data)

### SF::Event::EventType::JoystickButtonPressed

A joystick button was pressed (data in event.joystick_button)

### SF::Event::EventType::JoystickButtonReleased

A joystick button was released (data in event.joystick_button)

### SF::Event::EventType::JoystickConnected

A joystick was connected (data in event.joystick_connect)

### SF::Event::EventType::JoystickDisconnected

A joystick was disconnected (data in event.joystick_connect)

### SF::Event::EventType::JoystickMoved

The joystick moved along an axis (data in event.joystick_move)

### SF::Event::EventType::KeyPressed

A key was pressed (data in event.key)

### SF::Event::EventType::KeyReleased

A key was released (data in event.key)

### SF::Event::EventType::LostFocus

The window lost the focus (no data)

### SF::Event::EventType::MouseButtonPressed

A mouse button was pressed (data in event.mouse_button)

### SF::Event::EventType::MouseButtonReleased

A mouse button was released (data in event.mouse_button)

### SF::Event::EventType::MouseEntered

The mouse cursor entered the area of the window (no data)

### SF::Event::EventType::MouseLeft

The mouse cursor left the area of the window (no data)

### SF::Event::EventType::MouseMoved

The mouse cursor moved (data in event.mouse_move)

### SF::Event::EventType::MouseWheelMoved

The mouse wheel was scrolled (data in event.mouse_wheel) (deprecated)

### SF::Event::EventType::MouseWheelScrolled

The mouse wheel was scrolled (data in event.mouse_wheel_scroll)

### SF::Event::EventType::Resized

The window was resized (data in event.size)

### SF::Event::EventType::SensorChanged

A sensor value changed (data in event.sensor)

### SF::Event::EventType::TextEntered

A character was entered (data in event.text)

### SF::Event::EventType::TouchBegan

A touch event began (data in event.touch)

### SF::Event::EventType::TouchEnded

A touch event ended (data in event.touch)

### SF::Event::EventType::TouchMoved

A touch moved (data in event.touch)

## SF::Event::GainedFocus

The window gained the focus (no data)

## SF::Event::JoystickButtonEvent

Joystick buttons events parameters
(JoystickButtonPressed, JoystickButtonReleased)

### SF::Event::JoystickButtonEvent#button()

Index of the button that has been pressed (in range `0 ... Joystick::ButtonCount`)

### SF::Event::JoystickButtonEvent#initialize(copy)

:nodoc:

### SF::Event::JoystickButtonEvent#joystick_id()

Index of the joystick (in range `0 ... Joystick::Count`)

## SF::Event::JoystickButtonPressed

A joystick button was pressed (data in event.joystick_button)

## SF::Event::JoystickButtonReleased

A joystick button was released (data in event.joystick_button)

## SF::Event::JoystickConnectEvent

Joystick connection events parameters
(JoystickConnected, JoystickDisconnected)

### SF::Event::JoystickConnectEvent#initialize(copy)

:nodoc:

### SF::Event::JoystickConnectEvent#joystick_id()

Index of the joystick (in range `0 ... Joystick::Count`)

## SF::Event::JoystickConnected

A joystick was connected (data in event.joystick_connect)

## SF::Event::JoystickDisconnected

A joystick was disconnected (data in event.joystick_connect)

## SF::Event::JoystickMoveEvent

Joystick axis move event parameters (JoystickMoved)

### SF::Event::JoystickMoveEvent#axis()

Axis on which the joystick moved

### SF::Event::JoystickMoveEvent#initialize(copy)

:nodoc:

### SF::Event::JoystickMoveEvent#joystick_id()

Index of the joystick (in range `0 ... Joystick::Count`)

### SF::Event::JoystickMoveEvent#position()

New position on the axis (in range `-100 .. 100`)

## SF::Event::JoystickMoved

The joystick moved along an axis (data in event.joystick_move)

## SF::Event::KeyEvent

Keyboard event parameters (KeyPressed, KeyReleased)

### SF::Event::KeyEvent#alt()

Is the Alt key pressed?

### SF::Event::KeyEvent#code()

Code of the key that has been pressed

### SF::Event::KeyEvent#control()

Is the Control key pressed?

### SF::Event::KeyEvent#initialize(copy)

:nodoc:

### SF::Event::KeyEvent#shift()

Is the Shift key pressed?

### SF::Event::KeyEvent#system()

Is the System key pressed?

## SF::Event::KeyPressed

A key was pressed (data in event.key)

## SF::Event::KeyReleased

A key was released (data in event.key)

## SF::Event::LostFocus

The window lost the focus (no data)

## SF::Event::MouseButtonEvent

Mouse buttons events parameters
(MouseButtonPressed, MouseButtonReleased)

### SF::Event::MouseButtonEvent#button()

Code of the button that has been pressed

### SF::Event::MouseButtonEvent#initialize(copy)

:nodoc:

### SF::Event::MouseButtonEvent#x()

X position of the mouse pointer, relative to the left of the owner window

### SF::Event::MouseButtonEvent#y()

Y position of the mouse pointer, relative to the top of the owner window

## SF::Event::MouseButtonPressed

A mouse button was pressed (data in event.mouse_button)

## SF::Event::MouseButtonReleased

A mouse button was released (data in event.mouse_button)

## SF::Event::MouseEntered

The mouse cursor entered the area of the window (no data)

## SF::Event::MouseLeft

The mouse cursor left the area of the window (no data)

## SF::Event::MouseMoveEvent

Mouse move event parameters (MouseMoved)

### SF::Event::MouseMoveEvent#initialize(copy)

:nodoc:

### SF::Event::MouseMoveEvent#x()

X position of the mouse pointer, relative to the left of the owner window

### SF::Event::MouseMoveEvent#y()

Y position of the mouse pointer, relative to the top of the owner window

## SF::Event::MouseMoved

The mouse cursor moved (data in event.mouse_move)

## SF::Event::MouseWheelEvent

Mouse wheel events parameters (MouseWheelMoved)

DEPRECATED: This event is deprecated and potentially inaccurate.
Use MouseWheelScrollEvent instead.

### SF::Event::MouseWheelEvent#delta()

Number of ticks the wheel has moved (positive is up, negative is down)

### SF::Event::MouseWheelEvent#initialize(copy)

:nodoc:

### SF::Event::MouseWheelEvent#x()

X position of the mouse pointer, relative to the left of the owner window

### SF::Event::MouseWheelEvent#y()

Y position of the mouse pointer, relative to the top of the owner window

## SF::Event::MouseWheelMoved

The mouse wheel was scrolled (data in event.mouse_wheel) (deprecated)

## SF::Event::MouseWheelScrollEvent

Mouse wheel events parameters (MouseWheelScrolled)

### SF::Event::MouseWheelScrollEvent#delta()

Wheel offset (positive is up/left, negative is down/right). High-precision mice may use non-integral offsets.

### SF::Event::MouseWheelScrollEvent#initialize(copy)

:nodoc:

### SF::Event::MouseWheelScrollEvent#wheel()

Which wheel (for mice with multiple ones)

### SF::Event::MouseWheelScrollEvent#x()

X position of the mouse pointer, relative to the left of the owner window

### SF::Event::MouseWheelScrollEvent#y()

Y position of the mouse pointer, relative to the top of the owner window

## SF::Event::MouseWheelScrolled

The mouse wheel was scrolled (data in event.mouse_wheel_scroll)

## SF::Event::Resized

The window was resized (data in event.size)

## SF::Event::SensorChanged

A sensor value changed (data in event.sensor)

## SF::Event::SensorEvent

Sensor event parameters (SensorChanged)

### SF::Event::SensorEvent#initialize(copy)

:nodoc:

### SF::Event::SensorEvent#type()

Type of the sensor

### SF::Event::SensorEvent#x()

Current value of the sensor on X axis

### SF::Event::SensorEvent#y()

Current value of the sensor on Y axis

### SF::Event::SensorEvent#z()

Current value of the sensor on Z axis

## SF::Event::SizeEvent

Size events parameters (Resized)

### SF::Event::SizeEvent#height()

New height, in pixels

### SF::Event::SizeEvent#initialize(copy)

:nodoc:

### SF::Event::SizeEvent#width()

New width, in pixels

## SF::Event::TextEntered

A character was entered (data in event.text)

## SF::Event::TextEvent

Text event parameters (TextEntered)

### SF::Event::TextEvent#initialize(copy)

:nodoc:

### SF::Event::TextEvent#unicode()

UTF-32 Unicode value of the character

## SF::Event::TouchBegan

A touch event began (data in event.touch)

## SF::Event::TouchEnded

A touch event ended (data in event.touch)

## SF::Event::TouchEvent

Touch events parameters (TouchBegan, TouchMoved, TouchEnded)

### SF::Event::TouchEvent#finger()

Index of the finger in case of multi-touch events

### SF::Event::TouchEvent#initialize(copy)

:nodoc:

### SF::Event::TouchEvent#x()

X position of the touch, relative to the left of the owner window

### SF::Event::TouchEvent#y()

Y position of the touch, relative to the top of the owner window

## SF::Event::TouchMoved

A touch moved (data in event.touch)

# SF::GlResource

Empty module that indicates the class requires an OpenGL context

# SF::Joystick

Give access to the real-time state of the joysticks

`SF::Joystick` provides an interface to the state of the
joysticks. It only contains static functions, so it's not
meant to be instantiated. Instead, each joystick is identified
by an index that is passed to the functions of this module.

This module allows users to query the state of joysticks at any
time and directly, without having to deal with a window and
its events. Compared to the `JoystickMoved`, `JoystickButtonPressed`
and `JoystickButtonReleased` events, `SF::Joystick` can retrieve the
state of axes and buttons of joysticks at any time
(you don't need to store and update a boolean on your side
in order to know if a button is pressed or released), and you
always get the real state of joysticks, even if they are
moved, pressed or released when your window is out of focus
and no event is triggered.

SFML supports:
* 8 joysticks (`SF::Joystick::Count`)
* 32 buttons per joystick (`SF::Joystick::ButtonCount`)
* 8 axes per joystick (`SF::Joystick::AxisCount`)

Unlike the keyboard or mouse, the state of joysticks is sometimes
not directly available (depending on the OS), therefore an update()
function must be called in order to update the current state of
joysticks. When you have a window with event handling, this is done
automatically, you don't need to call anything. But if you have no
window, or if you want to check joysticks state before creating one,
you must call `SF::Joystick.update` explicitly.

Usage example:
```
# Is joystick #0 connected?
connected = SF::Joystick.connected?(0)

# How many buttons does joystick #0 support?
buttons = SF::Joystick.get_button_count(0)

# Does joystick #0 define a X axis?
has_x = SF::Joystick.axis?(0, SF::Joystick::X)

# Is button #2 pressed on joystick #0?
pressed = SF::Joystick.button_pressed?(0, 2)

# What's the current position of the Y axis on joystick #0?
position = SF::Joystick.get_axis_position(0, SF::Joystick::Y)
```

*See also:* `SF::Keyboard`, `SF::Mouse`

## SF::Joystick::Axis

Axes supported by SFML joysticks

### SF::Joystick::Axis::PovX

The X axis of the point-of-view hat

### SF::Joystick::Axis::PovY

The Y axis of the point-of-view hat

### SF::Joystick::Axis::R

The R axis

### SF::Joystick::Axis::U

The U axis

### SF::Joystick::Axis::V

The V axis

### SF::Joystick::Axis::X

The X axis

### SF::Joystick::Axis::Y

The Y axis

### SF::Joystick::Axis::Z

The Z axis

## SF::Joystick::AxisCount

Maximum number of supported axes

## SF::Joystick::ButtonCount

Maximum number of supported buttons

## SF::Joystick::Count

Maximum number of supported joysticks

## SF::Joystick::Identification

Structure holding a joystick's identification

### SF::Joystick::Identification#initialize(copy)

:nodoc:

### SF::Joystick::Identification#name()

Name of the joystick

### SF::Joystick::Identification#product_id()

Product identifier

### SF::Joystick::Identification#vendor_id()

Manufacturer identifier

## SF::Joystick.axis?(joystick,axis)

Check if a joystick supports a given axis

If the joystick is not connected, this function returns false.

* *joystick* - Index of the joystick
* *axis* - Axis to check

*Returns:* True if the joystick supports the axis, false otherwise

## SF::Joystick.button_pressed?(joystick,button)

Check if a joystick button is pressed

If the joystick is not connected, this function returns false.

* *joystick* - Index of the joystick
* *button* - Button to check

*Returns:* True if the button is pressed, false otherwise

## SF::Joystick.connected?(joystick)

Check if a joystick is connected

* *joystick* - Index of the joystick to check

*Returns:* True if the joystick is connected, false otherwise

## SF::Joystick.get_axis_position(joystick,axis)

Get the current position of a joystick axis

If the joystick is not connected, this function returns 0.

* *joystick* - Index of the joystick
* *axis* - Axis to check

*Returns:* Current position of the axis, in range `-100 .. 100`

## SF::Joystick.get_button_count(joystick)

Return the number of buttons supported by a joystick

If the joystick is not connected, this function returns 0.

* *joystick* - Index of the joystick

*Returns:* Number of buttons supported by the joystick

## SF::Joystick.get_identification(joystick)

Get the joystick information

* *joystick* - Index of the joystick

*Returns:* Structure containing joystick information.

## SF::Joystick.update()

Update the states of all joysticks

This function is used internally by SFML, so you normally
don't have to call it explicitly. However, you may need to
call it if you have no window yet (or no window at all):
in this case the joystick states are not updated automatically.

# SF::Keyboard

Give access to the real-time state of the keyboard

`SF::Keyboard` provides an interface to the state of the
keyboard. It only contains static functions (a single
keyboard is assumed), so it's not meant to be instantiated.

This module allows users to query the keyboard state at any
time and directly, without having to deal with a window and
its events. Compared to the `KeyPressed` and `KeyReleased` events,
`SF::Keyboard` can retrieve the state of a key at any time
(you don't need to store and update a boolean on your side
in order to know if a key is pressed or released), and you
always get the real state of the keyboard, even if keys are
pressed or released when your window is out of focus and no
event is triggered.

Usage example:
```
if SF::Keyboard.key_pressed?(SF::Keyboard::Left)
  # move left...
elsif SF::Keyboard.key_pressed?(SF::Keyboard::Right)
  # move right...
elsif SF::Keyboard.key_pressed?(SF::Keyboard::Escape)
  # quit...
end
```

*See also:* `SF::Joystick`, `SF::Mouse`, `SF::Touch`

## SF::Keyboard::Key

Key codes

### SF::Keyboard::Key::A

The A key

### SF::Keyboard::Key::Add

The + key

### SF::Keyboard::Key::B

The B key

### SF::Keyboard::Key::BackSlash

DEPRECATED: Use Backslash instead

### SF::Keyboard::Key::BackSpace

DEPRECATED: Use Backspace instead

### SF::Keyboard::Key::Backslash

The \ key

### SF::Keyboard::Key::Backspace

The Backspace key

### SF::Keyboard::Key::C

The C key

### SF::Keyboard::Key::Comma

The , key

### SF::Keyboard::Key::D

The D key

### SF::Keyboard::Key::Dash

DEPRECATED: Use Hyphen instead

### SF::Keyboard::Key::Delete

The Delete key

### SF::Keyboard::Key::Divide

The / key

### SF::Keyboard::Key::Down

Down arrow

### SF::Keyboard::Key::E

The E key

### SF::Keyboard::Key::End

The End key

### SF::Keyboard::Key::Enter

The Enter/Return keys

### SF::Keyboard::Key::Equal

The = key

### SF::Keyboard::Key::Escape

The Escape key

### SF::Keyboard::Key::F

The F key

### SF::Keyboard::Key::F1

The F1 key

### SF::Keyboard::Key::F10

The F10 key

### SF::Keyboard::Key::F11

The F11 key

### SF::Keyboard::Key::F12

The F12 key

### SF::Keyboard::Key::F13

The F13 key

### SF::Keyboard::Key::F14

The F14 key

### SF::Keyboard::Key::F15

The F15 key

### SF::Keyboard::Key::F2

The F2 key

### SF::Keyboard::Key::F3

The F3 key

### SF::Keyboard::Key::F4

The F4 key

### SF::Keyboard::Key::F5

The F5 key

### SF::Keyboard::Key::F6

The F6 key

### SF::Keyboard::Key::F7

The F7 key

### SF::Keyboard::Key::F8

The F8 key

### SF::Keyboard::Key::F9

The F9 key

### SF::Keyboard::Key::G

The G key

### SF::Keyboard::Key::H

The H key

### SF::Keyboard::Key::Home

The Home key

### SF::Keyboard::Key::Hyphen

The - key (hyphen)

### SF::Keyboard::Key::I

The I key

### SF::Keyboard::Key::Insert

The Insert key

### SF::Keyboard::Key::J

The J key

### SF::Keyboard::Key::K

The K key

### SF::Keyboard::Key::KeyCount

Keep last -- the total number of keyboard keys

### SF::Keyboard::Key::L

The L key

### SF::Keyboard::Key::LAlt

The left Alt key

### SF::Keyboard::Key::LBracket

The [ key

### SF::Keyboard::Key::LControl

The left Control key

### SF::Keyboard::Key::LShift

The left Shift key

### SF::Keyboard::Key::LSystem

The left OS specific key: window (Windows and Linux), apple (MacOS X), ...

### SF::Keyboard::Key::Left

Left arrow

### SF::Keyboard::Key::M

The M key

### SF::Keyboard::Key::Menu

The Menu key

### SF::Keyboard::Key::Multiply

The * key

### SF::Keyboard::Key::N

The N key

### SF::Keyboard::Key::Num0

The 0 key

### SF::Keyboard::Key::Num1

The 1 key

### SF::Keyboard::Key::Num2

The 2 key

### SF::Keyboard::Key::Num3

The 3 key

### SF::Keyboard::Key::Num4

The 4 key

### SF::Keyboard::Key::Num5

The 5 key

### SF::Keyboard::Key::Num6

The 6 key

### SF::Keyboard::Key::Num7

The 7 key

### SF::Keyboard::Key::Num8

The 8 key

### SF::Keyboard::Key::Num9

The 9 key

### SF::Keyboard::Key::Numpad0

The numpad 0 key

### SF::Keyboard::Key::Numpad1

The numpad 1 key

### SF::Keyboard::Key::Numpad2

The numpad 2 key

### SF::Keyboard::Key::Numpad3

The numpad 3 key

### SF::Keyboard::Key::Numpad4

The numpad 4 key

### SF::Keyboard::Key::Numpad5

The numpad 5 key

### SF::Keyboard::Key::Numpad6

The numpad 6 key

### SF::Keyboard::Key::Numpad7

The numpad 7 key

### SF::Keyboard::Key::Numpad8

The numpad 8 key

### SF::Keyboard::Key::Numpad9

The numpad 9 key

### SF::Keyboard::Key::O

The O key

### SF::Keyboard::Key::P

The P key

### SF::Keyboard::Key::PageDown

The Page down key

### SF::Keyboard::Key::PageUp

The Page up key

### SF::Keyboard::Key::Pause

The Pause key

### SF::Keyboard::Key::Period

The . key

### SF::Keyboard::Key::Q

The Q key

### SF::Keyboard::Key::Quote

The ' key

### SF::Keyboard::Key::R

The R key

### SF::Keyboard::Key::RAlt

The right Alt key

### SF::Keyboard::Key::RBracket

The ] key

### SF::Keyboard::Key::RControl

The right Control key

### SF::Keyboard::Key::RShift

The right Shift key

### SF::Keyboard::Key::RSystem

The right OS specific key: window (Windows and Linux), apple (MacOS X), ...

### SF::Keyboard::Key::Return

DEPRECATED: Use Enter instead

### SF::Keyboard::Key::Right

Right arrow

### SF::Keyboard::Key::S

The S key

### SF::Keyboard::Key::SemiColon

DEPRECATED: Use Semicolon instead

### SF::Keyboard::Key::Semicolon

The ; key

### SF::Keyboard::Key::Slash

The / key

### SF::Keyboard::Key::Space

The Space key

### SF::Keyboard::Key::Subtract

The - key (minus, usually from numpad)

### SF::Keyboard::Key::T

The T key

### SF::Keyboard::Key::Tab

The Tabulation key

### SF::Keyboard::Key::Tilde

The ~ key

### SF::Keyboard::Key::U

The U key

### SF::Keyboard::Key::Unknown

Unhandled key

### SF::Keyboard::Key::Up

Up arrow

### SF::Keyboard::Key::V

The V key

### SF::Keyboard::Key::W

The W key

### SF::Keyboard::Key::X

The X key

### SF::Keyboard::Key::Y

The Y key

### SF::Keyboard::Key::Z

The Z key

## SF::Keyboard.key_pressed?(key)

Check if a key is pressed

* *key* - Key to check

*Returns:* True if the key is pressed, false otherwise

## SF::Keyboard.virtual_keyboard_visible=(visible)

Show or hide the virtual keyboard

Warning: the virtual keyboard is not supported on all
systems. It will typically be implemented on mobile OSes
(Android, iOS) but not on desktop OSes (Windows, Linux, ...).

If the virtual keyboard is not available, this function does
nothing.

* *visible* - True to show, false to hide

# SF::Mouse

Give access to the real-time state of the mouse

`SF::Mouse` provides an interface to the state of the
mouse. It only contains static functions (a single
mouse is assumed), so it's not meant to be instantiated.

This module allows users to query the mouse state at any
time and directly, without having to deal with a window and
its events. Compared to the `MouseMoved`, `MouseButtonPressed`
and `MouseButtonReleased` events, `SF::Mouse` can retrieve the
state of the cursor and the buttons at any time
(you don't need to store and update a boolean on your side
in order to know if a button is pressed or released), and you
always get the real state of the mouse, even if it is
moved, pressed or released when your window is out of focus
and no event is triggered.

The position= and position functions can be used to change
or retrieve the current position of the mouse pointer. There are
two versions: one that operates in global coordinates (relative
to the desktop) and one that operates in window coordinates
(relative to a specific window).

Usage example:
```
if SF::Mouse.button_pressed?(SF::Mouse::Left)
  # left click...
end

# get global mouse position
position = SF::Mouse.position

# set mouse position relative to a window
SF::Mouse.set_position(SF.vector2i(100, 200), window)
```

*See also:* `SF::Joystick`, `SF::Keyboard`, `SF::Touch`

## SF::Mouse::Button

Mouse buttons

### SF::Mouse::Button::ButtonCount

Keep last -- the total number of mouse buttons

### SF::Mouse::Button::Left

The left mouse button

### SF::Mouse::Button::Middle

The middle (wheel) mouse button

### SF::Mouse::Button::Right

The right mouse button

### SF::Mouse::Button::XButton1

The first extra mouse button

### SF::Mouse::Button::XButton2

The second extra mouse button

## SF::Mouse::Wheel

Mouse wheels

### SF::Mouse::Wheel::HorizontalWheel

The horizontal mouse wheel

### SF::Mouse::Wheel::VerticalWheel

The vertical mouse wheel

## SF::Mouse.button_pressed?(button)

Check if a mouse button is pressed

* *button* - Button to check

*Returns:* True if the button is pressed, false otherwise

## SF::Mouse.get_position(relative_to)

Get the current position of the mouse in window coordinates

This function returns the current position of the mouse
cursor, relative to the given window.

* *relative_to* - Reference window

*Returns:* Current position of the mouse

## SF::Mouse.position()

Get the current position of the mouse in desktop coordinates

This function returns the global position of the mouse
cursor on the desktop.

*Returns:* Current position of the mouse

## SF::Mouse.position=(position)

Set the current position of the mouse in desktop coordinates

This function sets the global position of the mouse
cursor on the desktop.

* *position* - New position of the mouse

## SF::Mouse.set_position(position,relative_to)

Set the current position of the mouse in window coordinates

This function sets the current position of the mouse
cursor, relative to the given window.

* *position* - New position of the mouse
* *relative_to* - Reference window

# SF::Sensor

Give access to the real-time state of the sensors

`SF::Sensor` provides an interface to the state of the
various sensors that a device provides. It only contains static
functions, so it's not meant to be instantiated.

This module allows users to query the sensors values at any
time and directly, without having to deal with a window and
its events. Compared to the `SensorChanged` event, `SF::Sensor`
can retrieve the state of a sensor at any time (you don't need to
store and update its current value on your side).

Depending on the OS and hardware of the device (phone, tablet, ...),
some sensor types may not be available. You should always check
the availability of a sensor before trying to read it, with the
`SF::Sensor.available?` function.

You may wonder why some sensor types look so similar, for example
Accelerometer and Gravity / UserAcceleration. The first one
is the raw measurement of the acceleration, and takes into account
both the earth gravity and the user movement. The others are
more precise: they provide these components separately, which is
usually more useful. In fact they are not direct sensors, they
are computed internally based on the raw acceleration and other sensors.
This is exactly the same for Gyroscope vs Orientation.

Because sensors consume a non-negligible amount of current, they are
all disabled by default. You must call `SF::Sensor.enabled=` for each
sensor in which you are interested.

Usage example:
```
if SF::Sensor.available?(SF::Sensor::Gravity)
  # gravity sensor is available
end

# enable the gravity sensor
SF::Sensor.set_enabled(SF::Sensor::Gravity, true)

# get the current value of gravity
gravity = SF::Sensor.get_value(SF::Sensor::Gravity)
```

## SF::Sensor::Type

Sensor type

### SF::Sensor::Type::Accelerometer

Measures the raw acceleration (m/s^2)

### SF::Sensor::Type::Count

Keep last -- the total number of sensor types

### SF::Sensor::Type::Gravity

Measures the direction and intensity of gravity, independent of device acceleration (m/s^2)

### SF::Sensor::Type::Gyroscope

Measures the raw rotation rates (degrees/s)

### SF::Sensor::Type::Magnetometer

Measures the ambient magnetic field (micro-teslas)

### SF::Sensor::Type::Orientation

Measures the absolute 3D orientation (degrees)

### SF::Sensor::Type::UserAcceleration

Measures the direction and intensity of device acceleration, independent of the gravity (m/s^2)

## SF::Sensor.available?(sensor)

Check if a sensor is available on the underlying platform

* *sensor* - Sensor to check

*Returns:* True if the sensor is available, false otherwise

## SF::Sensor.get_value(sensor)

Get the current sensor value

* *sensor* - Sensor to read

*Returns:* The current sensor value

## SF::Sensor.set_enabled(sensor,enabled)

Enable or disable a sensor

All sensors are disabled by default, to avoid consuming too
much battery power. Once a sensor is enabled, it starts
sending events of the corresponding type.

This function does nothing if the sensor is unavailable.

* *sensor* - Sensor to enable
* *enabled* - True to enable, false to disable

# SF::Style

Enumeration of the window styles

## SF::Style::Close

Title bar + close button

## SF::Style::Default

Default window style

## SF::Style::Fullscreen

Fullscreen mode (this flag and all others are mutually exclusive)

## SF::Style::Resize

Title bar + resizable border + maximize button

## SF::Style::Titlebar

Title bar + fixed border

# SF::Touch

Give access to the real-time state of the touches

`SF::Touch` provides an interface to the state of the
touches. It only contains static functions, so it's not
meant to be instantiated.

This module allows users to query the touches state at any
time and directly, without having to deal with a window and
its events. Compared to the TouchBegan, TouchMoved
and TouchEnded events, `SF::Touch` can retrieve the
state of the touches at any time (you don't need to store and
update a boolean on your side in order to know if a touch is down),
and you always get the real state of the touches, even if they
happen when your window is out of focus and no event is triggered.

The position function can be used to retrieve the current
position of a touch. There are two versions: one that operates
in global coordinates (relative to the desktop) and one that
operates in window coordinates (relative to a specific window).

Touches are identified by an index (the "finger"), so that in
multi-touch events, individual touches can be tracked correctly.
As long as a finger touches the screen, it will keep the same index
even if other fingers start or stop touching the screen in the
meantime. As a consequence, active touch indices may not always be
sequential (i.e. touch number 0 may be released while touch number 1
is still down).

Usage example:
```
if SF::Touch.down?(0)
  # touch 0 is down
end

# get global position of touch 1
global_pos = SF::Touch.get_position(1)

# get position of touch 1 relative to a window
relative_pos = SF::Touch.get_position(1, window)
```

*See also:* `SF::Joystick`, `SF::Keyboard`, `SF::Mouse`

## SF::Touch.down?(finger)

Check if a touch event is currently down

* *finger* - Finger index

*Returns:* True if *finger* is currently touching the screen, false otherwise

## SF::Touch.get_position(finger)

Get the current position of a touch in desktop coordinates

This function returns the current touch position
in global (desktop) coordinates.

* *finger* - Finger index

*Returns:* Current position of *finger,* or undefined if it's not down

## SF::Touch.get_position(finger,relative_to)

Get the current position of a touch in window coordinates

This function returns the current touch position
relative to the given window.

* *finger* - Finger index
* *relative_to* - Reference window

*Returns:* Current position of *finger,* or undefined if it's not down

# SF::VideoMode

VideoMode defines a video mode (width, height, bpp)

A video mode is defined by a width and a height (in pixels)
and a depth (in bits per pixel). Video modes are used to
setup windows (`SF::Window`) at creation time.

The main usage of video modes is for fullscreen mode:
indeed you must use one of the valid video modes
allowed by the OS (which are defined by what the monitor
and the graphics card support), otherwise your window
creation will just fail.

`SF::VideoMode` provides a static function for retrieving
the list of all the video modes supported by the system:
fullscreen_modes().

A custom video mode can also be checked directly for
fullscreen compatibility with its valid?() function.

Additionally, `SF::VideoMode` provides a static function
to get the mode currently used by the desktop: desktop_mode().
This allows to build windows with the same size or pixel
depth as the current resolution.

Usage example:
```
# Display the list of all the video modes available for fullscreen
SF::VideoMode.fullscreen_modes.each do |mode|
  puts "Mode ##{i}: #{mode.width}x#{mode.height} - #{mode.bits_per_pixel} bpp"
end

# Create a window with the same pixel depth as the desktop
desktop = SF::VideoMode.desktop_mode
window.create(SF::VideoMode.new(1024, 768, desktop.bits_per_pixel), "SFML window")
```

## SF::VideoMode#bits_per_pixel()

Video mode pixel depth, in bits per pixels

## SF::VideoMode.desktop_mode()

Get the current desktop video mode

*Returns:* Current desktop video mode

## SF::VideoMode.fullscreen_modes()

Retrieve all the video modes supported in fullscreen mode

When creating a fullscreen window, the video mode is restricted
to be compatible with what the graphics driver and monitor
support. This function returns the complete list of all video
modes that can be used in fullscreen mode.
The returned array is sorted from best to worst, so that
the first element will always give the best mode (higher
width, height and bits-per-pixel).

*Returns:* Array containing all the supported fullscreen modes

## SF::VideoMode#height()

Video mode height, in pixels

## SF::VideoMode#initialize()

Default constructor

This constructors initializes all members to 0.

## SF::VideoMode#initialize(copy)

:nodoc:

## SF::VideoMode#initialize(width,height,bits_per_pixel)

Construct the video mode with its attributes

* *width* - Width in pixels
* *height* - Height in pixels
* *bits_per_pixel* - Pixel depths in bits per pixel

## SF::VideoMode#==(right)

Overload of == operator to compare two video modes

* *left* - Left operand (a video mode)
* *right* - Right operand (a video mode)

*Returns:* True if modes are equal

## SF::VideoMode#!=(right)

Overload of != operator to compare two video modes

* *left* - Left operand (a video mode)
* *right* - Right operand (a video mode)

*Returns:* True if modes are different

## SF::VideoMode#<(right)

Overload of &lt; operator to compare video modes

* *left* - Left operand (a video mode)
* *right* - Right operand (a video mode)

*Returns:* True if *left* is lesser than *right*

## SF::VideoMode#>(right)

Overload of &gt; operator to compare video modes

* *left* - Left operand (a video mode)
* *right* - Right operand (a video mode)

*Returns:* True if *left* is greater than *right*

## SF::VideoMode#<=(right)

Overload of &lt;= operator to compare video modes

* *left* - Left operand (a video mode)
* *right* - Right operand (a video mode)

*Returns:* True if *left* is lesser or equal than *right*

## SF::VideoMode#>=(right)

Overload of &gt;= operator to compare video modes

* *left* - Left operand (a video mode)
* *right* - Right operand (a video mode)

*Returns:* True if *left* is greater or equal than *right*

## SF::VideoMode#valid?()

Tell whether or not the video mode is valid

The validity of video modes is only relevant when using
fullscreen windows; otherwise any video mode can be used
with no restriction.

*Returns:* True if the video mode is valid for fullscreen mode

## SF::VideoMode#width()

Video mode width, in pixels

# SF::Window

Window that serves as a target for OpenGL rendering

`SF::Window` is the main class of the Window module. It defines
an OS window that is able to receive an OpenGL rendering.

A `SF::Window` can create its own new window, or be embedded into
an already existing control using the create(handle) function.
This can be useful for embedding an OpenGL rendering area into
a view which is part of a bigger GUI with existing windows,
controls, etc. It can also serve as embedding an OpenGL rendering
area into a window created by another (probably richer) GUI library
like Qt or wx_widgets.

The `SF::Window` class provides a simple interface for manipulating
the window: move, resize, show/hide, control mouse cursor, etc.
It also provides event handling through its poll_event() and wait_event()
functions.

Note that OpenGL experts can pass their own parameters (antialiasing
level, bits for the depth and stencil buffers, etc.) to the
OpenGL context attached to the window, with the `SF::ContextSettings`
structure which is passed as an optional argument when creating the
window.

On dual-graphics systems consisting of a low-power integrated GPU
and a powerful discrete GPU, the driver picks which GPU will run an
SFML application. In order to inform the driver that an SFML application
can benefit from being run on the more powerful discrete GPU,
#SFML_DEFINE_DISCRETE_GPU_PREFERENCE can be placed in a source file
that is compiled and linked into the final application. The macro
should be placed outside of any scopes in the global namespace.

Usage example:
```
# Declare and create a new window
window = SF::Window.new(SF::VideoMode.new(800, 600), "SFML window")

# Limit the framerate to 60 frames per second (this step is optional)
window.framerate_limit = 60

# The main loop - ends as soon as the window is closed
while window.open?
  # Event processing
  while (event = window.poll_event())
    # Request for closing the window
    if event.is_a?(SF::Event::Closed)
      window.close()
    end
  end

  # Activate the window for OpenGL rendering
  window.active = true

  # OpenGL drawing commands go here...

  # End the current frame and display its contents on screen
  window.display()
end
```

## SF::Window#active=(active)

Activate or deactivate the window as the current target
for OpenGL rendering

A window is active only on the current thread, if you want to
make it active on another thread you have to deactivate it
on the previous thread first if it was active.
Only one window can be active on a thread at a time, thus
the window previously active (if any) automatically gets deactivated.
This is not to be confused with request_focus().

* *active* - True to activate, false to deactivate

*Returns:* True if operation was successful, false otherwise

## SF::Window#close()

Close the window and destroy all the attached resources

After calling this function, the `SF::Window` instance remains
valid and you can call create() to recreate the window.
All other functions such as poll_event() or display() will
still work (i.e. you don't have to test open?() every time),
and will have no effect on closed windows.

## SF::Window#create(handle,settings)

Create (or recreate) the window from an existing control

Use this function if you want to create an OpenGL
rendering area into an already existing control.
If the window was already created, it closes it first.

The second parameter is an optional structure specifying
advanced OpenGL context settings such as antialiasing,
depth-buffer bits, etc.

* *handle* - Platform-specific handle of the control
* *settings* - Additional settings for the underlying OpenGL context

## SF::Window#create(mode,title,style,settings)

Create (or recreate) the window

If the window was already created, it closes it first.
If *style* contains Style::Fullscreen, then *mode*
must be a valid video mode.

The fourth parameter is an optional structure specifying
advanced OpenGL context settings such as antialiasing,
depth-buffer bits, etc.

* *mode* - Video mode to use (defines the width, height and depth of the rendering area of the window)
* *title* - Title of the window
* *style* - Window style, a bitwise OR combination of `SF::Style` enumerators
* *settings* - Additional settings for the underlying OpenGL context

## SF::Window#display()

Display on screen what has been rendered to the window so far

This function is typically called after all OpenGL rendering
has been done for the current frame, in order to show
it on screen.

## SF::Window#finalize()

Destructor

Closes the window and frees all the resources attached to it.

## SF::Window#focus?()

Check whether the window has the input focus

At any given time, only one window may have the input focus
to receive input events such as keystrokes or most mouse
events.

*Returns:* True if window has focus, false otherwise
*See also:* `request_focus`

## SF::Window#framerate_limit=(limit)

Limit the framerate to a maximum fixed frequency

If a limit is set, the window will use a small delay after
each call to display() to ensure that the current frame
lasted long enough to match the framerate limit.
SFML will try to match the given limit as much as it can,
but since it internally uses `SF.sleep`, whose precision
depends on the underlying OS, the results may be a little
unprecise as well (for example, you can get 65 FPS when
requesting 60).

* *limit* - Framerate limit, in frames per seconds (use 0 to disable limit)

## SF::Window#initialize()

Default constructor

This constructor doesn't actually create the window,
use the other constructors or call create() to do so.

## SF::Window#initialize(handle,settings)

Construct the window from an existing control

Use this constructor if you want to create an OpenGL
rendering area into an already existing control.

The second parameter is an optional structure specifying
advanced OpenGL context settings such as antialiasing,
depth-buffer bits, etc.

* *handle* - Platform-specific handle of the control
* *settings* - Additional settings for the underlying OpenGL context

## SF::Window#initialize(mode,title,style,settings)

Construct a new window

This constructor creates the window with the size and pixel
depth defined in *mode.* An optional style can be passed to
customize the look and behavior of the window (borders,
title bar, resizable, closable, ...). If *style* contains
Style::Fullscreen, then *mode* must be a valid video mode.

The fourth parameter is an optional structure specifying
advanced OpenGL context settings such as antialiasing,
depth-buffer bits, etc.

* *mode* - Video mode to use (defines the width, height and depth of the rendering area of the window)
* *title* - Title of the window
* *style* - Window style, a bitwise OR combination of `SF::Style` enumerators
* *settings* - Additional settings for the underlying OpenGL context

## SF::Window#joystick_threshold=(threshold)

Change the joystick threshold

The joystick threshold is the value below which
no JoystickMoved event will be generated.

The threshold value is 0.1 by default.

* *threshold* - New threshold, in the range `0.0 .. 100.0`

## SF::Window#key_repeat_enabled=(enabled)

Enable or disable automatic key-repeat

If key repeat is enabled, you will receive repeated
KeyPressed events while keeping a key pressed. If it is disabled,
you will only get a single event when the key is pressed.

Key repeat is enabled by default.

* *enabled* - True to enable, false to disable

## SF::Window#mouse_cursor=(cursor)

Set the displayed cursor to a native system cursor

Upon window creation, the arrow cursor is used by default.

*Warning:* The cursor must not be destroyed while in use by
the window.

*Warning:* Features related to Cursor are not supported on
iOS and Android.

* *cursor* - Native system cursor type to display

*See also:* `SF::`Cursor`::load_from_system`
*See also:* `SF::`Cursor`::load_from_pixels`

## SF::Window#mouse_cursor_grabbed=(grabbed)

Grab or release the mouse cursor

If set, grabs the mouse cursor inside this window's client
area so it may no longer be moved outside its bounds.
Note that grabbing is only active while the window has
focus.

* *grabbed* - True to enable, false to disable

## SF::Window#mouse_cursor_visible=(visible)

Show or hide the mouse cursor

The mouse cursor is visible by default.

* *visible* - True to show the mouse cursor, false to hide it

## SF::Window#open?()

Tell whether or not the window is open

This function returns whether or not the window exists.
Note that a hidden window (visible=(false)) is open
(therefore this function would return true).

*Returns:* True if the window is open, false if it has been closed

## SF::Window#poll_event()

Pop the event on top of the event queue, if any, and return it

This function is not blocking: if there's no pending event then
it will return false and leave *event* unmodified.
Note that more than one event may be present in the event queue,
thus you should always call this function in a loop
to make sure that you process every pending event.
```
while (event = window.poll_event())
  # process event...
end
```

* *event* - Event to be returned

*Returns:* True if an event was returned, or false if the event queue was empty

*See also:* `wait_event`

## SF::Window#position()

Get the position of the window

*Returns:* Position of the window, in pixels

*See also:* `position=`

## SF::Window#position=(position)

Change the position of the window on screen

This function only works for top-level windows
(i.e. it will be ignored for windows created from
the handle of a child window/control).

* *position* - New position, in pixels

*See also:* `position`

## SF::Window#request_focus()

Request the current window to be made the active
foreground window

At any given time, only one window may have the input focus
to receive input events such as keystrokes or mouse events.
If a window requests focus, it only hints to the operating
system, that it would like to be focused. The operating system
is free to deny the request.
This is not to be confused with active=().

*See also:* `focus?`

## SF::Window#set_icon(width,height,pixels)

Change the window's icon

*pixels* must be an array of *width* x *height* pixels
in 32-bits RGBA format.

The OS default icon is used by default.

* *width* - Icon's width, in pixels
* *height* - Icon's height, in pixels
* *pixels* - Pointer to the array of pixels in memory. The
pixels are copied, so you need not keep the
source alive after calling this function.

*See also:* `title=`

## SF::Window#settings()

Get the settings of the OpenGL context of the window

Note that these settings may be different from what was
passed to the constructor or the create() function,
if one or more settings were not supported. In this case,
SFML chose the closest match.

*Returns:* Structure containing the OpenGL context settings

## SF::Window#size()

Get the size of the rendering region of the window

The size doesn't include the titlebar and borders
of the window.

*Returns:* Size in pixels

*See also:* `size=`

## SF::Window#size=(size)

Change the size of the rendering region of the window

* *size* - New size, in pixels

*See also:* `size`

## SF::Window#system_handle()

Get the OS-specific handle of the window

The type of the returned handle is `SF::WindowHandle`,
which is a typedef to the handle type defined by the OS.
You shouldn't need to use this function, unless you have
very specific stuff to implement that SFML doesn't support,
or implement a temporary workaround until a bug is fixed.

*Returns:* System handle of the window

## SF::Window#title=(title)

Change the title of the window

* *title* - New title

*See also:* `icon=`

## SF::Window#vertical_sync_enabled=(enabled)

Enable or disable vertical synchronization

Activating vertical synchronization will limit the number
of frames displayed to the refresh rate of the monitor.
This can avoid some visual artifacts, and limit the framerate
to a good value (but not constant across different computers).

Vertical synchronization is disabled by default.

* *enabled* - True to enable v-sync, false to deactivate it

## SF::Window#visible=(visible)

Show or hide the window

The window is shown by default.

* *visible* - True to show the window, false to hide it

## SF::Window#wait_event()

Wait for an event and return it

This function is blocking: if there's no pending event then
it will wait until an event is received.
After this function returns (and no error occurred),
the *event* object is always valid and filled properly.
This function is typically used when you have a thread that
is dedicated to events handling: you want to make this thread
sleep as long as no new event is received.
```
if (event = window.wait_event())
  # process event...
end
```

* *event* - Event to be returned

*Returns:* False if any error occurred

*See also:* `poll_event`
