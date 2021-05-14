# Keyboard, mouse and joystick

Relevant example: **[diagnostics](https://github.com/oprypin/crsfml/tree/master/examples/diagnostics.cr)**

## Introduction

This tutorial explains how to access global input devices: keyboard, mouse and joysticks. This must not be confused with events. Real-time input allows you to query the global state of keyboard, mouse and joysticks at any time ("*is this button currently pressed?*", "*where is the mouse currently?*") while events notify you when something happens ("*this button was pressed*", "*the mouse has moved*").

## Keyboard

The class that provides access to the keyboard state is [SF::Keyboard][]. It only contains one class method, `key_pressed?`, which checks the current state of a key (pressed or released). It is a class method, so you don't need to instantiate [SF::Keyboard][] to use it.

This class method directly reads the keyboard state, ignoring the focus state of your window. This means that `key_pressed?` may return true even if your window is inactive.

```crystal
if SF::Keyboard.key_pressed?(SF::Keyboard::Left)
  # left key is pressed: move our character
  character.move(1, 0)
end
```

Key codes are defined in the `SF::Keyboard::Key` enum.

Depending on your operating system and keyboard layout, some key codes might be missing or interpreted incorrectly. This is something that will be improved in a future version of SFML.

## Mouse

The class that provides access to the mouse state is [SF::Mouse][]. Like its friend [SF::Keyboard][], [SF::Mouse][] only contains class methods and is not meant to be instantiated (SFML only handles a single mouse for the time being).

You can check if buttons are pressed:

```crystal
if SF::Mouse.button_pressed?(SF::Mouse::Left)
  # left mouse button is pressed: shoot
  gun.fire
end
```

Mouse button codes are defined in the `SF::Mouse::Button` enum. SFML supports up to 5 buttons: left, right, middle (wheel), and two additional buttons whatever they may be.

You can also get and set the current position of the mouse, either relative to the desktop or to a window:

```crystal
# get the global mouse position (relative to the desktop)
global_position = SF::Mouse.position

# get the local mouse position (relative to a window)
local_position = SF::Mouse.get_position(window) # window is a SF::Window
```



```crystal
# set the mouse position globally (relative to the desktop)
SF::Mouse.position = SF.vector2(10, 50)

# set the mouse position locally (relative to a window)
SF::Mouse.set_position(SF.vector2(10, 50), window) # window is a SF::Window
```

There is no function for reading the current state of the mouse wheel. Since the wheel can only be moved relatively, it has no absolute state that can be queried. By looking at a key you can tell whether it's pressed or released. By looking at the mouse cursor you can tell where it is located on the screen. However, looking at the mouse wheel doesn't tell you which "tick" it is on. You can only be notified when it moves (`MouseWheelMoved` event).

## Joystick

The class that provides access to the joysticks' states is [SF::Joystick][]. Like the other classes in this tutorial, it only contains class methods.

Joysticks are identified by their index (0 to 7, since SFML supports up to 8 joysticks). Therefore, the first argument of every class method of [SF::Joystick][] is the index of the joystick that you want to query.

You can check whether a joystick is connected or not:

```crystal
if SF::Joystick.connected?(0)
  # joystick number 0 is connected
  # [...]
end
```

You can also get the capabilities of a connected joystick:

```crystal
# check how many buttons joystick number 0 has
button_count = SF::Joystick.get_button_count(0)

# check if joystick number 0 has a Z axis
has_z = SF::Joystick.axis?(0, SF::Joystick::Z)
```

Joystick axes are defined in the `SF::Joystick::Axis` enum. Since buttons have no special meaning, they are simply numbered from 0 to 31.

Finally, you can query the state of a joystick's axes and buttons as well:

```crystal
# is button 1 of joystick number 0 pressed?
if SF::Joystick.button_pressed?(0, 1)
  # yes: shoot!
  gun.fire
end

# what's the current position of the X and Y axes of joystick number 0?
x = SF::Joystick.get_axis_position(0, SF::Joystick::X)
y = SF::Joystick.get_axis_position(0, SF::Joystick::Y)
character.move(x, y)
```

Joystick states are automatically updated when you check for events. If you don't check for events, or need to query a joystick state (for example, checking which joysticks are connected) before starting your game loop, you'll have to manually call the `SF::Joystick.update` class method yourself to make sure that the joystick states are up to date.
