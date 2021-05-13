# Events explained

## Introduction

This tutorial is a detailed list of window events. It describes them, and shows how to (and how not to) use them.

## The SF::Event type

Before dealing with events, it is important to understand what the [SF::Event][] type is, and how to correctly use it. [SF::Event][] (unlike in SFML, where it is a *union*) is just an abstract struct, and all the events are its subclasses. Many events have some data associated with them, so it is important to let the compiler know which exactly type of event is being inspected (using `is_a?`, `as`, `case`/`when`), otherwise none of the members will be accessible.

Here is the hierarchy: level 1 is the `Event` abstract struct itself, level 2 are abstract structs that add some members, and level 3 are concrete event types. The point of this is that that some events, while different (level 3), have exactly the same kind of information associated with them (level 2).

```
Event
├────╴Closed
├─╴SizeEvent: height, width
│  └─╴Resized
├────╴LostFocus
├────╴GainedFocus
├─╴TextEvent: unicode
│  └─╴TextEntered
├─╴KeyEvent: code, alt, control, shift, system
│  ├─╴KeyPressed
│  └─╴KeyReleased
├─╴MouseWheelEvent: delta, x, y
│  └─╴MouseWheelMoved
├─╴MouseWheelScrollEvent: wheel, delta, x, y
│  └─╴MouseWheelScrolled
├─╴MouseButtonEvent: button, x, y
│  ├─╴MouseButtonPressed
│  └─╴MouseButtonReleased
├─╴MouseMoveEvent: x, y
│  └─╴MouseMoved
├────╴MouseEntered
├────╴MouseLeft
├─╴JoystickButtonEvent: joystick_id, button
│  ├─╴JoystickButtonPressed
│  └─╴JoystickButtonReleased
├─╴JoystickMoveEvent: joystick_id, axis, position
│  └─╴JoystickMoved
├─╴JoystickConnectEvent: joystick_id
│  ├─╴JoystickConnected
│  └─╴JoystickDisconnected
├─╴TouchEvent: finger, x, y
│  ├─╴TouchBegan
│  ├─╴TouchMoved
│  └─╴TouchEnded
└─╴SensorEvent: type, x, y, z
   └─╴SensorChanged
```

[SF::Event][] instances are filled by the `poll_event` (or `wait_event`) method of the [SF::Window][] class. Only these two methods can produce valid events.

To be clear, here is what a typical event loop looks like:

```crystal
# while there are pending events...
while event = window.poll_event
  # check the type of the event...
  case event
  when SF::Event::Closed # window closed
    window.close
  when SF::Event::KeyPressed # key pressed
    [...]
  end # we don't process other types of events
end
```

Alright, now we can see what events SFML supports, what they mean and how to use them properly.

## The Closed event

Relevant example: **[simple](https://github.com/oprypin/crsfml/tree/master/examples/simple.cr)**

The `SF::Event::Closed` event is triggered when the user wants to close the window, through any of the possible methods the window manager provides ("close" button, keyboard shortcut, etc.). This event only represents a close request, the window is not yet closed when the event is received.

Typical code will just call `window.close` in reaction to this event, to actually close the window. However, you may also want to do something else first, like saving the current application state or asking the user what to do. If you don't do anything, the window remains open.

There's no member associated with this event in the [SF::Event][] union.

```crystal
if event.is_a? SF::Event::Closed
  window.close
end
```

## The Resized event

Relevant example: **[gl](https://github.com/oprypin/crsfml/tree/master/examples/gl.cr)**

The `SF::Event::Resized` event is triggered when the window is resized, either through user action or programmatically by calling `window.size=`.

You can use this event to adjust the rendering settings: the viewport if you use OpenGL directly, or the current view if you use sfml-graphics.

The data associated with this event is the new size of the window.

```crystal
if event.is_a? SF::Event::Resized
  puts "new width: #{event.width}"
  puts "new height: #{event.height}"
end
```

## The LostFocus and GainedFocus events

The `SF::Event::LostFocus` and `SF::Event::GainedFocus` events are triggered when the window loses/gains focus, which happens when the user switches the currently active window. When the window is out of focus, it doesn't receive keyboard events.

This event can be used e.g. if you want to pause your game when the window is inactive.

There's no member associated with these events in the [SF::Event][] union.

```crystal
if event.is_a? SF::Event::LostFocus
  my_game.pause
end

if event.is_a? SF::Event::GainedFocus
  my_game.resume
end
```

## The TextEntered event

Relevant example: **[typing](https://github.com/oprypin/crsfml/tree/master/examples/typing.cr)**

The `SF::Event::TextEntered` event is triggered when a character is typed. This must not be confused with the `KeyPressed` event: `TextEntered` interprets the user input and produces the appropriate printable character. For example, pressing '^' then 'e' on a French keyboard will produce two `KeyPressed` events, but a single `TextEntered` event containing the 'ê' character. It works with all the input methods provided by the operating system, even the most specific or complex ones.

This event is typically used to catch user input in a text field.

The data associated with this event is the Unicode codepoint of the entered character (use `.chr` to convert it to a `Char`).

```crystal
if event.is_a? SF::Event::TextEntered
  if event.unicode < 128
    puts "ASCII character typed: #{event.unicode.chr}"
  end
end
```

Note that, since they are part of the Unicode standard, some non-printable characters such as *backspace* are generated by this event. In most cases you'll need to filter them out.

Many programmers use the `KeyPressed` event to get user input, and start to implement crazy algorithms that try to interpret all the possible key combinations to produce correct characters. Don't do that!

## The KeyPressed and KeyReleased events

Relevant example: **[snakes](https://github.com/oprypin/crsfml/tree/master/examples/snakes.cr)**

The `SF::Event::KeyPressed` and `SF::Event::KeyReleased` events are triggered when a keyboard key is pressed/released.

If a key is held, multiple `KeyPressed` events will be generated, at the default operating system delay (i. e. the same delay that applies when you hold a letter in a text editor). To disable repeated `KeyPressed` events, you can set `window.key_repeat_enabled = false`. On the flip side, it is obvious that `KeyReleased` events can never be repeated.

This event is the one to use if you want to trigger an action exactly once when a key is pressed or released, like making a character jump with space, or exiting something with escape.

Sometimes, people try to react to `KeyPressed` events directly to implement smooth movement. Doing so will *not* produce the expected effect, because when you hold a key you only get a few events (remember, the repeat delay). To achieve smooth movement with events, you must use a boolean that you set on `KeyPressed` and clear on `KeyReleased`; you can then move (independently of events) as long as the boolean is set.  
The other (easier) solution to produce smooth movement is to use real-time keyboard input with [SF::Keyboard][] (see the [dedicated tutorial](inputs.md "Real-time inputs tutorial")).

The data associated with these events is the code of the pressed/released key, as well as the current state of the modifier keys (alt, control, shift, system).

```crystal
if event.is_a? SF::Event::KeyPressed
  if event.code == SF::Keyboard::Escape
    puts "the escape key was pressed"
    puts "control: #{event.control}"
    puts "alt: #{event.alt}"
    puts "shift: #{event.shift}"
    puts "system: #{event.system}"
  end
end
```

Note that some keys have a special meaning for the operating system, and will lead to unexpected behavior. An example is the F10 key on Windows, which "steals" the focus, or the F12 key which starts the debugger when using Visual Studio. This will probably be solved in a future version of SFML.

## The MouseWheelMoved event

The `SF::Event::MouseWheelMoved` event is **deprecated** since SFML 2.3, use the MouseWheelScrolled event instead.

## The MouseWheelScrolled event

Relevant example: **[diagnostics](https://github.com/oprypin/crsfml/tree/master/examples/diagnostics.cr)**

The `SF::Event::MouseWheelScrolled` event is triggered when a mouse wheel moves up or down, but also laterally if the mouse supports it.

The data associated with this event contains the number of ticks the wheel has moved, what the orientation of the wheel is and the current position of the mouse cursor.

```crystal
if event.is_a? SF::Event::MouseWheelScrolled
  if event.wheel == SF::Mouse::VerticalWheel
    puts "wheel type: vertical"
  elsif event.wheel == SF::Mouse::HorizontalWheel
    puts "wheel type: horizontal"
  else
    puts "wheel type: unknown"
  end

  puts "wheel movement: #{event.delta}"
  puts "mouse x: #{event.x}"
  puts "mouse y: #{event.y}"
end
```

## The MouseButtonPressed and MouseButtonReleased events

Relevant example: **[diagnostics](https://github.com/oprypin/crsfml/tree/master/examples/diagnostics.cr)**

The `SF::Event::MouseButtonPressed` and `SF::Event::MouseButtonReleased` events are triggered when a mouse button is pressed/released.

SFML supports 5 mouse buttons: left, right, middle (wheel), extra #1 and extra #2 (side buttons).

The data associated with these events contains the code of the pressed/released button, as well as the current position of the mouse cursor.

```crystal
if event.is_a? SF::Event::MouseButtonPressed
  if event.button.right?
    puts "the right button was pressed"
    puts "mouse x: #{event.x}"
    puts "mouse y: #{event.y}"
  end
end
```

## The MouseMoved event

The `SF::Event::MouseMoved` event is triggered when the mouse moves within the window.

This event is triggered even if the window isn't focused. However, it is triggered only when the mouse moves within the inner area of the window, not when it moves over the title bar or borders.

The data associated with this event contains the current position of the mouse cursor relative to the window.

```crystal
if event.is_a? SF::Event::MouseMoved
  puts "new mouse x: #{event.x}"
  puts "new mouse y: #{event.y}"
end
```

## The MouseEntered and MouseLeft event

The `SF::Event::MouseEntered` and `SF::Event::MouseLeft` events are triggered when the mouse cursor enters/leaves the window.

There is no data associated with these events.

```crystal
case event
when SF::Event::MouseEntered
  puts "the mouse cursor has entered the window"
when SF::Event::MouseLeft
  puts "the mouse cursor has left the window"
end
```

## The JoystickButtonPressed and JoystickButtonReleased events

The `SF::Event::JoystickButtonPressed` and `SF::Event::JoystickButtonReleased` events are triggered when a joystick button is pressed/released.

SFML supports up to 8 joysticks and 32 buttons.

The data associated with these events contains the identifier of the joystick and the index of the pressed/released button.

```crystal
if event.is_a? SF::Event::JoystickButtonPressed
  puts "joystick button pressed!"
  puts "joystick id: #{event.joystick_id}"
  puts "button: #{event.button}"
end
```

## The JoystickMoved event

The `SF::Event::JoystickMoved` event is triggered when a joystick axis moves.

Joystick axes are typically very sensitive, that's why SFML uses a detection threshold to avoid spamming your event loop with tons of `JoystickMoved` events. This threshold can be changed with the `Window#joystick_threshold=` method, in case you want to receive more or less joystick move events.

SFML supports 8 joystick axes: X, Y, Z, R, U, V, POV X and POV Y. How they map to your joystick depends on its driver.

The member associated with this event contains the identifier of the joystick, the name of the axis, and its current position (in the range [-100, 100]).

```crystal
if event.is_a? SF::Event::JoystickMoved
  if event.axis == SF::Joystick::X
    puts "X axis moved!"
    puts "joystick id: #{event.joystick_id}"
    puts "new position: #{event.position}"
  end
end
```

## The JoystickConnected and JoystickDisconnected events

The `SF::Event::JoystickConnected` and `SF::Event::JoystickDisconnected` events are triggered when a joystick is connected/disconnected.

The data associated with this event is the identifier of the connected/disconnected joystick.

```crystal
case event
when SF::Event::JoystickConnected
  puts "joystick connected: #{event.joystick_id}"
when SF::Event::JoystickDisconnected
  puts "joystick disconnected: #{event.joystick_id}"
end
```
