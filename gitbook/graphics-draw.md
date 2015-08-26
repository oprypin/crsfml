# Drawing 2D stuff

## Introduction

As you learnt in the previous tutorials, CrSFML's window module provides an easy way to open an OpenGL window and handle its events, but it doesn't help when it comes to drawing something. The only option which is left to you is to use the powerful, yet complex and low level OpenGL API.

Fortunately, CrSFML provides a graphics module which will help you draw 2D entities in a much simpler way than with OpenGL.

## The drawing window

To draw the entities provided by the graphics module, you must use a specialized window class: [RenderWindow]({{book.api}}/RenderWindow.html). This class is derived from [Window]({{book.api}}/Window.html), and inherits all its methods. Everything that you've learnt about [Window]({{book.api}}/Window.html) (creation, event handling, controlling the framerate, mixing with OpenGL, etc.) is applicable to [RenderWindow]({{book.api}}/RenderWindow.html) as well.

On top of that, [RenderWindow]({{book.api}}/RenderWindow.html) adds high-level methods to help you draw things easily. In this tutorial we'll focus on two of these methods: `clear` and `draw`. They are as simple as their name implies: `clear` clears the whole window with the chosen color, and `draw` draws whatever object you pass to it.

Here is what a typical main loop looks like with a render window:

```ruby
require "crsfml"

# create the window
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

    # clear the window with black color
    window.clear(SF::Color::Black)

    # draw everything here...
    window.draw(...)

    # end the current frame
    window.display
end
```

Calling `clear` before drawing anything is mandatory, otherwise the contents from previous frames will be present behind anything you draw. The only exception is when you cover the entire window with what you draw, so that no pixel is not drawn to. In this case you can avoid calling `clear` (although it won't have a noticeable impact on performance).

Calling `display` is also mandatory, it takes what was drawn since the last call to `display` and displays it on the window. Indeed, things are not drawn directly to the window, but to a hidden buffer. This buffer is then copied to the window when you call `display` – this is called *double-buffering*.

This clear/draw/display cycle is the only good way to draw things. Don't try other strategies, such as keeping pixels from the previous frame, "erasing" pixels, or drawing once and calling display multiple times. You'll get strange results due to double-buffering.
Modern graphics hardware and APIs are *really* made for repeated clear/draw/display cycles where everything is completely refreshed at each iteration of the main loop. Don't be scared to draw 1000 sprites 60 times per second, you're far below the millions of triangles that your computer can handle.

## What can I draw now?

Now that you have a main loop which is ready to draw, let's see what, and how, you can actually draw there.

SFML provides four kinds of drawable entities: three of them are ready to be used (*sprites*, *text* and *shapes*), the last one is the building block that will help you create your own drawable entities (*vertex arrays*).

Although they share some common properties, each of these entities come with their own nuances and are therefore explained in dedicated tutorials:

  * [Sprite tutorial](graphics-sprite.md "Learn how to create and draw sprites")
  * [Text tutorial](graphics-text.md "Learn how to create and draw text")
  * [Shape tutorial](graphics-shape.md "Learn how to create and draw shapes")
  * [Vertex array tutorial](graphics-vertex-array.md "Learn how to create and draw vertex arrays")

## Off-screen drawing

SFML also provides a way to draw to a texture instead of directly to a window. To do so, use a [RenderTexture]({{book.api}}/RenderTexture.html) instead of a [RenderWindow]({{book.api}}/RenderWindow.html). It has the same methods for drawing, inherited from their common base: [RenderTarget]({{book.api}}/RenderTarget.html).

```ruby
# create a 500x500 render-texture
render_texture = SF::RenderTexture.new(500, 500)

# drawing uses the same methods
render_texture.clear(SF::Color::Blue)
render_texture.draw(sprite) # or any other drawable
render_texture.display

# get the target texture (where the stuff has been drawn)
texture = render_texture.texture

# draw it to the window
sprite = SF::Sprite.new(texture)
window.draw(sprite)
```

The `texture` method returns a read-only texture, which means that you can only use it, not modify it. If you need to modify it before using it, you can copy it to your own [Texture]({{book.api}}/Texture.html) instance and modify that instead.

[RenderTexture]({{book.api}}/RenderTexture.html) also has the same methods as [RenderWindow]({{book.api}}/RenderWindow.html) for handling views and OpenGL (see the corresponding tutorials for more details). If you use OpenGL to draw to the render-texture, you can request creation of a depth buffer by using the third optional argument of the constructor.

```ruby
SF::RenderTexture.new(500, 500, true) # enable depth buffer
```

## Drawing from threads

CrSFML supports multi-threaded drawing, and you don't even have to do anything to make it work. The only thing to remember is to deactivate a window before using it in another thread. That's because a window (more precisely its OpenGL context) cannot be active in more than one thread at the same time.

```ruby
def render_thread(window)
    # the rendering loop
    while window.open?
        # draw...

        # end the current frame
        window.display
    end
end

# create the window (remember: it's safer to create it in the main thread due to OS limitations)
window = SF::RenderWindow.new(SF.video_mode(800, 600), "OpenGL")

# deactivate its OpenGL context
window.active = false

# launch the rendering thread
thread = SF::Thread.new(->{ render_thread(window) })
thread.launch

# the event/logic/whatever loop
while window.open?
    ...
end
```

As you can see, you don't even need to bother with the activation of the window in the rendering thread, CrSFML does it automatically for you whenever it needs to be done.

Remember to always create the window and handle its events in the main thread for maximum portability. This is explained in the [window tutorial](window-window.md "Window tutorial").
