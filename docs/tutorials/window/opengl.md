# Using OpenGL in an SFML window

Relevant examples: **[gl](https://github.com/oprypin/crsfml/tree/master/examples/gl.cr)**, **[cube](https://github.com/oprypin/crsfml-examples/tree/master/cube)**

## Introduction

This tutorial is not about OpenGL itself, but rather how to use CrSFML as an environment for OpenGL, and how to mix them together.

As you know, one of the most important features of OpenGL is portability. But OpenGL alone won't be enough to create complete programs: you need a window, a rendering context, user input, etc. You would have no choice but to write OS-specific code to handle this stuff on your own. That's where the sfml-window module comes into play. Let's see how it allows you to play with OpenGL.

## OpenGL?

To use OpenGL, you'll need to find a library that implements Crystal bindings to it. This tutorial also contains small bits of OpenGL bindings.

## Creating an OpenGL window

Since SFML is based on OpenGL, its windows are ready for OpenGL calls without any extra effort.

```crystal
@[Link("GL")] # Use @[Link(framework: "OpenGL")] on Mac OSX
lib GL
  fun enable = glEnable(cap : Int32)
  TEXTURE_2D = 3553
end

window = SF::RenderWindow.new(SF::VideoMode.new(800, 600), "OpenGL")

# it works out of the box
GL.enable(GL::TEXTURE_2D)
[...]
```

In case you think it is *too* automatic, [SF::Window][]'s constructor has an extra argument that allows you to change the settings of the underlying OpenGL context. This argument is an instance of the structure, it provides access to the following settings:

* `depth_bits` is the number of bits per pixel to use for the depth buffer (0 to disable it)
* `stencil_bits` is the number of bits per pixel to use for the stencil buffer (0 to disable it)
* `antialiasing_level` is the multisampling level
* `major_version` and `minor_version` comprise the requested version of OpenGL

```crystal
settings = SF::ContextSettings.new(
  depth: 24, stencil: 8, antialiasing: 4,
  major: 3, minor: 0
)

window = SF::RenderWindow.new(
  SF::VideoMode.new(800, 600),
  "OpenGL", settings: settings
)
```

If any of these settings is not supported by the graphics card, SFML tries to find the closest valid match. For example, if 4x anti-aliasing is too high, it tries 2x and then falls back to 0.  
In any case, you can check what settings SFML actually used with the `settings` method:

```crystal
settings = window.settings

puts "depth bits: #{settings.depth_bits}"
puts "stencil bits: #{settings.stencil_bits}"
puts "antialiasing level: #{settings.antialiasing_level}"
puts "version: #{settings.major_version}.#{settings.minor_version}"
```

OpenGL versions above 3.0 are supported by SFML (as long as your graphics driver can handle them). Support for selecting the profile of 3.2+ contexts and whether the context debug flag is set was added in SFML 2.3. The forward compatibility flag is not supported. By default, SFML creates 3.2+ contexts using the compatibility profile because the graphics module makes use of legacy OpenGL functionality. If you intend on using the graphics module, make sure to create your context without the core profile setting or the graphics module will not function correctly. On OS X, SFML supports creating OpenGL 3.2+ contexts using the core profile only. If you want to use the graphics module on OS X, you are limited to using a legacy context which implies OpenGL version 2.1.

## A typical OpenGL-with-CrSFML program

Here is what a complete OpenGL program would look like with CrSFML:

```crystal
require "crsfml"

# create bindings
@[Link("GL")]
lib GL
  fun enable = glEnable(cap : Int32)
  fun viewport = glViewport(x : Int32, y : Int32, width : Int32, height : Int32)
  fun clear = glClear(mask : Int32)
  TEXTURE_2D       =  3553
  COLOR_BUFFER_BIT = 16384
  DEPTH_BUFFER_BIT =   256
end

GL.enable(GL::TEXTURE_2D)

# create the window
settings = SF::ContextSettings.new(32)
window = SF::RenderWindow.new(SF::VideoMode.new(800, 600), "OpenGL", settings: settings)
window.vertical_sync_enabled = true

# load resources, initialize the OpenGL states, ...

# run the main loop
running = true
while running
  # handle events
  while event = window.poll_event
    if event.is_a? SF::Event::Closed
      # end the program
      running = false
    elsif event.is_a? SF::Event::Resized
      # adjust the viewport when the window is resized
      GL.viewport(0, 0, event.width, event.height)
    end
  end

  # clear the buffers
  GL.clear(GL::COLOR_BUFFER_BIT | GL::DEPTH_BUFFER_BIT)

  # draw...

  # end the current frame (internally swaps the front and back buffers)
  window.display
end
```

Here we don't use `window.open?` as the condition of the main loop, because we need the window to remain open until the program ends, so that we still have a valid OpenGL context for the last iteration of the loop and the cleanup code.

Don't hesitate to have a look at the "OpenGL" and "Window" examples in the SFML SDK if you have further problems, they are more complete and most likely contain solutions to your problems.

## Managing multiple OpenGL windows

Managing multiple OpenGL windows is not more complicated than managing one, there are just a few things to keep in mind.

OpenGL calls are made on the active context (thus the active window). Therefore if you want to draw to two different windows within the same program, you have to select which window is active before drawing something. This can be done with the `active=` method:

```crystal
# activate the first window
window1.active = true

# draw to the first window...

# activate the second window
window2.active = true

# draw to the second window...
```

Only one context (window) can be active in a thread, so you don't need to deactivate a window before activating another one, it is deactivated automatically. This is how OpenGL works.

Another thing to know is that all the OpenGL contexts created by SFML share their resources. This means that you can create a texture or vertex buffer with any context active, and use it with any other. This also means that you don't have to reload all your OpenGL resources when you recreate your window. Only shareable OpenGL resources can be shared among contexts. An example of an unshareable resource is a vertex array object.

## Using OpenGL together with the graphics module

This tutorial was about mixing OpenGL with sfml-window, which is fairly easy since it's the only purpose of this module. Mixing with the graphics module is a little more complicated: sfml-graphics uses OpenGL too, so extra care must be taken so that SFML and user states don't conflict with each other.

If you don't know the graphics module yet, all you have to know is that the [SF::Window][] class is replaced with [SF::RenderWindow][], which inherits all its methods and adds features to draw SFML specific entities.

The only way to avoid conflicts between SFML and your own OpenGL states, is to save/restore them every time you switch from OpenGL to SFML.

- draw with OpenGL
- save OpenGL states
- draw with SFML
- restore OpenGL states
- draw with OpenGL
- ...

The easiest solution is to let CrSFML do it for you, with the `push_gl_states`/`pop_gl_states` methods:

```crystal
glDraw(...)

window.push_gl_states

window.draw(...)

window.pop_gl_states

glDraw(...)
```

Since it has no knowledge about your OpenGL code, SFML can't optimize these steps and as a result it saves/restores all available OpenGL states and matrices. This may be acceptable for small projects, but it might also be too slow for bigger programs that require maximum performance. In this case, you can handle saving and restoring the OpenGL states yourself, with `glPushAttrib`/`glPopAttrib`, `glPushMatrix`/`glPopMatrix`, etc.  
If you do this, you'll still need to restore SFML's own states before drawing. This is done with the `reset_gl_states` method.

```crystal
glDraw(...)

glPush(...)
window.reset_gl_states

window.draw(...)

glPop(...)

glDraw(...)
```

By saving and restoring OpenGL states yourself, you can manage only the ones that you really need which leads to reducing the number of unnecessary driver calls.
