VoidCSFML
=========

### [C][] bindings to [Simple and Fast Multimedia Library][sfml].

Information
-----------

*VoidCSFML* is a library that allows [SFML][] (a library written in C++) to be used with pure C. It is not meant to be human-friendly or be used directly in C code (though it's possible). *VoidCSFML* is just an intermediate step between SFML and a higher-level binding (in this case, to [Crystal][] programming language) which is used because it's much easier to interface with a C library than a C++ one.

You can browse the [latest generated source code](https://github.com/oprypin/crsfml/tree/sources/voidcsfml) of *VoidCSFML*, but it comes almost entirely from a [generator program](https://github.com/oprypin/crsfml/blob/master/generate.cr), so contributions are accepted only in the *master* branch.

Installation
------------

### Prerequisites

Latest [SFML][] must be installed. Check the [official instructions][sfml-install] for that.

- Linux note: if you're installing SFML from your distribution's package manager, make sure it is not some old version.
- Mac note: SFML can be installed through [Homebrew][].

To generate the source code, a [Crystal][] compiler is required.

For building, [CMake][] and a C++ compiler are required (to the best of the author's knowledge, *VoidCSFML* is compatible with C++03).

### Obtaining the sources

Generating the sources is an **optional** step. If you are sure you have a matching version of SFML to the [pre-generated sources](https://github.com/oprypin/crsfml/tree/sources/voidcsfml) (usually latest), you can use these. In fact, you may already be looking at the generated sources, just check whether the *voidcsfml/src* folder is populated. For development it's usually best to [build whole CrSFML](#building-crsfml). But, for completeness' sake, here's how to generate the sources manually:

Go to *CrSFML*'s root folder and run [generate.cr](https://github.com/oprypin/crsfml/blob/master/generate.cr):

```bash
crystal run generate.cr -- /usr/include
```

The optional argument is a path to the headers folder (a folder that contains *SFML/System.hpp*, etc.):

### Building CrSFML

Building *VoidCSFML* (including sources) is also a part of *CrSFML*'s build process, so you may utilize that instead of building the sources directly. Go to *CrSFML*'s root folder and run:

```bash
cmake . && make
```

> **Optional:** [out-of-source builds][] are also supported, but note that even the sources go to the build directory, so you need perform all the following steps inside the build directory and not the root directory.

If ran successfully, this generates all the source files for *VoidCSFML* and *CrSFML*, and also compiles *VoidCSFML*.

If SFML can't be found, consult the [CMake options](#cmake-options) section.

### Building VoidCSFML

If you have generated the sources manually or downloaded pre-generated sources, you can go to the *voidcsfml* folder and run:

```bash
cmake . && make
```

> **Optional:** [out-of-source builds][] are also supported.

If ran successfully, this produces the libraries in the *voidcsfml/lib* folder.

If SFML can't be found, consult the [CMake options](#cmake-options) section.

### Installing VoidCSFML

Because *VoidCSFML* is not a general-purpose library, it doesn't really make sense to globally install it on your system. Still, it can be done without problems. Go to the *voidcsfml* folder after it has been built, and run:

```bash
sudo make install
```

If you do not wish to install it, you must manually specify paths to it when using it. To use it with a C compiler, you must specify the full path to the include and lib folders, in addition to linking `-lvoidcsfml-system -lsfml-system` etc. To use it with a higher-level binding (like *CrSFML*), you just need to specify the paths for the linker. So, either provide these environment variables whenever using *VoidCSFML*, or permanently apply them to your current shell session for easier usage:

```bash
export LIBRARY_PATH=/full/path/to/crsfml/voidcsfml/lib
export LD_LIBRARY_PATH="$LIBRARY_PATH"
```

### CMake options

If *SFML* is installed in an unusual location, some additional work needs to be done when compiling *VoidCSFML*. At the very least, it needs to find the file *SFML/cmake/Modules/FindSFML.cmake*. So specify the full path to the folder that contains it.

On Mac, if SFML is installed through [Homebrew][], CMake must be run like this:

```bash
sfml=/usr/local/Cellar/sfml/2.*
cmake -DCMAKE_MODULE_PATH="$sfml/share/SFML/cmake/Modules" . && make
```

When SFML is built in a local folder, even more options are needed:

```bash
sfml=/full/path/to/SFML
cmake -DSFML_ROOT="$sfml" -DSFML_INCLUDE_DIR="$sfml/include" -DCMAKE_MODULE_PATH="$sfml/cmake/Modules" . && make
```

This also means that when using *VoidCSFML*, in addition to specifying the full path to its libs, you will also need to specify the full path to SFML's libs:

```bash
export LD_LIBRARY_PATH="/full/path/to/crsfml/voidcsfml/lib:/full/path/to/SFML/lib"
```

Usage
-----

*VoidCSFML*'s external interface consists entirely of simple functions that accept only native types (such as `float`, `uint32_t`, `char*`) and untyped pointers (`void*`). The function names consist of the original SFML class name, the function name itself, and a base62 hash of the parameter types. The user of the library is expected to know the size of the buffers needed for each object, because VoidCSFML does not allocate memory for them. Initialization is done in a buffer supplied by the user. Return types are never used; instead, the output is done into a pointer (which is usually the last argument of the function), but, as usual, the memory allocation is the caller's job. The first argument of each function is a pointer to the receiver object (if applicable).

Abstract classes are implemented by exposing a collection of global callback variables, which must be set by the user if they want to use the corresponding class. The callback's first argument is the object, and some arguments are pointers that need to be assigned to inside the callback implementation (because return values are not used).

Here is a usage example (just to get an idea about what happens under the hood, and to confirm it works):

```c
#include <voidcsfml/system.h>
#include <voidcsfml/window.h>

// Use the same "large enough" buffer everywhere just for demostration
#define buf(name)  char name[1024]

int main()
{
    buf(videomode);
    videomode_initialize_emSemSemS(videomode, 640, 480, 24);

    buf(contextsettings);
    contextsettings_initialize_emSemSemSemSemSemSGZq(contextsettings, 0, 0, 0, 1, 1, 0, 0);

    buf(window);
    uint32_t title[] = {'V','o','i','d','C','S','F','M','L'};
    window_initialize_wg0bQssaLFw4(window, videomode, 9, title, 7, contextsettings);

    window_display(window);

    buf(time);
    seconds_Bw9(3, time);
    sleep_f4T(time);

    return 0;
}
```

Compile with:

```bash
gcc -lvoidcsfml-window -lsfml-window -lvoidcsfml-system -lsfml-system main.c
```

(or same with `clang`). On Windows:

```cmd
cl -I include voidcsfml-window.lib voidcsfml-system.lib -Tp test.c
```

Note that additional flags may be needed if *VoidCSFML* is not installed globally (see above).

Why not CSFML?
--------------

[CSFML][] is a great library that allows SFML to be used with C. It goes to great lengths to be human-friendly and does a good job of converting C++ idioms to C idioms. In the past *CrSFML* used to be based on it, but after a while it became apparent that the advantages of CSFML's nice interface are also disadvantages when constructing (especially auto-generated) bindings that attempt to look as close to the real SFML as possible.

Many details about functions' signatures are lost, as well as function overloads. Names of data types had to be simplified (not namespaced). And many other such small things that bring the frustration of having to reconstruct the details of the original SFML interface based on the simplified CSFML interface.

There are many aspects that prevent an efficient implementation from the standpoint of bindings, most importantly, CSFML takes memory allocation into its own hands, so any object creation in *CrSFML* involved allocation of two objects on the heap by two different libraries, and every interaction with it had to go through at least two pointers. Structs in CSFML are actually completely separate data types and they have to be constantly be converted between a "SFML-struct" and a "CSFML-struct".

Instead of that, *VoidCSFML* passes the bare SFML data types directly through untyped pointers, and relies on the higher-level binding to deal safely with them. In case of structs the data layout is mirrored, in case of classes the pointers remain completely opaque.

Not to forget that *VoidCSFML* is made automatically, so it can be quickly updated to any SFML release and prevents human error that could happen when implementing CSFML.

Credits
-------

*VoidCSFML* was made by [Oleh Prypin][oprypin].

*VoidCSFML* is [licensed](LICENSE) under the terms and conditions of the *zlib/libpng* license.

This library uses and is based on [SFML][sfml-authors].

The CMake files are based on those of [CSFML][].


[sfml]: http://www.sfml-dev.org/ "Simple and Fast Multimedia Library"
[csfml]: https://github.com/SFML/CSFML
[sfml-install]: http://www.sfml-dev.org/tutorials/
[sfml-authors]: https://github.com/SFML/SFML#readme

[cmake]: https://cmake.org/
[out-of-source builds]: https://cmake.org/Wiki/CMake_FAQ#Out-of-source_build_trees
[homebrew]: http://brew.sh/

[c]: https://en.wikipedia.org/wiki/C_(programming_language)
[crystal]: http://crystal-lang.org/

[oprypin]: https://github.com/oprypin
