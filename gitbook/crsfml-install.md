# Installing CrSFML

## Introduction

CrSFML is a library that allows you to use [Simple and Fast Multimedia Library](http://www.sfml-dev.org/) with Crystal. SFML is a library written in C++, but it has official bindings to C, called [CSFML](http://www.sfml-dev.org/download/csfml/), which is what CrSFML actually provides bindings to.

This is why SFML and CSFML themselves must be installed first.


## Installing SFML and CSFML

Please find the relevant information at the CrSFML wiki: **[Installing CSFML](https://github.com/BlaXpirit/crsfml/wiki/Installing-CSFML)**

### Test Program

If you're having problems making CrSFML work, the most likely cause is incorrectly installed dependencies. So first make sure that you can run the following C program. It should display a closable, resizable black window.

```c
#include <SFML/Window.h>

int main() {
    sfVideoMode mode = {800, 600, 32};
    sfWindow* window = sfWindow_create(mode, "CSFML works!", sfDefaultStyle, NULL);
    while (sfWindow_isOpen(window)) {
        sfEvent event;
        while (sfWindow_pollEvent(window, &event)) {
            if (event.type == sfEvtClosed)
                sfWindow_close(window);
        }
        sfWindow_display(window);
    }
    sfWindow_destroy(window);
    return 0;
}
```
Compile with `gcc -lcsfml-window -lcsfml-system -lsfml-window -lsfml-system main.c` or same with `clang`.

One of the typical problems is incompatible versions of SFML and CSFML. CSFML lags behind with updates, so you may need to get an older matching version of SFML.


## Installing CrSFML

Source libraries for Crystal are not installed globally. To use CrSFML in your project you need to have its source files available in the *libs/crsfml* subfolder.

The easiest way to do this is to create a *Projectfile* in your project's folder (or add to it) with the following contents:

```ruby
deps do
  github "BlaXpirit/crsfml"
end
```

**[An example Projectfile](https://github.com/BlaXpirit/crsfml-examples/blob/master/cube/Projectfile)**

Then running `crystal deps` downloads and puts CrSFML in the mentioned subfolder automatically.

### Test Program

Make a file with the following contents and run it using Crystal. It should display a closable, resizable black window.

```ruby
require "crsfml/window"

window = SF::Window.new(SF.video_mode(800, 600), "CrSFML works!")

while window.open?
  while event = window.poll_event()
    if event.type == SF::Event::Closed
      window.close()
    end
  end
  window.display()
end
```

**[Try some other examples]({{book.examples}})**
