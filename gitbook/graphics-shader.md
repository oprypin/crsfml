# Adding special effects with shaders

## Introduction

A shader is a small program that is executed on the graphics card. It provides the programmer with more control over the drawing process and in a more flexible and simple way than using the fixed set of states and operations provided by OpenGL. With this additional flexibility, shaders are used to create effects that would be too complicated, if not impossible, to describe with regular OpenGL functions: Per-pixel lighting, shadows, etc. Today's graphics cards and newer versions of OpenGL are already entirely shader-based, and the fixed set of states and functions (which is called the "fixed pipeline") that you might know of has been deprecated and will likely be removed in the future.

Shaders are written in GLSL (*OpenGL Shading Language*), which is very similar to the C programming language.

There are two types of shaders: vertex shaders and fragment (or pixel) shaders. Vertex shaders are run for each vertex, while fragment shaders are run for every generated fragment (pixel). Depending on what kind of effect you want to achieve, you can provide a vertex shader, a fragment shader, or both.

To understand what shaders do and how to use them efficiently, it is important to understand the basics of the rendering pipeline. You must also learn how to write GLSL programs and find good tutorials and examples to get started. You can also have a look at the "Shader" example that comes with the SFML SDK.

This tutorial will only focus on the CrSFML specific part: Loading and applying your shaders -- not writing them.

## Loading shaders

In CrSFML, shaders are represented by the [Shader]({{book.api}}/Shader.html) class. It handles both the vertex and fragment shaders: A [Shader]({{book.api}}/Shader.html) object is a combination of both (or only one, if the other is not provided).

Even though shaders have become commonplace, there are still old graphics cards that might not support them. The first thing you should do in your program is check if shaders are available on the system:

```ruby
unless SF::Shader.available?
  # shaders are not available...
end
```

Any attempt to use the [Shader]({{book.api}}/Shader.html) class will fail if `SF::Shader.available?` returns `false`.

The most common way of loading a shader is from a file on disk, which is done with the `from_file` class method.

```ruby
# load only the vertex shader
shader = SF::Shader.from_file("vertex_shader.vert", SF::Shader::Vertex)

# load only the fragment shader
shader = SF::Shader.from_file("fragment_shader.frag", SF::Shader::Fragment)

# load both shaders
shader = SF::Shader.from_file("vertex_shader.vert", "fragment_shader.frag")
```

Shader source is contained in simple text files (like your Crystal code). Their extension doesn't really matter, it can be anything you want, you can even omit it. ".vert" and ".frag" are just examples of possible extensions.

The `from_file` class method can sometimes fail with no obvious reason. First, check the error message that SFML prints to the standard output (check the console). If the message is unable to open file, make sure that the *working directory* (which is the directory that any file path will be interpreted relative to) is what you think it is: When you run the application from your desktop environment, the working directory is the executable folder.

Shaders can also be loaded directly from strings, with the `from_memory` class method. This can be useful if you want to embed the shader source directly into your program.

```ruby
vertex_shader = "
    void main()
    {
        ...
    }
"

fragment_shader = "
    void main()
    {
        ...
    }
"

# load only the vertex shader
shader = SF::Shader.from_memory(vertex_shader, SF::Shader::Vertex)

# load only the fragment shader
shader = SF::Shader.from_memory(fragment_shader, SF::Shader::Fragment)

# load both shaders
shader = SF::Shader.from_memory(vertex_shader, fragment_shader)
```

And finally, like all other SFML resources, shaders can also be loaded from a [custom input stream](system-stream.md "Input streams tutorial") with the `from_stream` class method.

If loading fails, don't forget to check the standard error output (the console) to see a detailed report from the GLSL compiler.

## Using a shader

Using a shader is simple, just pass it as an additional argument to the `draw` method.

```ruby
window.draw(whatever, SF.render_states(shader: shader))
```

## Passing variables to a shader

Like any other program, a shader can take parameters so that it is able to behave differently from one draw to another. These parameters are declared as global variables known as *uniforms* in the shader.

```glsl
uniform float myvar;

void main()
{
    // use myvar...
}
```

Uniforms can be set by the Crystal program, using the various overloads of the `set_parameter` method in the [Shader]({{book.api}}/Shader.html) class.

```ruby
shader.set_parameter("my_var", 5.0)
```

`set_parameter`'s overloads support all the types provided by CrSFML:

* `float` (GLSL type `float`)
* 2 `float`s, `SF::Vector2f` (GLSL type `vec2`)
* 3 `float`s, `SF::Vector3f` (GLSL type `vec3`)
* 4 `float`s (GLSL type `vec4`)
* `SF::Color` (GLSL type `vec4`)
* `SF::Transform` (GLSL type `mat4`)
* `SF::Texture` (GLSL type `sampler2D`)

The GLSL compiler optimizes out unused variables (here, "unused" means "not involved in the calculation of the final vertex/pixel"). So don't be surprised if you get error messages such as Failed to find variable "xxx" in shader when you call `set_parameter` during your tests.

## Minimal shaders

You won't learn how to write GLSL shaders here, but it is essential that you know what input SFML provides to the shaders and what it expects you to do with it.

### Vertex shader

SFML has a fixed vertex format which is described by the [Vertex]({{book.api}}/Vertex.html) structure. A SFML vertex contains a 2D position, a color, and 2D texture coordinates. This is the exact input that you will get in the vertex shader, stored in the built-in `gl_Vertex`, `gl_MultiTexCoord0` and `gl_Color` variables (you don't need to declare them).

```glsl
void main()
{
    // transform the vertex position
    gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;

    // transform the texture coordinates
    gl_TexCoord[0] = gl_TextureMatrix[0] * gl_MultiTexCoord0;

    // forward the vertex color
    gl_FrontColor = gl_Color;
}
```

The position usually needs to be transformed by the model-view and projection matrices, which contain the entity transform combined with the current view. The texture coordinates need to be transformed by the texture matrix (this matrix likely doesn't mean anything to you, it is just an SFML implementation detail). And finally, the color just needs to be forwarded. Of course, you can ignore the texture coordinates and/or the color if you don't make use of them.  
All these variables will then be interpolated over the primitive by the graphics card, and passed to the fragment shader.

### Fragment shader

The fragment shader functions quite similarly: It receives the texture coordinates and the color of a generated fragment. There's no position any more, at this point the graphics card has already computed the final raster position of the fragment. However if you deal with textured entities, you'll also need the current texture.

```glsl
uniform sampler2D texture;

void main()
{
    // lookup the pixel in the texture
    vec4 pixel = texture2D(texture, gl_TexCoord[0].xy);

    // multiply it by the color
    gl_FragColor = gl_Color * pixel;
}
```

The current texture is not automatic, you need to treat it like you do the other input variables, and explicitly set it from your C++ program. Since each entity can have a different texture, and worse, there might be no way for you to get it and pass it to the shader, SFML provides a special overload of the `set_parameter` method that does this job for you.

```
shader.set_parameter("texture", SF::Shader::CurrentTexture)
```

This special parameter automatically sets the texture of the entity being drawn to the shader variable with the given name. Every time you draw a new entity, SFML will update the shader texture variable accordingly.

If you want to see nice examples of shaders in action, you can have a look at the Shader example in the SFML SDK.

## Using a SF::Shader with OpenGL code

If you're using OpenGL rather than the graphics entities of SFML, you can still use [Shader]({{book.api}}/Shader.html) as a wrapper around an OpenGL program object and use it within your OpenGL code.

To activate a [Shader]({{book.api}}/Shader.html) for drawing (the equivalent of `glUseProgram`), you have to call the `bind` class method:

```ruby
shader = SF::Shader.new
...

# bind the shader
SF::Shader::bind(shader)

# draw your OpenGL entity here...

# bind no shader
SF::Shader::bind(nil)
```

