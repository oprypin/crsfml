The main way to contribute to *CrSFML* is to use it and report issues.

If you want to contribute code to this project, consider the following:

The files *src/MODULE_lib.cr* (except *common_lib*) and *src/MODULE_obj.cr* (except *common_obj*) are automatically generated. Pull requests that directly change them will not be accepted (the changes would just be lost). Then again, it is difficult to get into the generator code... so if there is something wrong with these, please just report it.

The idea is that the files *MODULE.cr* are based on the generated files and add patches with desired functionality that is present in SFML but not CSFML, or simply could not be generated automatically.
