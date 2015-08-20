# Using OpenGL in a SFML window

## Introduction

This tutorial is not about OpenGL itself, but rather how to use SFML as an environment for OpenGL, and how to mix them together. 

As you know, one of the most important features of OpenGL is portability. But OpenGL alone won't be enough to create complete programs: you need a window, a rendering context, user input, etc. You would have no choice but to write OS-specific code to handle this stuff on your own. That's where the sfml-window module comes into play. Let's see how it allows you to play with OpenGL. 

## Including and linking OpenGL to your application

OpenGL headers are not the same on every OS. Therefore, SFML provides an "abstract" header that takes care of including the right file for you. 

```
#include <SFML/OpenGL.hpp>
```

This header includes OpenGL functions, and nothing else. People sometimes think that SFML automatically includes OpenGL extension headers because SFML loads extensions itself, but it's an implementation detail. From the user's point of view, OpenGL extension loading must be handled like any other external library. 

You will then need to link your program to the OpenGL library. Unlike what it does with the headers, SFML can't provide a unified way of linking OpenGL. Therefore, you need to know which library to link to according to what operating system you're using ("opengl32" on Windows, "GL" on Linux, etc.). 

OpenGL functions start with the "gl" prefix. Remember this when you get linker errors, it will help you find which library you forgot to link. 

## Creating an OpenGL window

Since SFML is based on OpenGL, its windows are ready for OpenGL calls without any extra effort. 

```
sf::Window window(sf::VideoMode(800, 600), "OpenGL");

// it works out of the box
glEnable(GL_TEXTURE_2D);
...
```

In case you think it is *too* automatic, [Window]({{book.api}}/Window.html)'s constructor has an extra argument that allows you to change the settings of the underlying OpenGL context. This argument is an instance of the structure, it provides access to the following settings: 

  * `depthBits` is the number of bits per pixel to use for the depth buffer (0 to disable it)
  * `stencilBits` is the number of bits per pixel to use for the stencil buffer (0 to disable it)
  * `antialiasingLevel` is the multisampling level
  * `majorVersion` and `minorVersion` comprise the requested version of OpenGL

```
sf::ContextSettings settings;
settings.depthBits = 24;
settings.stencilBits = 8;
settings.antialiasingLevel = 4;
settings.majorVersion = 3;
settings.minorVersion = 0;

sf::Window window(sf::VideoMode(800, 600), "OpenGL", sf::Style::Default, settings);
```

If any of these settings is not supported by the graphics card, SFML tries to find the closest valid match. For example, if 4x anti-aliasing is too high, it tries 2x and then falls back to 0.  
In any case, you can check what settings SFML actually used with the `getSettings` function: 

```
sf::ContextSettings settings = window.getSettings();

std::cout << "depth bits:" << settings.depthBits << std::endl;
std::cout << "stencil bits:" << settings.stencilBits << std::endl;
std::cout << "antialiasing level:" << settings.antialiasingLevel << std::endl;
std::cout << "version:" << settings.majorVersion << "." << settings.minorVersion << std::endl;
```

OpenGL versions above 3.0 are supported by SFML (as long as your graphics driver can handle them). Support for selecting the profile of 3.2+ contexts and whether the context debug flag is set was added in SFML 2.3. The forward compatibility flag is not supported. By default, SFML creates 3.2+ contexts using the compatibility profile because the graphics module makes use of legacy OpenGL functionality. If you intend on using the graphics module, make sure to create your context without the core profile setting or the graphics module will not function correctly. On OS X, SFML supports creating OpenGL 3.2+ contexts using the core profile only. If you want to use the graphics module on OS X, you are limited to using a legacy context which implies OpenGL version 2.1. 

## A typical OpenGL-with-SFML program

Here is what a complete OpenGL program would look like with SFML: 

```
#include <SFML/Window.hpp>
#include <SFML/OpenGL.hpp>

int main()
{
    // create the window
    sf::Window window(sf::VideoMode(800, 600), "OpenGL", sf::Style::Default, sf::ContextSettings(32));
    window.setVerticalSyncEnabled(true);

    // load resources, initialize the OpenGL states, ...

    // run the main loop
    bool running = true;
    while (running)
    {
        // handle events
        sf::Event event;
        while (window.pollEvent(event))
        {
            if (event.type == sf::Event::Closed)
            {
                // end the program
                running = false;
            }
            else if (event.type == sf::Event::Resized)
            {
                // adjust the viewport when the window is resized
                glViewport(0, 0, event.size.width, event.size.height);
            }
        }

        // clear the buffers
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

        // draw...

        // end the current frame (internally swaps the front and back buffers)
        window.display();
    }

    // release resources...

    return 0;
}
```

Here we don't use `window.isOpen()` as the condition of the main loop, because we need the window to remain open until the program ends, so that we still have a valid OpenGL context for the last iteration of the loop and the cleanup code. 

Don't hesitate to have a look at the "OpenGL" and "Window" examples in the SFML SDK if you have further problems, they are more complete and most likely contain solutions to your problems. 

## Managing multiple OpenGL windows

Managing multiple OpenGL windows is not more complicated than managing one, there are just a few things to keep in mind. 

OpenGL calls are made on the active context (thus the active window). Therefore if you want to draw to two different windows within the same program, you have to select which window is active before drawing something. This can be done with the `setActive` function: 

```
// activate the first window
window1.setActive(true);

// draw to the first window...

// activate the second window
window2.setActive(true);

// draw to the second window...
```

Only one context (window) can be active in a thread, so you don't need to deactivate a window before activating another one, it is deactivated automatically. This is how OpenGL works. 

Another thing to know is that all the OpenGL contexts created by SFML share their resources. This means that you can create a texture or vertex buffer with any context active, and use it with any other. This also means that you don't have to reload all your OpenGL resources when you recreate your window. Only shareable OpenGL resources can be shared among contexts. An example of an unshareable resource is a vertex array object. 

## OpenGL without a window

Sometimes it might be necessary to call OpenGL functions without an active window, and thus no OpenGL context. For example, when you load textures from a separate thread, or before the first window is created. SFML allows you to create window-less contexts with the [Context]({{book.api}}/Context.html) class. All you have to do is instantiate it to get a valid context. 

```
int main()
{
    sf::Context context;

    // load OpenGL resources...

    sf::Window window(sf::VideoMode(800, 600), "OpenGL");

    ...

    return 0;
}
```

## Rendering from threads

A typical configuration for a multi-threaded program is to handle the window and its events in one thread (the main one), and rendering in another one. If you do so, there's an important rule to keep in mind: you can't activate a context (window) if it's active in another thread. This means that you have to deactivate your window before launching the rendering thread. 

```
void renderingThread(sf::Window* window)
{
    // activate the window's context
    window->setActive(true);

    // the rendering loop
    while (window->isOpen())
    {
        // draw...

        // end the current frame -- this is a rendering function (it requires the context to be active)
        window->display();
    }
}

int main()
{
    // create the window (remember: it's safer to create it in the main thread due to OS limitations)
    sf::Window window(sf::VideoMode(800, 600), "OpenGL");

    // deactivate its OpenGL context
    window.setActive(false);

    // launch the rendering thread
    sf::Thread thread(&renderingThread, &window);
    thread.Launch();

    // the event/logic/whatever loop
    while (window.isOpen())
    {
        ...
    }

    return 0;
}
```

## Using OpenGL together with the graphics module

This tutorial was about mixing OpenGL with sfml-window, which is fairly easy since it's the only purpose of this module. Mixing with the graphics module is a little more complicated: sfml-graphics uses OpenGL too, so extra care must be taken so that SFML and user states don't conflict with each other. 

If you don't know the graphics module yet, all you have to know is that the [Window]({{book.api}}/Window.html) class is replaced with [RenderWindow]({{book.api}}/RenderWindow.html), which inherits all its functions and adds features to draw SFML specific entities. 

The only way to avoid conflicts between SFML and your own OpenGL states, is to save/restore them every time you switch from OpenGL to SFML. 

```
- draw with OpenGL

- save OpenGL states

- draw with SFML

- restore OpenGL states

- draw with OpenGL

...
```

The easiest solution is to let SFML do it for you, with the `pushGLStates`/`popGLStates` functions : 

```
glDraw...

window.pushGLStates();

window.draw(...);

window.popGLStates();

glDraw...
```

Since it has no knowledge about your OpenGL code, SFML can't optimize these steps and as a result it saves/restores all available OpenGL states and matrices. This may be acceptable for small projects, but it might also be too slow for bigger programs that require maximum performance. In this case, you can handle saving and restoring the OpenGL states yourself, with `glPushAttrib`/`glPopAttrib`, `glPushMatrix`/`glPopMatrix`, etc.  
If you do this, you'll still need to restore SFML's own states before drawing. This is done with the `resetGLStates` function. 

```
glDraw...

glPush...
window.resetGLStates();

window.draw(...);

glPop...

glDraw...
```

By saving and restoring OpenGL states yourself, you can manage only the ones that you really need which leads to reducing the number of unnecessary driver calls. 
