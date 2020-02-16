Writing issues
==============

There are no particular requirements about opening an issue to this repository. But the more details you provide, the better.

Don't hesitate about informing the author about minor issues, even with the documentation, but remember that the API documentation is taken directly from C++ and it is known that there are a lot of things that don't make sense.

Contributing code
=================

*CrSFML* consists mostly of automatically generated code. The generator program ([*generate.cr*](generate.cr)), the static parts of *CrSFML* and the build files (CMake) are the main components to edit.

In addition to these, each SFML "module" has 4 files generated for it:

- *voidcsfml/src/voidcsfml/__module__.cpp* (C++) - functions that interact with C++ SFML objects but expose a pure C interface
- *voidcsfml/include/voidcsfml/__module__.h* (C) - header file for the functions
- *src/__module__/lib.cr* (Crystal) - definition of the header file for Crystal
- *src/__module__/obj.cr* (Crystal) - object-oriented wrappers

[How *VoidCSFML* works](voidcsfml/README.md#usage)

- *src/__module__/__module__.cr* files are tiny additions that can't be automatically generated, but they serve as the entry point for each module.


Most of the changes to *CrSFML* will happen within one file, [*generate.cr*](generate.cr). It is indeed a very complicated and messy program. The main idea is to parse SFML's header files with... regular expressions (yes, I'm very happy with this decision, it works out nicely due to the extreme quality and consistency of SFML), form an object-based model of the constructs, and use them to render 4 files per module (as seen above).

If you want to implement a small change but are totally lost as to where it should go, you may want to `crystal generate.cr -- --debug`. This annotates every line in the generated files with the number of line in *generate.cr* that produced it. Then, hopefully, the backtracking won't be too bad.

After introducing a change to *generate.cr* you can immediately try it out in some example code after running `cmake . && make`.

Contributing documentation
==========================

As mentioned, *CrSFML*'s code is mostly automatically generated, and the documentation is taken automatically from SFML (a C++ library). If you edit _src/*/obj.cr_ files, the changes will not be saved. However, the build process is set up to apply manual edits to the documentation by storing these changes in _docs/*.diff_ files. If you'd like to edit the documentation strings in source code and keep the changes, run `crystal save_docs.cr`. Your edits will be saved into the *diff* files. Note that this requires you to have the latest version of SFML to match what is already stored, otherwise differences in documentation between SFML versions will also be saved, but they're unwanted.
