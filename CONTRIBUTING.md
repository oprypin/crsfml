Writing issues
--------------

There are no particular requirements about opening an issue to this repository. But the more details you provide, the better.


Contributing code
-----------------

*CrSFML* consists mostly of automatically generated code. The generator program ([*generate.cr*](generate.cr)), the static parts of *CrSFML* and the build files (CMake) are the main components to edit.

In addition to these, each SFML "module" has 3 files generated for it:

- *src/__module__/ext.cpp* (C++) - functions that interact with C++ SFML objects but expose a pure C interface
- *src/__module__/lib.cr* (Crystal) - definition of the header file for Crystal
- *src/__module__/obj.cr* (Crystal) - object-oriented wrappers

*src/__module__/__module__.cr* files are tiny additions that can't be automatically generated, but they serve as the entry point for each module.

Most of the changes to *CrSFML* will happen within one file, [*generate.cr*](generate.cr). It is indeed a very complicated and messy program. The main idea is to parse SFML's header files with... regular expressions (yes, I'm very happy with this decision, it works out nicely due to the extreme quality and consistency of SFML), form an object-based model of the constructs, and use them to render 3 files per module (as seen above).

If you want to implement a small change but are totally lost as to where it should go, you may want to `crystal generate.cr -- --debug`. This annotates every line in the generated files with the number of line in *generate.cr* that produced it. Then, hopefully, the backtracking won't be too bad.

After introducing a change to *generate.cr* you can immediately try it out in some example code after running the generator and/or `make`.


Contributing documentation
--------------------------

As mentioned, *CrSFML*'s code is mostly automatically generated, and the documentation is taken automatically from SFML (a C++ library). If you edit _src/*/obj.cr_ files, the changes will not be saved. However, the build process is set up to apply manual edits to the documentation by storing all the docs in _docs/api/*.md_ files. Please edit those files instead.

To ensure that the documentation files are kept up to date, when upgrading the version of SFML, run `tools/update.cr`.
