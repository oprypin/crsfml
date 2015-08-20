# Events explained

## Introduction

This tutorial is a detailed list of window events. It describes them, and shows how to (and how not to) use them. 

## The sf::Event type

Before dealing with events, it is important to understand what the [Event]({{book.api}}/Event.html) type is, and how to correctly use it. [Event]({{book.api}}/Event.html) is a *union*, which means that only one of its members is valid at a time (remember your C++ lesson: all the members of a union share the same memory space). The valid member is the one that matches the event type, for example `event.key` for a `KeyPressed` event. Trying to read any other member will result in an undefined behavior (most likely: random or invalid values). It it important to never try to use an event member that doesn't match its type. 

[Event]({{book.api}}/Event.html) instances are filled by the `pollEvent` (or `waitEvent`) function of the [Window]({{book.api}}/Window.html) class. Only these two functions can produce valid events, any attempt to use an [Event]({{book.api}}/Event.html) which was not returned by successful call to `pollEvent` (or `waitEvent`) will result in the same undefined behavior that was mentioned above. 

To be clear, here is what a typical event loop looks like: 

```
sf::Event event;

// while there are pending events...
while (window.pollEvent(event))
{
    // check the type of the event...
    switch (event.type)
    {
        // window closed
        case sf::Event::Closed:
            window.close();
            break;

        // key pressed
        case sf::Event::KeyPressed:
            ...
            break;

        // we don't process other types of events
        default:
            break;
    }
}
```

Read the above paragraph once again and make sure that you fully understand it, the [Event]({{book.api}}/Event.html) union is the cause of many problems for inexperienced programmers. 

Alright, now we can see what events SFML supports, what they mean and how to use them properly. 

## The Closed event

The `sf::Event::Closed` event is triggered when the user wants to close the window, through any of the possible methods the window manager provides ("close" button, keyboard shortcut, etc.). This event only represents a close request, the window is not yet closed when the event is received. 

Typical code will just call `window.close()` in reaction to this event, to actually close the window. However, you may also want to do something else first, like saving the current application state or asking the user what to do. If you don't do anything, the window remains open. 

There's no member associated with this event in the [Event]({{book.api}}/Event.html) union. 

```
if (event.type == sf::Event::Closed)
    window.close();
```

## The Resized event

The `sf::Event::Resized` event is triggered when the window is resized, either through user action or programmatically by calling `window.setSize`. 

You can use this event to adjust the rendering settings: the viewport if you use OpenGL directly, or the current view if you use sfml-graphics. 

The member associated with this event is `event.size`, it contains the new size of the window. 

```
if (event.type == sf::Event::Resized)
{
    std::cout << "new width: " << event.size.width << std::endl;
    std::cout << "new height: " << event.size.height << std::endl;
}
```

## The LostFocus and GainedFocus events

The `sf::Event::LostFocus` and `sf::Event::GainedFocus` events are triggered when the window loses/gains focus, which happens when the user switches the currently active window. When the window is out of focus, it doesn't receive keyboard events. 

This event can be used e.g. if you want to pause your game when the window is inactive. 

There's no member associated with these events in the [Event]({{book.api}}/Event.html) union. 

```
if (event.type == sf::Event::LostFocus)
    myGame.pause();

if (event.type == sf::Event::GainedFocus)
    myGame.resume();
```

## The TextEntered event

The `sf::Event::TextEntered` event is triggered when a character is typed. This must not be confused with the `KeyPressed` event: `TextEntered` interprets the user input and produces the appropriate printable character. For example, pressing '^' then 'e' on a French keyboard will produce two `KeyPressed` events, but a single `TextEntered` event containing the 'ê' character. It works with all the input methods provided by the operating system, even the most specific or complex ones. 

This event is typically used to catch user input in a text field. 

The member associated with this event is `event.text`, it contains the Unicode value of the entered character. You can either put it directly in a [String]({{book.api}}/String.html), or cast it to a `char` after making sure that it is in the ASCII range (0 - 127). 

```
if (event.type == sf::Event::TextEntered)
{
    if (event.text.unicode < 128)
        std::cout << "ASCII character typed: " << static_cast<char>(event.text.unicode) << std::endl;
}
```

Note that, since they are part of the Unicode standard, some non-printable characters such as *backspace* are generated by this event. In most cases you'll need to filter them out. 

Many programmers use the `KeyPressed` event to get user input, and start to implement crazy algorithms that try to interpret all the possible key combinations to produce correct characters. Don't do that! 

## The KeyPressed and KeyReleased events

The `sf::Event::KeyPressed` and `sf::Event::KeyReleased` events are triggered when a keyboard key is pressed/released. 

If a key is held, multiple `KeyPressed` events will be generated, at the default operating system delay (ie. the same delay that applies when you hold a letter in a text editor). To disable repeated `KeyPressed` events, you can call `window.setKeyRepeatEnabled(false)`. On the flip side, it is obvious that `KeyReleased` events can never be repeated. 

This event is the one to use if you want to trigger an action exactly once when a key is pressed or released, like making a character jump with space, or exiting something with escape. 

Sometimes, people try to react to `KeyPressed` events directly to implement smooth movement. Doing so will *not* produce the expected effect, because when you hold a key you only get a few events (remember, the repeat delay). To achieve smooth movement with events, you must use a boolean that you set on `KeyPressed` and clear on `KeyReleased`; you can then move (independently of events) as long as the boolean is set.  
The other (easier) solution to produce smooth movement is to use real-time keyboard input with [Keyboard]({{book.api}}/Keyboard.html) (see the [dedicated tutorial](./window-inputs.html "Real-time inputs tutorial")). 

The member associated with these events is `event.key`, it contains the code of the pressed/released key, as well as the current state of the modifier keys (alt, control, shift, system). 

```
if (event.type == sf::Event::KeyPressed)
{
    if (event.key.code == sf::Keyboard::Escape)
    {
        std::cout << "the escape key was pressed" << std::endl;
        std::cout << "control:" << event.key.control << std::endl;
        std::cout << "alt:" << event.key.alt << std::endl;
        std::cout << "shift:" << event.key.shift << std::endl;
        std::cout << "system:" << event.key.system << std::endl;
    }
}
```

Note that some keys have a special meaning for the operating system, and will lead to unexpected behavior. An example is the F10 key on Windows, which "steals" the focus, or the F12 key which starts the debugger when using Visual Studio. This will probably be solved in a future version of SFML. 

## The MouseWheelMoved event

The `sf::Event::MouseWheelMoved` event is **deprecated** since SFML 2.3, use the MouseWheelScrolled event instead. 

## The MouseWheelScrolled event

The `sf::Event::MouseWheelScrolled` event is triggered when a mouse wheel moves up or down, but also laterally if the mouse supports it. 

The member associated with this event is `event.mouseWheelScroll`, it contains the number of ticks the wheel has moved, what the orientation of the wheel is and the current position of the mouse cursor. 

```
if (event.type == sf::Event::MouseWheelScrolled)
{
    if (event.mouseWheelScroll.wheel == sf::Mouse::VerticalWheel)
        std::cout << "wheel type: vertical" << std::endl;
    else if (event.mouseWheelScroll.wheel == sf::Mouse::HorizontalWheel)
        std::cout << "wheel type: horizontal" << std::endl;
    else
        std::cout << "wheel type: unknown" << std::endl;
    std::cout << "wheel movement: " << event.mouseWheelScroll.delta << std::endl;
    std::cout << "mouse x: " << event.mouseWheelScroll.x << std::endl;
    std::cout << "mouse y: " << event.mouseWheelScroll.y << std::endl;
}
```

## The MouseButtonPressed and MouseButtonReleased events

The `sf::Event::MouseButtonPressed` and `sf::Event::MouseButtonReleased` events are triggered when a mouse button is pressed/released. 

SFML supports 5 mouse buttons: left, right, middle (wheel), extra #1 and extra #2 (side buttons). 

The member associated with these events is `event.mouseButton`, it contains the code of the pressed/released button, as well as the current position of the mouse cursor. 

```
if (event.type == sf::Event::MouseButtonPressed)
{
    if (event.mouseButton.button == sf::Mouse::Right)
    {
        std::cout << "the right button was pressed" << std::endl;
        std::cout << "mouse x: " << event.mouseButton.x << std::endl;
        std::cout << "mouse y: " << event.mouseButton.y << std::endl;
    }
}
```

## The MouseMoved event

The `sf::Event::MouseMoved` event is triggered when the mouse moves within the window. 

This event is triggered even if the window isn't focused. However, it is triggered only when the mouse moves within the inner area of the window, not when it moves over the title bar or borders. 

The member associated with this event is `event.mouseMove`, it contains the current position of the mouse cursor relative to the window. 

```
if (event.type == sf::Event::MouseMoved)
{
    std::cout << "new mouse x: " << event.mouseMove.x << std::endl;
    std::cout << "new mouse y: " << event.mouseMove.y << std::endl;
}
```

## The MouseEntered and MouseLeft event

The `sf::Event::MouseEntered` and `sf::Event::MouseLeft` events are triggered when the mouse cursor enters/leaves the window. 

There's no member associated with these events in the [Event]({{book.api}}/Event.html) union. 

```
if (event.type == sf::Event::MouseEntered)
    std::cout << "the mouse cursor has entered the window" << std::endl;

if (event.type == sf::Event::MouseLeft)
    std::cout << "the mouse cursor has left the window" << std::endl;
```

## The JoystickButtonPressed and JoystickButtonReleased events

The `sf::Event::JoystickButtonPressed` and `sf::Event::JoystickButtonReleased` events are triggered when a joystick button is pressed/released. 

SFML supports up to 8 joysticks and 32 buttons. 

The member associated with these events is `event.joystickButton`, it contains the identifier of the joystick and the index of the pressed/released button. 

```
if (event.type == sf::Event::JoystickButtonPressed)
{
    std::cout << "joystick button pressed!" << std::endl;
    std::cout << "joystick id: " << event.joystickButton.joystickId << std::endl;
    std::cout << "button: " << event.joystickButton.button << std::endl;
}
```

## The JoystickMoved event

The `sf::Event::JoystickMoved` event is triggered when a joystick axis moves. 

Joystick axes are typically very sensitive, that's why SFML uses a detection threshold to avoid spamming your event loop with tons of `JoystickMoved` events. This threshold can be changed with the `Window::setJoystickThreshold` function, in case you want to receive more or less joystick move events. 

SFML supports 8 joystick axes: X, Y, Z, R, U, V, POV X and POV Y. How they map to your joystick depends on its driver. 

The member associated with this event is `event.joystickMove`, it contains the identifier of the joystick, the name of the axis, and its current position (in the range [-100, 100]). 

```
if (event.type == sf::Event::JoystickMoved)
{
    if (event.joystickMove.axis == sf::Joystick::X)
    {
        std::cout << "X axis moved!" << std::endl;
        std::cout << "joystick id: " << event.joystickMove.joystickId << std::endl;
        std::cout << "new position: " << event.joystickMove.position << std::endl;
    }
}
```

## The JoystickConnected and JoystickDisconnected events

The `sf::Event::JoystickConnected` and `sf::Event::JoystickDisconnected` events are triggered when a joystick is connected/disconnected. 

The member associated with this event is `event.joystickConnect`, it contains the identifier of the connected/disconnected joystick. 

```
if (event.type == sf::Event::JoystickConnected)
    std::cout << "joystick connected: " << event.joystickConnect.joystickId << std::endl;

if (event.type == sf::Event::JoystickDisconnected)
    std::cout << "joystick disconnected: " << event.joystickConnect.joystickId << std::endl;
```

