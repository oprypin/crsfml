CrSFML
======
#### [Crystal][] bindings to [Simple and Fast Multimedia Library][sfml] (through [CSFML][]).

**See [introduction](#introduction), [examples](examples), [documentation][].**

*CrSFML* supports CSFML 2.2. It has been tested on Linux 64-bit. It should work on other major systems if Crystal supports them.

[CSFML][] 2.2, which requires [SFML][] 2.2, must be installed to use it.

Crystal 0.6.1 and earlier are **not** supported.


[Troubleshooting][]
-------------------


Introduction
------------

*CrSFML* allows you to use [SFML][], which is a library made in C++. So most information and [tutorials][sfml-tutorials] for SFML revolve around C++. It is a good idea to get familiar with SFML itself first.

Each SFML module is implemented with 3 source files.

- *lib*-files are an auto-generated definition of CSFML API: `lib CSFML`. These can be used directly, by themselves or in combination
with wrappers.
- *obj*-files are auto-generated convenient object and function wrappers. These make up the `module SF`. The main file for each SFML module just imports these and adds some more convenience functionality, like overloaded functions that were dropped in CSFML compared to SFML, and ways to avoid dealing with the remaining exposed pointers.

The API attempts to be similar to SFML's, but some general changes are present:

- There is a clear separation between "classes" and "structs". Classes are wrapped, and structs are taken directly from `lib`s, making them limited, for example, instead of instance methods they have functions in the root of the namespace.
- To construct an object (`sf::SomeType x(param)`):
    - `x = SF::SomeType.new(param)` for classes.
    - `x = SF::some_type(param)` for structs.
    - Member functions, such as `loadFromFile`, that are used for initialization, are just overloaded `initialize`.
- Everything is renamed to `snake_case`.
- Getter, setter functions are changed:
    - `x.getSomeProperty()` and `x.isSomeProperty()` both become `x.some_property`.
    - `x.setSomeProperty(v)` becomes `x.some_property = v`.
- SFML sometimes uses `enum` values as bitmasks. You can combine them using the `|` operator.
- Unicode just works.
- Type differences:
    - `unsigned int` is mapped as `Int32`, etc., so you don't have to bother with unsigned types. This shouldn't cause problems, but it might.
- Most of the [documentation][] is taken directly from CSFML, so don't be surprised if it talks in C/C++ terms.

See [examples](examples) to learn more.


Acknowledgements
----------------

[License](LICENSE): zlib/libpng

This library uses and is based on [SFML][] and [CSFML][].

[Crystal][] and [Python][] programming languages are used.


[documentation]: http://blaxpirit.github.io/crsfml/
[troubleshooting]: https://github.com/BlaXpirit/crsfml/wiki/Troubleshooting
[sfml]: http://www.sfml-dev.org/ "Simple and Fast Multimedia Library"
[csfml]: http://www.sfml-dev.org/download/csfml/
[sfml-tutorials]: http://www.sfml-dev.org/tutorials/
[crystal]: http://crystal-lang.org/
[python]: http://python.org/
