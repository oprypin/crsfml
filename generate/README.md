Run *generate.sh* on Linux to (re)generate *lib* and *obj* source files based on CSFML's header files.

This automatic generator expects the header files to be under *CSFML/include/SFML*. It requires [Python][] 3.3+ and [pycparser][].

The generator's code is very messy, and there are some specific replacements that make the word "automatic" a bit dishonest. Still, it should allow transitioning to new CSFML versions with little to no intervention.


[python]: http://python.org
[pycparser]: https://pypi.python.org/pypi/pycparser
