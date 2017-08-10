# ![CrSFML](logo.png)

#### [Crystal][] bindings to [Simple and Fast Multimedia Library][sfml].

Documentation
-------------

- **[Installation](#installation)**

- **[Tutorials][]**

- **[API Documentation][]**

- **[Examples](examples)** / **[Demos][]**


Introduction
------------

*CrSFML* is a library that allows SFML to be used with the Crystal programming language. [SFML][] is a library written in C++, so *CrSFML* also needs to ship C bindings to SFML, called *VoidCSFML*.

To quote the official site of SFML,

> SFML provides a simple interface to the various components of your PC, to ease the development of games and multimedia applications.

Indeed, SFML is most often used to make video games. It provides features such as hardware-accelerated 2D graphics, handling keyboard, mouse and gamepad input, vector and matrix manipulation, managing windows (can also be used as a base for OpenGL drawing), working with multiple image formats, audio playback and recording, basic networking... Check out some [demos][] of *CrSFML* to see what it can do.

*CrSFML* consists almost entirely of automatically generated code, based on SFML's header files. The *master* git branch contains the [generator program](generate.cr) and the small manually written source files. The generated source code can be viewed at the [sources][] branch.

### Differences between SFML and CrSFML

The API of *CrSFML* (a library for Crystal) attempts to be similar to SFML (a C++ library), but some general changes are present:

- Methods are renamed to `snake_case`.
- Getter, setter methods are changed:
    - `x.getSomeProperty()` becomes `x.some_property`.
    - `x.isSomeProperty()`, `x.hasSomeProperty()` become `x.some_property?`.
    - `x.setSomeProperty(v)` becomes `x.some_property = v`.
- Structs in Crystal are are always passed by copy, so modifying them can be problematic. For example, `my_struct.x = 7` is fine but `array_of_structs[2].x = 5` will not work. To work around this, copy the whole struct, modify it, then write it back. Better yet, avoid the need to modify structs (work with them like with immutable objects).
- Member functions, such as `loadFromFile`, that are used for initialization, each have a corresponding shorthand class method (`from_file`) that raises `SF::InitError` on failure.
- SFML sometimes uses *enum* values as bitmasks. You can combine them using the `|` operator.
- *enum* members are exposed at class level, so instead of `SF::Keyboard::Code::Slash` you can use `SF::Keyboard::Slash`.
- SFML sometimes requires that an instance must remain alive as long as it is attached to the object. For example, a textured shape will cause errors if the texture object is destroyed. *CrSFML* prevents this problem by keeping a reference to the object.
- The `Event` *union* and `EventType` *enum* are represented as a class hierarchy. Instead of `ev.type == SF::Event::Resized` use `ev.is_a?(SF::Event::Resized)`; instead of `ev.size.width` use `ev.width`.
- Instead of subclassing `Drawable`, include the `Drawable` module with an abstract `draw` method.
- Most of the [documentation](http://oprypin.github.io/crsfml/api/) is taken directly from SFML, so don't be surprised if it talks in C++ terms.


Installation
------------

Note that using [Shards][] is not enough to install *CrSFML*.

This section defines two sets of step-by-step instructions to install *CrSFML* but these are not the only ways to do it; they can even be mixed (see [VoidCSFML installation instructions](voidcsfml/README.md#installation) for an alternative look)

- [Approach 1](#approach-1) **(strongly recommended)**: Generate latest *CrSFML* and *VoidCSFML* source code; build and use them from a local directory
    - Advantages:
        - This is the right setup if you wish to:
             - Distribute your application with the libraries
             - Contribute to *CrSFML*
        - The bindings can be fine-tuned to your system.
        - Supports multiple recent [SFML versions](#install-sfml).
    - Disadvantages:
        - Need to always provide full path to *VoidCSFML* libraries when running a program using *CrSFML*.
        - Can't install *CrSFML* directly though [shards][].
- [Approach 2](#approach-2): Use pre-compiled sources; build *VoidCSFML* and install it globally; install a release of *CrSFML* through [shards][]
    - Advantages:
        - Convenient installation.
    - Disadvantages:
        - Less performant, because memory layout optimizations can't be cross-platform.
        - Global installation litters your system.
        - Tied to a particular version of SFML (only SFML 2.4 right now).

### Install SFML

The first step is to install the [SFML][] library itself. There are detailed [official instructions][sfml-install] on how to install it manually, however, on many systems there are easier ways.

SFML versions 2.4.x and 2.3.x are supported by *CrSFML*.

#### Linux

Many Linux-based systems provide SFML through their package manager. Make sure to install the *-dev* packages if there is such a separation in your Linux distribution of choice.

Note that most often the packages provided by Linux distributions are outdated. If you're installing an older version of SFML (not recommended), make sure that it's still [supported by *CrSFML*](#install-sfml). For installation with [Approach 2](#approach-2) getting the latest version is even more important.

For information on building SFML from source, check out [this article][sfml-install-linux] (but no need to install CSFML). It is as simple as downloading the source code and running:

```bash
cmake . && make && sudo make install
```

#### Mac

The easiest way to install SFML on macOS is through the [Homebrew][] package manager:

```bash
brew update
brew install sfml
```

It can also be installed by copying binaries, as described in [official instructions][sfml-install], or by building from source in the same way as [on Linux](#linux).


### Approach 1

Prerequisites: [Git][], [CMake][], [Crystal][], a C++ compiler

#### [Install SFML](#install-sfml)

#### Download latest generator source code

```bash
git clone https://github.com/oprypin/crsfml
cd crsfml
```

#### Build CrSFML

```bash
cmake . && make
```

> **Optional:** [out-of-source builds][] are also supported, but note that even the sources go to the build directory, so you would need perform all the following steps inside the build directory and not the root *crsfml* directory.

If ran successfully, this generates all the source files for *VoidCSFML* and *CrSFML*, and also compiles *VoidCSFML*.

If SFML can't be found, make sure it is installed and consult the [CMake options](voidcsfml/README.md#cmake-options) section.

#### Configure the path to VoidCSFML libraries

Now the *voidcsfml* folder contains the dynamic libraries that are needed to run any *CrSFML* program. So you need to configure the full path to them whenever you work with *CrSFML* so the linker can find them. To apply these for the current shell session, run:

```bash
export LIBRARY_PATH=/full/path/to/crsfml/voidcsfml  # Used during linking
export LD_LIBRARY_PATH="$LIBRARY_PATH"              # Used when running a binary

# Try running an example:
cd examples
crystal snakes.cr
```

#### Make CrSFML available to your project

Create a symbolic link to *CrSFML* in your project's *lib* folder.

```bash
cd ~/my-project
mkdir lib
ln -s /full/path/to/crsfml/src lib/crsfml

# Try importing it:
echo 'require "crsfml"' >> my_project.cr
crystal my_project.cr
```

Now you're ready for the [tutorials][]!

### Approach 2

Prerequisites: [CMake][], [Crystal][], a C++ compiler

#### [Install SFML](#install-sfml)

#### Download a release of CrSFML

Find the release of *CrSFML* that corresponds to your installed version of *SFML* (latest is strongly recommended) at the [releases][] page. Note that only releases starting at 2.4 are applicable, and only SFML versions since 2.4 are supported in this approach. The older releases are legacy CSFML-based releases.

Download and extract it, and remember the version of the release (let's say v1.2.3) for later.

#### Install VoidCSFML

Go to the *voidcsfml* subfolder, build *VoidCSFML* and install it globally:

```bash
cd voidcsfml
cmake . && make && sudo make install
```

This should put the headers in */usr/local/include* and the libs in */usr/local/lib*.

If SFML can't be found, make sure it is installed and consult the [CMake options](voidcsfml/README.md#cmake-options) section.

#### Install a release of CrSFML

Create a shard.yml file in your project's folder (or add to it) with the following contents:

```yaml
name: awesome-game
version: 0.1.0

dependencies:
  crsfml:
    github: oprypin/crsfml
    version: 1.2.3
```

(Replace *1.2.3* with the actual version of *CrSFML* that you downloaded earlier.)

Resolve dependencies with [shards][]:

```bash
crystal deps

# Try importing it:
echo 'require "crsfml"' >> awesome_game.cr
crystal awesome_game.cr
```

Now you're ready for the [tutorials][]!


Credits
-------

*CrSFML* was made by [Oleh Prypin][blaxpirit].

*CrSFML* is [licensed](LICENSE) under the terms and conditions of the *zlib/libpng* license.

This library uses and is based on [SFML][sfml-authors].

Thanks to [Alan Willms][alanwillms] for translating [tutorials][] to Crystal.


[tutorials]: http://oprypin.github.io/crsfml/tutorials/
[api documentation]: http://oprypin.github.io/crsfml/api/
[releases]: https://github.com/oprypin/crsfml/releases
[demos]: https://github.com/oprypin/crsfml-examples
[sources]: https://github.com/oprypin/crsfml/tree/sources

[sfml]: http://www.sfml-dev.org/ "Simple and Fast Multimedia Library"
[csfml]: http://www.sfml-dev.org/download/csfml/
[sfml-authors]: https://github.com/SFML/SFML#readme
[sfml-install]: http://www.sfml-dev.org/tutorials/
[sfml-install-linux]: http://blaxpirit.com/blog/12/build-sfml-and-csfml-on-linux.html

[cmake]: https://cmake.org/
[out-of-source builds]: https://cmake.org/Wiki/CMake_FAQ#Out-of-source_build_trees
[homebrew]: http://brew.sh/
[git]: https://git-scm.com/

[crystal]: http://crystal-lang.org/
[shards]: https://github.com/crystal-lang/shards

[blaxpirit]: https://github.com/oprypin
[alanwillms]: https://github.com/alanwillms
