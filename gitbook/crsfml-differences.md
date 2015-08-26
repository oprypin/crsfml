# Differences between SFML and CrSFML

The API of CrSFML (a library for Crystal) attempts to be similar to SFML (a C++ library), but some general changes are present:

- There is a clear separation between "classes" and "structs". Classes are wrapped, and structs are taken directly from `lib`s, making them limited
    - Instead of constructors they have functions in the root of the namespace (do not use `new` with structs!).
    - Because structs are always passed by copy, modifying them can be problematic. For example, `my_struct.x = 7` is fine but `array_of_structs[2].x = 5` will not work. To work around this, copy the whole struct, modify it, then write it back. Better yet, avoid the need to modify structs (work with them like with immutable objects).
- Method names are renamed to `snake_case`.
- To construct an object (`sf::SomeType x(param)`):
    - `x = SF::SomeType.new(param)` for classes.
    - `x = SF.some_type(param)` for structs.
    - Use `SF::Vector2(T)`, `SF.vector2(x, y)` instead of `Vector2(f|i)`. 2-tuples (`{x, y}`) can often be used instead.
        - But: `SF::Vector3f`, `SF.vector3f(x, y, z)`.
    - Member functions, such as `loadFromFile`, that are used for initialization, become class methods (`from_file`).
- Functions that can fail and return `false`/`NULL` raise `SF::NullResult` instead.
- Getter, setter methods are changed:
    - `x.getSomeProperty()` becomes `x.some_property`.
    - `x.isSomeProperty()` becomes `x.some_property?`.
    - `x.setSomeProperty(v)` becomes `x.some_property = v`.
- SFML sometimes uses `enum` values as bitmasks. You can combine them using the `|` operator.
- `enum` names are taken from CSFML (e.g. `CSFML::KeyCode::Slash`), but their values are copied into classes to resemble SFML (e.g. `SF::Keyboard::Slash`).
- Unicode just works (use normal `String`s).
- Type differences:
    - `unsigned int` is mapped as `Int32`, etc., so you don't have to bother with unsigned types. This shouldn't cause problems, but it might.
- Most of the [documentation](http://blaxpirit.github.io/crsfml/api/) is taken directly from CSFML, so don't be surprised if it talks in C/C++ terms.
