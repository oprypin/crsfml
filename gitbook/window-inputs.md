# Keyboard, mouse and joystick

## Introduction

This tutorial explains how to access global input devices: keyboard, mouse and joysticks. This must not be confused with events. Real-time input allows you to query the global state of keyboard, mouse and joysticks at any time ("*is this button currently pressed?*", "*where is the mouse currently?*") while events notify you when something happens ("*this button was pressed*", "*the mouse has moved*"). 

## Keyboard

The class that provides access to the keyboard state is [Keyboard]({{book.api}}/Keyboard.html). It only contains one function, `isKeyPressed`, which checks the current state of a key (pressed or released). It is a static function, so you don't need to instantiate [Keyboard]({{book.api}}/Keyboard.html) to use it. 

This function directly reads the keyboard state, ignoring the focus state of your window. This means that `isKeyPressed` may return true even if your window is inactive. 

```
if (sf::Keyboard::isKeyPressed(sf::Keyboard::Left))
{
    // left key is pressed: move our character
    character.move(1, 0);
}
```

Key codes are defined in the `sf::Keyboard::Key` enum. 

Depending on your operating system and keyboard layout, some key codes might be missing or interpreted incorrectly. This is something that will be improved in a future version of SFML. 

## Mouse

The class that provides access to the mouse state is [Mouse]({{book.api}}/Mouse.html). Like its friend [Keyboard]({{book.api}}/Keyboard.html), [Mouse]({{book.api}}/Mouse.html) only contains static functions and is not meant to be instantiated (SFML only handles a single mouse for the time being). 

You can check if buttons are pressed: 

```
if (sf::Mouse::isButtonPressed(sf::Mouse::Left))
{
    // left mouse button is pressed: shoot
    gun.fire();
}
```

Mouse button codes are defined in the `sf::Mouse::Button` enum. SFML supports up to 5 buttons: left, right, middle (wheel), and two additional buttons whatever they may be. 

You can also get and set the current position of the mouse, either relative to the desktop or to a window: 

```
// get the global mouse position (relative to the desktop)
sf::Vector2i globalPosition = sf::Mouse::getPosition();

// get the local mouse position (relative to a window)
sf::Vector2i localPosition = sf::Mouse::getPosition(window); // window is a sf::Window
```



```
// set the mouse position globally (relative to the desktop)
sf::Mouse::setPosition(sf::Vector2i(10, 50));

// set the mouse position locally (relative to a window)
sf::Mouse::setPosition(sf::Vector2i(10, 50), window); // window is a sf::Window
```

There is no function for reading the current state of the mouse wheel. Since the wheel can only be moved relatively, it has no absolute state that can be queried. By looking at a key you can tell whether it's pressed or released. By looking at the mouse cursor you can tell where it is located on the screen. However, looking at the mouse wheel doesn't tell you which "tick" it is on. You can only be notified when it moves (`MouseWheelMoved` event). 

## Joystick

The class that provides access to the joysticks' states is [Joystick]({{book.api}}/Joystick.html). Like the other classes in this tutorial, it only contains static functions. 

Joysticks are identified by their index (0 to 7, since SFML supports up to 8 joysticks). Therefore, the first argument of every function of [Joystick]({{book.api}}/Joystick.html) is the index of the joystick that you want to query. 

You can check whether a joystick is connected or not: 

```
if (sf::Joystick::isConnected(0))
{
    // joystick number 0 is connected
    ...
}
```

You can also get the capabilities of a connected joystick: 

```
// check how many buttons joystick number 0 has
unsigned int buttonCount = sf::Joystick::getButtonCount(0);

// check if joystick number 0 has a Z axis
bool hasZ = sf::Joystick::hasAxis(0, sf::Joystick::Z);
```

Joystick axes are defined in the `sf::Joystick::Axis` enum. Since buttons have no special meaning, they are simply numbered from 0 to 31. 

Finally, you can query the state of a joystick's axes and buttons as well: 

```
// is button 1 of joystick number 0 pressed?
if (sf::Joystick::isButtonPressed(0, 1))
{
    // yes: shoot!
    gun.fire();
}

// what's the current position of the X and Y axes of joystick number 0?
float x = sf::Joystick::getAxisPosition(0, sf::Joystick::X);
float y = sf::Joystick::getAxisPosition(0, sf::Joystick::Y);
character.move(x, y);
```

Joystick states are automatically updated when you check for events. If you don't check for events, or need to query a joystick state (for example, checking which joysticks are connected) before starting your game loop, you'll have to manually call the `sf::Joystick::update()` function yourself to make sure that the joystick states are up to date. 
