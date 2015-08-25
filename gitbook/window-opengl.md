# Using OpenGL in a CrSFML window

## Introduction

This tutorial is not about OpenGL itself, but rather how to use CrSFML as an environment for OpenGL, and how to mix them together.

As you know, one of the most important features of OpenGL is portability. But OpenGL alone won't be enough to create complete programs: you need a window, a rendering context, user input, etc. You would have no choice but to write OS-specific code to handle this stuff on your own. That's where the sfml-window module comes into play. Let's see how it allows you to play with OpenGL.

## Including and linking OpenGL to your application

OpenGL headers are not the same on every OS. Therefore, CrSFML provides an "abstract" header that takes care of including the right file for you.

```
#include <CrSFML/OpenGL.hpp>
```

This header includes OpenGL functions, and nothing else. People sometimes think that CrSFML automatically includes OpenGL extension headers because CrSFML loads extensions itself, but it's an implementation detail. From the user's point of view, OpenGL extension loading must be handled like any other external library.

You will then need to link your program to the OpenGL library. Unlike what it does with the headers, CrSFML can't provide a unified way of linking OpenGL. Therefore, you need to know which library to link to according to what operating system you're using ("opengl32" on Windows, "GL" on Linux, etc.).

OpenGL functions start with the "gl" prefix. Remember this when you get linker errors, it will help you find which library you forgot to link.

## Creating an OpenGL window

Since CrSFML is based on OpenGL, its windows are ready for OpenGL calls without any extra effort.

```ruby
@[Link("GL")] # Use @[Link(framework: "OpenGL")] on Mac OSX
lib GL
  fun enable = glEnable(cap: Int32)
  TEXTURE_2D = 3553
end

window = SF::RenderWindow.new(SF.video_mode(800, 600), "OpenGL")

# it works out of the box
GL.enable(GL::TEXTURE_2D)
...
```

In case you think it is *too* automatic, [Window]({{book.api}}/Window.html)'s constructor has an extra argument that allows you to change the settings of the underlying OpenGL context. This argument is an instance of the structure, it provides access to the following settings:

  * `depthBits` is the number of bits per pixel to use for the depth buffer (0 to disable it)
  * `stencilBits` is the number of bits per pixel to use for the stencil buffer (0 to disable it)
  * `antialiasingLevel` is the multisampling level
  * `majorVersion` and `minorVersion` comprise the requested version of OpenGL

```ruby
settings = SF.context_settings(
    depth_bits = 24,
    stencil_bits = 8,
    antialiasing_level = 4,
    major_version = 3,
    minor_version = 0
)

window = SF::RenderWindow.new(SF.video_mode(800, 600), "OpenGL", settings: settings)
```

If any of these settings is not supported by the graphics card, CrSFML tries to find the closest valid match. For example, if 4x anti-aliasing is too high, it tries 2x and then falls back to 0.
In any case, you can check what settings CrSFML actually used with the `settings` function:

```ruby
settings = window.settings

puts "depth bits:" + settings.depth_bits.to_s
puts "stencil bits:" + settings.stencil_bits.to_s
puts "antialiasing level:" + settings.antialiasing_level.to_s
puts "version:" + settings.major_version.to_s + "." + settings.minor_version.to_s
```

OpenGL versions above 3.0 are supported by CrSFML (as long as your graphics driver can handle them). Support for selecting the profile of 3.2+ contexts and whether the context debug flag is set was added in CrSFML 2.3. The forward compatibility flag is not supported. By default, CrSFML creates 3.2+ contexts using the compatibility profile because the graphics module makes use of legacy OpenGL functionality. If you intend on using the graphics module, make sure to create your context without the core profile setting or the graphics module will not function correctly. On OS X, CrSFML supports creating OpenGL 3.2+ contexts using the core profile only. If you want to use the graphics module on OS X, you are limited to using a legacy context which implies OpenGL version 2.1.

## A typical OpenGL-with-CrSFML program

Here is what a complete OpenGL program would look like with CrSFML:

```ruby
# create bindings
@[Link("GL")]
lib GL
  fun enable = glEnable(cap: Int32)
  fun viewport = glViewport(x: Int32, y: Int32, width: Int32, height: Int32)
  fun clear = glClear(mask: Int32)
  TEXTURE_2D = 3553
  COLOR_BUFFER_BIT = 16384
  DEPTH_BUFFER_BIT = 256
end

GL.enable(GL::TEXTURE_2D)

# create the window
settings = SF.context_settings(32)
window = SF::RenderWindow.new(SF.video_mode(800, 600), "OpenGL", settings: settings)
window.vertical_sync_enabled = true

# load resources, initialize the OpenGL states, ...

# run the main loop
running = true
while running
    # handle events
    while event = window.poll_event
        if event.type == SF::Event::Closed
            # end the program
            running = false
        elsif event.type == SF::Event::Resized
            # adjust the viewport when the window is resized
            GL.viewport(0, 0, event.size.width, event.size.height)
        end
    end

    # clear the buffers
    GL.clear(GL::COLOR_BUFFER_BIT | GL::DEPTH_BUFFER_BIT)

    # draw...

    # end the current frame (internally swaps the front and back buffers)
    window.display
end

# release resources...
```

Here we don't use `window.open?` as the condition of the main loop, because we need the window to remain open until the program ends, so that we still have a valid OpenGL context for the last iteration of the loop and the cleanup code.

Don't hesitate to have a look at the "OpenGL" and "Window" examples in the CrSFML SDK if you have further problems, they are more complete and most likely contain solutions to your problems.

## Managing multiple OpenGL windows

Managing multiple OpenGL windows is not more complicated than managing one, there are just a few things to keep in mind.

OpenGL calls are made on the active context (thus the active window). Therefore if you want to draw to two different windows within the same program, you have to select which window is active before drawing something. This can be done with the `active=` function:

```ruby
# activate the first window
window1.active = true

# draw to the first window...

# activate the second window
window2.active = true

# draw to the second window...
```

Only one context (window) can be active in a thread, so you don't need to deactivate a window before activating another one, it is deactivated automatically. This is how OpenGL works.

Another thing to know is that all the OpenGL contexts created by CrSFML share their resources. This means that you can create a texture or vertex buffer with any context active, and use it with any other. This also means that you don't have to reload all your OpenGL resources when you recreate your window. Only shareable OpenGL resources can be shared among contexts. An example of an unshareable resource is a vertex array object.

## Using OpenGL together with the graphics module

This tutorial was about mixing OpenGL with sfml-window, which is fairly easy since it's the only purpose of this module. Mixing with the graphics module is a little more complicated: sfml-graphics uses OpenGL too, so extra care must be taken so that CrSFML and user states don't conflict with each other.

If you don't know the graphics module yet, all you have to know is that the [Window]({{book.api}}/Window.html) class is replaced with [RenderWindow]({{book.api}}/RenderWindow.html), which inherits all its functions and adds features to draw CrSFML specific entities.

The only way to avoid conflicts between CrSFML and your own OpenGL states, is to save/restore them every time you switch from OpenGL to CrSFML.

```
- draw with OpenGL

- save OpenGL states

- draw with CrSFML

- restore OpenGL states

- draw with OpenGL

...
```

The easiest solution is to let CrSFML do it for you, with the `push_gl_states`/`pop_gl_states` functions :

```ruby
glDraw...

window.push_gl_states

window.draw(...)

window.pop_gl_states

glDraw...
```

Since it has no knowledge about your OpenGL code, CrSFML can't optimize these steps and as a result it saves/restores all available OpenGL states and matrices. This may be acceptable for small projects, but it might also be too slow for bigger programs that require maximum performance. In this case, you can handle saving and restoring the OpenGL states yourself, with `glPushAttrib`/`glPopAttrib`, `glPushMatrix`/`glPopMatrix`, etc.
If you do this, you'll still need to restore CrSFML's own states before drawing. This is done with the `reset_gl_states` function.

```ruby
glDraw...

glPush...
window.reset_gl_states

window.draw(...)

glPop...

glDraw...
```

By saving and restoring OpenGL states yourself, you can manage only the ones that you really need which leads to reducing the number of unnecessary driver calls.
