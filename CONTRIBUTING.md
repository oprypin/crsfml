The main way to contribute to *CrSFML* is to use it and report issues.

If you want to contribute code to this project, consider the following:

Each SFML module is implemented with 3 source files.


The files *src/lib/csfml/MODULE.cr* (except *common.cr*) and *src/MODULE_obj.cr* (except *common_obj*) are automatically [generated](generate). Pull requests that directly change them will not be accepted (the changes would just be lost). Then again, it is difficult to get into the [generator](generate) code... so if there is something wrong with these, please just report it.

- *lib*-files are an auto-generated definition of CSFML API: `lib CSFML`.
- *obj*-files are auto-generated convenient object and function wrappers.

The idea is that the files *MODULE.cr* are based on the generated files and add patches with desired functionality that is present in SFML but not CSFML, or simply could not be generated automatically.

[Differences between SFML and CrSFML](http://blaxpirit.github.io/crsfml/tutorials/crsfml-differences.html)
