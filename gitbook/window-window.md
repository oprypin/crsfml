# Opening and managing an SFML window

## Introduction

This tutorial only explains how to open and manage a window. Drawing stuff is beyond the scope of the sfml-window module: it is handled by the sfml-graphics module. However, the window management remains exactly the same so reading this tutorial is important in any case.

## Opening a window

Windows in CrSFML are defined by the [Window]({{book.api}}/Window.html) class. A window can be created and opened directly upon construction:

```ruby
require "crsfml"

window = SF::RenderWindow.new(SF.video_mode(800, 600), "My window")

...
```

The first argument, the *video mode*, defines the size of the window (the inner size, without the title bar and borders). Here, we create a window with a size of 800x600 pixels.
The [VideoMode]({{book.api}}/VideoMode.html) class has some interesting class methods to get the desktop resolution, or the list of valid video modes for fullscreen mode. Don't hesitate to have a look at its documentation.

The second argument is simply the title of the window.

This constructor accepts a third optional argument: a style, which allows you to choose which decorations and features you want. You can use any combination of the following styles:

<table>
    <tr>
        <td><code>SF::Style::None</code></td>
        <td>No decoration at all (useful for splash screens, for example); this style cannot be combined with others</td>
    </tr>
    <tr>
        <td><code>SF::Style::Titlebar</code></td>
        <td>The window has a titlebar</td>
    </tr>
    <tr>
        <td><code>SF::Style::Resize</code></td>
        <td>The window can be resized and has a maximize button</td>
    </tr>
    <tr>
        <td><code>SF::Style::Close</code></td>
        <td>The window has a close button</td>
    </tr>
    <tr>
        <td><code>SF::Style::Fullscreen</code></td>
        <td>The window is shown in fullscreen mode; this style cannot be combined with others, and requires a valid video mode</td>
    </tr>
    <tr>
        <td><code>SF::Style::Default</code></td>
        <td>The default style, which is a shortcut for <code>Titlebar | Resize | Close</code></td>
    </tr>
</table>

There's also a fourth optional argument, which defines OpenGL specific options which are explained in the [dedicated OpenGL tutorial](window-opengl.md "OpenGL tutorial").

## Bringing the window to life

If you try to execute the code above with nothing in place of the "...", you will hardly see anything. First, because the program ends immediately. Second, because there's no event handling -- so even if you added an endless loop to this code, you would see a dead window, unable to be resized or closed.

Let's add some code to make this program a bit more interesting:

```ruby
require "crsfml"

window = SF::RenderWindow.new(SF.video_mode(800, 600), "My window")

# run the program as long as the window is open
while window.open?
  # check all the window's events that were triggered since the last iteration of the loop
  while event = window.poll_event
    # "close requested" event: we close the window
    if event.type == SF::Event::Closed
      window.close
    end
  end
end
```

The above code will open a window, and terminate when the user closes it. Let's see how it works in detail.

First, we added a loop that ensures that the application will be refreshed/updated until the window is closed. Most (if not all) CrSFML programs will have this kind of loop, sometimes called the *main loop* or *game loop*.

Then, the first thing that we want to do inside our game loop is check for any events that occurred. Note that we use a `while` loop so that all pending events are processed in case there were several. The `poll_event` method returns true if an event was pending, or false if there was none.

Whenever we get an event, we must check its type (window closed? key pressed? mouse moved? joystick connected? ...), and react accordingly if we are interested in it. In this case, we only care about the `Event::Closed` event, which is triggered when the user wants to close the window. At this point, the window is still open and we have to close it explicitly with the `close` method. This enables you to do something before the window is closed, such as saving the current state of the application, or displaying a message.

A mistake that people often make is to forget the event loop, simply because they don't yet care about handling events (they use real-time inputs instead). Without an event loop, the window will become unresponsive. It is important to note that the event loop has two roles: in addition to providing events to the user, it gives the window a chance to process its internal events too, which is required so that it can react to move or resize user actions.

After the window has been closed, the main loop exits and the program terminates.

At this point, you probably noticed that we haven't talked about *drawing something* to the window yet. As stated in the introduction, this is not the job of the sfml-window module, and you'll have to jump to the sfml-graphics tutorials if you want to draw things such as sprites, text or shapes.

To draw stuff, you can also use OpenGL directly and totally ignore the sfml-graphics module. [Window]({{book.api}}/Window.html) internally creates an OpenGL context and is ready to accept your OpenGL calls. You can learn more about that in the [corresponding tutorial](window-opengl.md "OpenGL tutorial").

Don't expect to see anything interesting in this window: you may see a uniform color (black or white), or the last contents of the previous application that used OpenGL, or... something else.

## Playing with the window

Of course, CrSFML allows you to play with your windows a bit. Basic window operations such as changing the size, position, title or icon are supported, but unlike dedicated GUI libraries, SFML doesn't provide advanced features. SFML windows are only meant to provide an environment for OpenGL or SFML drawing.

```ruby
# change the position of the window (relatively to the desktop)
window.position = SF.vector2(10, 50)

# change the size of the window
window.size = SF.vector2(640, 480)

# change the title of the window
window.title = "SFML window"

# get the size of the window
size = window.size
width = size.x
height = size.y

...
```

You can refer to the API documentation for a complete list of [Window]({{book.api}}/Window.html)'s methods.

In case you really need advanced features for your window, you can create one (or even a full GUI) with another library, and embed SFML into it. To do so, you can use the other constructor of [Window]({{book.api}}/Window.html) which takes the OS-specific handle of an existing window. In this case, SFML will create a drawing context inside the given window and catch all its events without interfering with the parent window management.

```ruby
handle = ... # specific to what you're doing and the library you're using
SF::Window.from_handle(handle)
```

If you just want an additional, very specific feature, you can also do it the other way round: create an SFML window and get its OS-specific handle to implement things that SFML itself doesn't support.

```ruby
window = SF::RenderWindow.new(SF.video_mode(800, 600), "SFML window")
handle = window.system_handle

# you can now use the handle with OS specific functions
```

Integrating SFML with other libraries requires some work and won't be described here, but you can refer to the dedicated tutorials, examples or forum posts.

## Controlling the framerate

Sometimes, when your application runs fast, you may notice visual artifacts such as tearing. The reason is that your application's refresh rate is not synchronized with the vertical frequency of the monitor, and as a result, the bottom of the previous frame is mixed with the top of the next one.  
The solution to this problem is to activate *vertical synchronization*. It is automatically handled by the graphics card, and can easily be switched on and off with the `vertical_sync_enabled=` method:

```ruby
window.vertical_sync_enabled = true # call it once, after creating the window
```

After this call, your application will run at the same frequency as the monitor's refresh rate.

Sometimes `vertical_sync_enabled=` will have no effect: this is most likely because vertical synchronization is forced to "off" in your graphics driver's settings. It should be set to "controlled by application" instead.

In other situations, you may also want your application to run at a given framerate, instead of the monitor's frequency. This can be done by calling `framerate_limit=`:

```ruby
window.framerate_limit = 60 # call it once, after creating the window
```

Unlike `vertical_sync_enabled=`, this feature is implemented by SFML itself, using a combination of [Clock]({{book.api}}/Clock.html) and `SF.sleep`. An important consequence is that it is not 100% reliable, especially for high framerates: `SF.sleep`'s resolution depends on the underlying operating system and hardware, and can be as high as 10 or 15 milliseconds. Don't rely on this feature to implement precise timing.

Never use both `vertical_sync_enabled` and `framerate_limit` at the same time! They would badly mix and make things worse.

## Things to know about windows

Here is a brief list of what you can and cannot do with SFML windows.

### You can create multiple windows

SFML allows you to create multiple windows, and to handle them either all in the main thread, or each one in its own thread (but... see below). In this case, don't forget to have an event loop for each window.

### Multiple monitors are not correctly supported yet

SFML doesn't explicitly manage multiple monitors. As a consequence, you won't be able to choose which monitor a window appears on, and you won't be able to create more than one fullscreen window. This should be improved in a future version.

### Events must be polled in the window's thread

This is an important limitation of most operating systems: the event loop (more precisely, the `poll_event` or `wait_event` method) must be called in the same thread that created the window. This means that if you want to create a dedicated thread for event handling, you'll have to make sure that the window is created in this thread too. If you really want to split things between threads, it is more convenient to keep event handling in the main thread and move the rest (rendering, physics, logic, ...) to a separate thread instead. This configuration will also be compatible with the other limitation described below.

### On OS X, windows and events must be managed in the main thread

Yep, that's true. Mac OS X just won't agree if you try to create a window or handle events in a thread other than the main one.

### On Windows, a window which is bigger than the desktop will not behave correctly

For some reason, Windows doesn't like windows that are bigger than the desktop. This includes windows created with `VideoMode.get_desktop_mode`: with the window decorations (borders and titlebar) added, you end up with a window which is slightly bigger than the desktop.
