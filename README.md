# ![CrSFML](logo.png)

#### [Crystal] bindings to [Simple and Fast Multimedia Library][sfml].

Documentation
-------------

- **[Installation](#installation)**

- **[Tutorials]**

- **[API Documentation]**

- **[Examples](examples)** / **[Demos]**


Introduction
------------

*CrSFML* is a library that allows SFML to be used with the Crystal programming language. [SFML] is a library written in C++, so *CrSFML* also needs to ship thin [C bindings to SFML](#about-the-sfml-wrapper).

To quote the official site of SFML,

> SFML provides a simple interface to the various components of your PC, to ease the development of games and multimedia applications.

Indeed, SFML is most often used to make video games. It provides features such as hardware-accelerated 2D graphics, handling keyboard, mouse and gamepad input, vector and matrix manipulation, managing windows (can also be used as a base for OpenGL drawing), working with multiple image formats, audio playback and recording, basic networking... Check out some [demos] of *CrSFML* to see what it can do.

*CrSFML* consists almost entirely of automatically generated code, based on SFML's header files. [More details](CONTRIBUTING.md).

### Differences between SFML and CrSFML

The API of *CrSFML* (a library for Crystal) attempts to be similar to SFML (a C++ library), but some general changes are present:

- Methods are renamed to `snake_case`.
- Getter, setter methods are changed:
    - `x.getSomeProperty()` becomes `x.some_property`.
    - `x.isSomeProperty()`, `x.hasSomeProperty()` become `x.some_property?`.
    - `x.setSomeProperty(v)` becomes `x.some_property = v`.
- Structs in Crystal are always passed by copy, so modifying them can be problematic. For example, `my_struct.x = 7` is fine but `array_of_structs[2].x = 5` will not work. To work around this, copy the whole struct, modify it, then write it back. Better yet, avoid the need to modify structs (work with them like with immutable objects).
- Member functions, such as `loadFromFile`, that are used for initialization, each have a corresponding shorthand class method (`from_file`) that raises `SF::InitError` on failure.
- SFML sometimes uses *enum* values as bitmasks. You can combine them using the `|` operator.
- *enum* members are exposed at class level, so instead of `SF::Keyboard::Code::Slash` you can use `SF::Keyboard::Slash`.
- SFML sometimes requires that an instance must remain alive as long as it is attached to the object. For example, a textured shape will cause errors if the texture object is destroyed. *CrSFML* prevents this problem by keeping a reference to the object.
- The `Event` *union* and `EventType` *enum* are represented as a class hierarchy. Instead of `ev.type == SF::Event::Resized` use `ev.is_a?(SF::Event::Resized)`; instead of `ev.size.width` use `ev.width`.
- Instead of subclassing `Drawable`, include the `Drawable` module with an abstract `draw` method.
- Most of the [API documentation] is taken directly from SFML, so don't be surprised if it talks in C++ terms.


Installation
------------

Create a _shard.yml_ file in your project's folder (or add to it) with the following contents:

```yaml
name: awesome-game
version: 0.1.0

dependencies:
  crsfml:
    github: oprypin/crsfml
```

Resolve dependencies with [Shards]:

```bash
shards install
```

During installation this will invoke `make` to build the C++ wrappers as object files.

### Prerequisites

The C++ wrappers require a C++ compiler (C++03 will do).

[SFML] must be [installed](#install-sfml), with the version that matches `SFML_VERSION` in _src/common.cr_ (usually latest). If it doesn't, no need to look for an older release of *CrSFML*, just [re-generate the sources](#generating-sources) for your version.

- Linux note: if you're installing SFML from your distribution's package manager, make sure it is not some old version.
- Mac note: SFML can be installed through [Homebrew].

If SFML is not installed in a global/default location, see [Custom SFML location](#custom-sfml-location)

### Install SFML

The first step is to install the [SFML] library itself. There are detailed [official instructions][sfml-install] on how to install it manually, however, on many systems there are easier ways.

SFML versions 2.3.x through 2.5.x are supported by *CrSFML*.

#### Linux

Many Linux-based systems provide SFML through their package manager. Make sure to install the *-dev* packages if there is such a separation in your Linux distribution of choice.

Note that most often the packages provided by Linux distributions are outdated. If you're installing an older version of SFML (not recommended), make sure that it's still [supported by *CrSFML*](#install-sfml). You will need to [re-generate the sources](#generating-sources).

Building SFML from source is as simple as downloading the source code and running:

```bash
cmake .
cmake --build
sudo make install  # optional!
```

#### Mac

The easiest way to install SFML on macOS is through the [Homebrew] package manager:

```bash
brew update
brew install sfml
```

It can also be installed by copying binaries, as described in [official instructions][sfml-install], or by building from source in the same way as [on Linux](#linux).

### Generating sources

CrSFML's sources come almost entirely from a [generator program](generate.cr). They are based on a particular version of SFML. But as sources for the latest version are already bundled, usually you don't need to do this. [More details](CONTRIBUTING.md).

As this is out of scope for [Shards], let's download the repository separately.

```bash
git clone https://github.com/oprypin/crsfml
cd crsfml
```

Then we can generate the sources, either directly with `crystal generate.cr` or as part of the build process:

```bash
touch generate.cr
make
```

If run successfully, this generates all the source files and also compiles the C++ wrapper.

If SFML can't be found, see the next section.

#### Custom SFML location

If SFML's headers and libraries are not in a path where the compiler would look by default, additional steps are needed.

First, before building the extensions, you need to configure the path

```bash
export SFML_INCLUDE_DIR=/full/path/to/sfml/include
```
Windows equivalent:
```cmd
set INCLUDE=%INCLUDE%;C:\path\to\sfml\include
```

Then, whenever using *CrSFML*, you need to configure the path to SFML libraries so the linker can find them. To apply these for the current shell session, run:

```bash
export LIBRARY_PATH=/full/path/to/sfml/lib     # Used during linking
export LD_LIBRARY_PATH=/full/path/to/sfml/lib  # Used when running an executable
```
Windows equivalent:
```cmd
set LIB=%LIB%;c:\path\to\sfml\lib
set PATH=%PATH%;c:\path\to\sfml\bin
```

Now try running an example:

```bash
cd examples
crystal snakes.cr
```

#### Make CrSFML available to your project

Create a symbolic link to *CrSFML* in your project's *lib* folder.

```bash
cd ~/my-project
mkdir lib
ln -s /full/path/to/crsfml/src lib/crsfml
```

Try using it:

```bash
echo 'require "crsfml"' >> awesome_game.cr
crystal awesome_game.cr
```

Now you're ready for the [tutorials]!


Credits
-------

*CrSFML* was made by [Oleh Prypin][oprypin].

*CrSFML* is [licensed](LICENSE) under the terms and conditions of the *zlib/libpng* license.

This library uses and is based on [SFML][sfml-authors].

Thanks to [Alan Willms][alanwillms] for translating [tutorials] to Crystal.


About the SFML wrapper
----------------------

The C++ → C wrapper's external interface consists entirely of simple functions that accept only native types (such as `float`, `uint32_t`, `char*`) and untyped pointers (`void*`). The function names consist of the original SFML class name, the function name itself, and a base62 hash of the parameter types. The user of the library is expected to know the size of the buffers needed for each object, because VoidCSFML does not allocate memory for them. Initialization is done in a buffer supplied by the user. Return types are never used; instead, the output is done into a pointer (which is usually the last argument of the function), but, as usual, the memory allocation is the caller's job. The first argument of each function is a pointer to the receiver object (if applicable).

Abstract classes are implemented by exposing a collection of global callback variables, which must be set by the user if they want to use the corresponding class. The callback's first argument is the object, and some arguments are pointers that need to be assigned to inside the callback implementation (because return values are not used).

### Why not CSFML?

[CSFML] is a great library that allows SFML to be used with C. It goes to great lengths to be human-friendly and does a good job of converting C++ idioms to C idioms. In the past *CrSFML* used to be based on it, but after a while it became apparent that the advantages of CSFML's nice interface are also disadvantages when constructing (especially auto-generated) bindings that attempt to look as close to the real SFML as possible.

Many details about functions' signatures are lost, as well as function overloads. Names of data types had to be simplified (not namespaced). And many other such small things that bring the frustration of having to reconstruct the details of the original SFML interface based on the simplified CSFML interface.

There are many aspects that prevent an efficient implementation from the standpoint of bindings, most importantly, CSFML takes memory allocation into its own hands, so any object creation in *CrSFML* involved allocation of two objects on the heap by two different libraries, and every interaction with it had to go through at least two pointers. Structs in CSFML are actually completely separate data types and they have to be constantly be converted between a "SFML-struct" and a "CSFML-struct".

Instead of that, the C++ → C wrapper passes the bare SFML data types directly through untyped pointers, and relies on the higher-level binding to deal safely with them. In case of structs the data layout is mirrored, in case of classes the pointers remain completely opaque.

Not to forget that the wrapper is made automatically, so it can be quickly updated to any SFML release and prevents human error that could happen when implementing CSFML.


[tutorials]: http://oprypin.github.io/crsfml/tutorials/
[api documentation]: http://oprypin.github.io/crsfml/api/
[releases]: https://github.com/oprypin/crsfml/releases
[demos]: https://github.com/oprypin/crsfml-examples

[sfml]: http://www.sfml-dev.org/ "Simple and Fast Multimedia Library"
[csfml]: https://github.com/SFML/CSFML
[sfml-authors]: https://github.com/SFML/SFML#readme
[sfml-install]: http://www.sfml-dev.org/tutorials/

[homebrew]: http://brew.sh/

[crystal]: http://crystal-lang.org/
[shards]: https://github.com/crystal-lang/shards

[oprypin]: https://github.com/oprypin
[alanwillms]: https://github.com/alanwillms
