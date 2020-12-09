Based on https://github.com/SFML/SFML/blob/2.5.1/include/SFML/Graphics

# SF::BlendMode

Blending modes for drawing

`SF::BlendMode` is a struct that represents a blend mode. A blend
mode determines how the colors of an object you draw are
mixed with the colors that are already in the buffer.

The struct is composed of 6 components, each of which has its
own public member variable:

* Color Source Factor (*color_src_factor*)
* Color Destination Factor (*color_dst_factor*)
* Color Blend Equation (*color_equation*)
* Alpha Source Factor (*alpha_src_factor*)
* Alpha Destination Factor (*alpha_dst_factor*)
* Alpha Blend Equation (*alpha_equation*)

The source factor specifies how the pixel you are drawing contributes
to the final color. The destination factor specifies how the pixel
already drawn in the buffer contributes to the final color.

The color channels RGB (red, green, blue; simply referred to as
color) and A (alpha; the transparency) can be treated separately. This
separation can be useful for specific blend modes, but most often you
won't need it and will simply treat the color as a single unit.

The blend factors and equations correspond to their OpenGL equivalents.
In general, the color of the resulting pixel is calculated according
to the following formula (*src* is the color of the source pixel, *dst*
the color of the destination pixel, the other variables correspond to the
public members, with the equations being + or - operators):
```
dst.rgb = color_src_factor * src.rgb (color_equation) color_dst_factor * dst.rgb
dst.a   = alpha_src_factor * src.a   (alpha_equation) alpha_dst_factor * dst.a
```
All factors and colors are represented as floating point numbers between
0 and 1. Where necessary, the result is clamped to fit in that range.

The most common blending modes are defined as constants in the SF module:
`SF::BlendAlpha`, `SF::BlendAdd`, `SF::BlendMultiply`, `SF::BlendNone`.

In SFML, a blend mode can be specified every time you draw a `SF::Drawable`
object to a render target. It is part of the `SF::RenderStates` compound
that is passed to the member function `SF::RenderTarget.draw`().

*See also:* `SF::RenderStates`, `SF::RenderTarget`

## SF::BlendMode::Equation

Enumeration of the blending equations

The equations are mapped directly to their OpenGL equivalents,
specified by gl_blend_equation() or gl_blend_equation_separate().

### SF::BlendMode::Equation::Add

Pixel = Src * SrcFactor + Dst * DstFactor

### SF::BlendMode::Equation::ReverseSubtract

Pixel = Dst * DstFactor - Src * SrcFactor

### SF::BlendMode::Equation::Subtract

Pixel = Src * SrcFactor - Dst * DstFactor

## SF::BlendMode::Factor

Enumeration of the blending factors

The factors are mapped directly to their OpenGL equivalents,
specified by gl_blend_func() or gl_blend_func_separate().

### SF::BlendMode::Factor::DstAlpha

(dst.a, dst.a, dst.a, dst.a)

### SF::BlendMode::Factor::DstColor

(dst.r, dst.g, dst.b, dst.a)

### SF::BlendMode::Factor::One

(1, 1, 1, 1)

### SF::BlendMode::Factor::OneMinusDstAlpha

(1, 1, 1, 1) - (dst.a, dst.a, dst.a, dst.a)

### SF::BlendMode::Factor::OneMinusDstColor

(1, 1, 1, 1) - (dst.r, dst.g, dst.b, dst.a)

### SF::BlendMode::Factor::OneMinusSrcAlpha

(1, 1, 1, 1) - (src.a, src.a, src.a, src.a)

### SF::BlendMode::Factor::OneMinusSrcColor

(1, 1, 1, 1) - (src.r, src.g, src.b, src.a)

### SF::BlendMode::Factor::SrcAlpha

(src.a, src.a, src.a, src.a)

### SF::BlendMode::Factor::SrcColor

(src.r, src.g, src.b, src.a)

### SF::BlendMode::Factor::Zero

(0, 0, 0, 0)

## SF::BlendMode#alpha_dst_factor()

Destination blending factor for the alpha channel

## SF::BlendMode#alpha_equation()

Blending equation for the alpha channel

## SF::BlendMode#alpha_src_factor()

Source blending factor for the alpha channel

## SF::BlendMode#color_dst_factor()

Destination blending factor for the color channels

## SF::BlendMode#color_equation()

Blending equation for the color channels

## SF::BlendMode#color_src_factor()

Source blending factor for the color channels

## SF::BlendMode#initialize()

Default constructor

Constructs a blending mode that does alpha blending.

## SF::BlendMode#initialize(color_source_factor,color_destination_factor,color_blend_equation,alpha_source_factor,alpha_destination_factor,alpha_blend_equation)

Construct the blend mode given the factors and equation.

* *color_source_factor* - Specifies how to compute the source factor for the color channels.
* *color_destination_factor* - Specifies how to compute the destination factor for the color channels.
* *color_blend_equation* - Specifies how to combine the source and destination colors.
* *alpha_source_factor* - Specifies how to compute the source factor.
* *alpha_destination_factor* - Specifies how to compute the destination factor.
* *alpha_blend_equation* - Specifies how to combine the source and destination alphas.

## SF::BlendMode#initialize(copy)

:nodoc:

## SF::BlendMode#initialize(source_factor,destination_factor,blend_equation)

Construct the blend mode given the factors and equation.

This constructor uses the same factors and equation for both
color and alpha components. It also defaults to the Add equation.

* *source_factor* - Specifies how to compute the source factor for the color and alpha channels.
* *destination_factor* - Specifies how to compute the destination factor for the color and alpha channels.
* *blend_equation* - Specifies how to combine the source and destination colors and alpha.

## SF::BlendMode#==(right)

Overload of the == operator

* *left* - Left operand
* *right* - Right operand

*Returns:* True if blending modes are equal, false if they are different

## SF::BlendMode#!=(right)

Overload of the != operator

* *left* - Left operand
* *right* - Right operand

*Returns:* True if blending modes are different, false if they are equal

# SF::CircleShape

Specialized shape representing a circle

This class inherits all the functions of `SF::Transformable`
(position, rotation, scale, bounds, ...) as well as the
functions of `SF::Shape` (outline, color, texture, ...).

Usage example:
```
circle = SF::CircleShape.new
circle.radius = 150
circle.outline_color = SF::Color::Red
circle.outline_thickness = 5
circle.position = {10, 20}
...
window.draw circle
```

Since the graphics card can't draw perfect circles, we have to
fake them with multiple triangles connected to each other. The
"points count" property of `SF::CircleShape` defines how many of these
triangles to use, and therefore defines the quality of the circle.

The number of points can also be used for another purpose; with
small numbers you can create any regular polygon shape:
equilateral triangle, square, pentagon, hexagon, ...

*See also:* `SF::Shape`, `SF::RectangleShape`, `SF::ConvexShape`

## SF::CircleShape#draw(target,states)

:nodoc:

## SF::CircleShape#draw(target,states)

:nodoc:

## SF::CircleShape#draw(target,states)

:nodoc:

## SF::CircleShape#fill_color()

:nodoc:

## SF::CircleShape#fill_color=(color)

:nodoc:

## SF::CircleShape#get_point(index)

Get a point of the circle

The returned point is in local coordinates, that is,
the shape's transforms (position, rotation, scale) are
not taken into account.
The result is undefined if *index* is out of the valid range.

* *index* - Index of the point to get, in range `0 ... point_count`

*Returns:* index-th point of the shape

## SF::CircleShape#global_bounds()

:nodoc:

## SF::CircleShape#initialize(copy)

:nodoc:

## SF::CircleShape#initialize(radius,point_count)

Default constructor

* *radius* - Radius of the circle
* *point_count* - Number of points composing the circle

## SF::CircleShape#inverse_transform()

:nodoc:

## SF::CircleShape#local_bounds()

:nodoc:

## SF::CircleShape#move(offset)

:nodoc:

## SF::CircleShape#move(offset_x,offset_y)

:nodoc:

## SF::CircleShape#origin()

:nodoc:

## SF::CircleShape#origin=(origin)

:nodoc:

## SF::CircleShape#outline_color()

:nodoc:

## SF::CircleShape#outline_color=(color)

:nodoc:

## SF::CircleShape#outline_thickness()

:nodoc:

## SF::CircleShape#outline_thickness=(thickness)

:nodoc:

## SF::CircleShape#point_count()

Get the number of points of the circle

*Returns:* Number of points of the circle

*See also:* `point_count=`

## SF::CircleShape#point_count=(count)

Set the number of points of the circle

* *count* - New number of points of the circle

*See also:* `point_count`

## SF::CircleShape#position()

:nodoc:

## SF::CircleShape#position=(position)

:nodoc:

## SF::CircleShape#radius()

Get the radius of the circle

*Returns:* Radius of the circle

*See also:* `radius=`

## SF::CircleShape#radius=(radius)

Set the radius of the circle

* *radius* - New radius of the circle

*See also:* `radius`

## SF::CircleShape#rotate(angle)

:nodoc:

## SF::CircleShape#rotation()

:nodoc:

## SF::CircleShape#rotation=(angle)

:nodoc:

## SF::CircleShape#scale()

:nodoc:

## SF::CircleShape#scale(factor)

:nodoc:

## SF::CircleShape#scale(factor_x,factor_y)

:nodoc:

## SF::CircleShape#scale=(factors)

:nodoc:

## SF::CircleShape#set_origin(x,y)

:nodoc:

## SF::CircleShape#set_position(x,y)

:nodoc:

## SF::CircleShape#set_scale(factor_x,factor_y)

:nodoc:

## SF::CircleShape#set_texture(texture,reset_rect)

:nodoc:

## SF::CircleShape#texture()

:nodoc:

## SF::CircleShape#texture_rect()

:nodoc:

## SF::CircleShape#texture_rect=(rect)

:nodoc:

## SF::CircleShape#transform()

:nodoc:

# SF::Color

Utility struct for manipulating RGBA colors

`SF::Color` is a simple color struct composed of 4 components:

* Red
* Green
* Blue
* Alpha (opacity)

Each component is a public member, an unsigned integer in
the range `0..255`. Thus, colors can be constructed and
manipulated very easily:

```
color = SF::Color.new(255, 0, 0) # red
color.r = 0                      # make it black
color.b = 128                    # make it dark blue
```

The fourth component of colors, named "alpha", represents
the opacity of the color. A color with an alpha value of
255 will be fully opaque, while an alpha value of 0 will
make a color fully transparent, whatever the value of the
other components is.

The most common colors are already defined as static variables:
```
black       = SF::Color::Black
white       = SF::Color::White
red         = SF::Color::Red
green       = SF::Color::Green
blue        = SF::Color::Blue
yellow      = SF::Color::Yellow
magenta     = SF::Color::Magenta
cyan        = SF::Color::Cyan
transparent = SF::Color::Transparent
```

Colors can also be added and modulated (multiplied) using the
overloaded operators + and *.

## SF::Color#a()

Alpha (opacity) component

## SF::Color#b()

Blue component

## SF::Color#g()

Green component

## SF::Color#initialize()

Default constructor

Constructs an opaque black color. It is equivalent to
`SF::Color`(0, 0, 0, 255).

## SF::Color#initialize(color)

Construct the color from 32-bit unsigned integer

* *color* - Number containing the RGBA components (in that order)

## SF::Color#initialize(copy)

:nodoc:

## SF::Color#initialize(red,green,blue,alpha)

Construct the color from its 4 RGBA components

* *red* - Red component (in the range `0..255`)
* *green* - Green component (in the range `0..255`)
* *blue* - Blue component (in the range `0..255`)
* *alpha* - Alpha (opacity) component (in the range `0..255`)

## SF::Color#r()

Red component

## SF::Color#==(right)

Overload of the == operator

This operator compares two colors and check if they are equal.

* *left* - Left operand
* *right* - Right operand

*Returns:* True if colors are equal, false if they are different

## SF::Color#!=(right)

Overload of the != operator

This operator compares two colors and check if they are different.

* *left* - Left operand
* *right* - Right operand

*Returns:* True if colors are different, false if they are equal

## SF::Color#+(right)

Overload of the binary + operator

This operator returns the component-wise sum of two colors.
Components that exceed 255 are clamped to 255.

* *left* - Left operand
* *right* - Right operand

*Returns:* Result of *left* + *right*

## SF::Color#-(right)

Overload of the binary - operator

This operator returns the component-wise subtraction of two colors.
Components below 0 are clamped to 0.

* *left* - Left operand
* *right* - Right operand

*Returns:* Result of *left* - *right*

## SF::Color#*(right)

Overload of the binary * operator

This operator returns the component-wise multiplication
(also called "modulation") of two colors.
Components are then divided by 255 so that the result is
still in the range `0 .. 255`.

* *left* - Left operand
* *right* - Right operand

*Returns:* Result of *left* * *right*

## SF::Color#to_integer()

Retrieve the color as a 32-bit unsigned integer

*Returns:* Color represented as a 32-bit unsigned integer

# SF::ConvexShape

Specialized shape representing a convex polygon

This class inherits all the functions of `SF::Transformable`
(position, rotation, scale, bounds, ...) as well as the
functions of `SF::Shape` (outline, color, texture, ...).

It is important to keep in mind that a convex shape must
always be... convex, otherwise it may not be drawn correctly.
Moreover, the points must be defined in order; using a random
order would result in an incorrect shape.

Usage example:
```
polygon = SF::ConvexShape.new
polygon.point_count = 3
polygon[0] = SF.vector2f(0, 0)
polygon[1] = SF.vector2f(0, 10)
polygon[2] = SF.vector2f(25, 5)
polygon.outline_color = SF::Color::Red
polygon.outline_thickness = 5
polygon.position = {10, 20}
...
window.draw polygon
```

*See also:* `SF::Shape`, `SF::RectangleShape`, `SF::CircleShape`

## SF::ConvexShape#draw(target,states)

:nodoc:

## SF::ConvexShape#draw(target,states)

:nodoc:

## SF::ConvexShape#draw(target,states)

:nodoc:

## SF::ConvexShape#fill_color()

:nodoc:

## SF::ConvexShape#fill_color=(color)

:nodoc:

## SF::ConvexShape#get_point(index)

Get the position of a point

The returned point is in local coordinates, that is,
the shape's transforms (position, rotation, scale) are
not taken into account.
The result is undefined if *index* is out of the valid range.

* *index* - Index of the point to get, in range `0 ... point_count`

*Returns:* Position of the index-th point of the polygon

*See also:* `point=`

## SF::ConvexShape#global_bounds()

:nodoc:

## SF::ConvexShape#initialize(copy)

:nodoc:

## SF::ConvexShape#initialize(point_count)

Default constructor

* *point_count* - Number of points of the polygon

## SF::ConvexShape#inverse_transform()

:nodoc:

## SF::ConvexShape#local_bounds()

:nodoc:

## SF::ConvexShape#move(offset)

:nodoc:

## SF::ConvexShape#move(offset_x,offset_y)

:nodoc:

## SF::ConvexShape#origin()

:nodoc:

## SF::ConvexShape#origin=(origin)

:nodoc:

## SF::ConvexShape#outline_color()

:nodoc:

## SF::ConvexShape#outline_color=(color)

:nodoc:

## SF::ConvexShape#outline_thickness()

:nodoc:

## SF::ConvexShape#outline_thickness=(thickness)

:nodoc:

## SF::ConvexShape#point_count()

Get the number of points of the polygon

*Returns:* Number of points of the polygon

*See also:* `point_count=`

## SF::ConvexShape#point_count=(count)

Set the number of points of the polygon

*count* must be greater than 2 to define a valid shape.

* *count* - New number of points of the polygon

*See also:* `point_count`

## SF::ConvexShape#position()

:nodoc:

## SF::ConvexShape#position=(position)

:nodoc:

## SF::ConvexShape#rotate(angle)

:nodoc:

## SF::ConvexShape#rotation()

:nodoc:

## SF::ConvexShape#rotation=(angle)

:nodoc:

## SF::ConvexShape#scale()

:nodoc:

## SF::ConvexShape#scale(factor)

:nodoc:

## SF::ConvexShape#scale(factor_x,factor_y)

:nodoc:

## SF::ConvexShape#scale=(factors)

:nodoc:

## SF::ConvexShape#set_origin(x,y)

:nodoc:

## SF::ConvexShape#set_point(index,point)

Set the position of a point

Don't forget that the polygon must remain convex, and
the points need to stay ordered!
point_count= must be called first in order to set the total
number of points. The result is undefined if *index* is out
of the valid range.

* *index* - Index of the point to change, in range `0 ... point_count`
* *point* - New position of the point

*See also:* `point`

## SF::ConvexShape#set_position(x,y)

:nodoc:

## SF::ConvexShape#set_scale(factor_x,factor_y)

:nodoc:

## SF::ConvexShape#set_texture(texture,reset_rect)

:nodoc:

## SF::ConvexShape#texture()

:nodoc:

## SF::ConvexShape#texture_rect()

:nodoc:

## SF::ConvexShape#texture_rect=(rect)

:nodoc:

## SF::ConvexShape#transform()

:nodoc:

# SF::Drawable

Abstract module for objects that can be drawn
to a render target

`SF::Drawable` is a very simple module that allows objects
of derived classes to be drawn to a `SF::RenderTarget`.

All you have to do in your derived class is to implement the
`draw` function.

Note that including `SF::Drawable` is not mandatory,
but it allows this nice syntax `window.draw(object)` rather
than `object.draw(window)`, which is more consistent with other
SFML classes.

Example:
```
class MyDrawable
  include SF::Drawable
  def draw(target : SF::RenderTarget, states : SF::RenderStates)
    # You can draw other high-level objects
    target.draw(@sprite, states)

    # ... or use the low-level API
    states.texture = @texture
    target.draw(@vertices, states)

    # ... or draw with OpenGL directly
    glBegin(GL_QUADS)
    ...
    glEnd()
  end

  @sprite : SF::Sprite
  @texture : SF::Texture
  @vertices : SF::VertexArray
end
```

*See also:* `SF::RenderTarget`

# SF::Font

Class for loading and manipulating character fonts

Fonts can be loaded from a file, from memory or from a custom
stream, and supports the most common types of fonts. See
the load_from_file function for the complete list of supported formats.

Once it is loaded, a `SF::Font` instance provides three
types of information about the font:

* Global metrics, such as the line spacing
* Per-glyph metrics, such as bounding box or kerning
* Pixel representation of glyphs

Fonts alone are not very useful: they hold the font data
but cannot make anything useful of it. To do so you need to
use the `SF::Text` class, which is able to properly output text
with several options such as character size, style, color,
position, rotation, etc.
This separation allows more flexibility and better performances:
indeed a `SF::Font` is a heavy resource, and any operation on it
is slow (often too slow for real-time applications). On the other
side, a `SF::Text` is a lightweight object which can combine the
glyphs data and metrics of a `SF::Font` to display any text on a
render target.
Note that it is also possible to bind several `SF::Text` instances
to the same `SF::Font`.

It is important to note that the `SF::Text` instance doesn't
copy the font that it uses, it only keeps a reference to it.
Thus, a `SF::Font` must not be destructed while it is
used by a `SF::Text` (i.e. never write a function that
uses a local `SF::Font` instance for creating a text).

Usage example:
```
# Load a new font from file
font = SF::Font.from_file("arial.ttf")

# Create a text which uses our font
text1 = SF::Text.new("text", font, 30)

# Create another text using the same font, but with different parameters
text2 = SF::Text.new
text2.font = font
text2.character_size = 50
text2.style = SF::Text::Italic
```

Apart from loading font files, and passing them to instances
of `SF::Text`, you should normally not have to deal directly
with this class. However, it may be useful to access the
font metrics or rasterized glyphs for advanced usage.

Note that if the font is a bitmap font, it is not scalable,
thus not all requested sizes will be available to use. This
needs to be taken into consideration when using `SF::Text`.
If you need to display text of a certain size, make sure the
corresponding bitmap font that supports that size is used.

*See also:* `SF::Text`

## SF::Font::Info

Holds various information about a font

### SF::Font::Info#family()

The font family

### SF::Font::Info#initialize(copy)

:nodoc:

## SF::Font#finalize()

Destructor

Cleans up all the internal resources used by the font

## SF::Font#get_glyph(code_point,character_size,bold,outline_thickness)

Retrieve a glyph of the font

If the font is a bitmap font, not all character sizes
might be available. If the glyph is not available at the
requested size, an empty glyph is returned.

Be aware that using a negative value for the outline
thickness will cause distorted rendering.

* *code_point* - Unicode code point of the character to get
* *character_size* - Reference character size
* *bold* - Retrieve the bold version or the regular one?
* *outline_thickness* - Thickness of outline (when != 0 the glyph will not be filled)

*Returns:* The glyph corresponding to *code_point* and *character_size*

## SF::Font#get_kerning(first,second,character_size)

Get the kerning offset of two glyphs

The kerning is an extra offset (negative) to apply between two
glyphs when rendering them, to make the pair look more "natural".
For example, the pair "AV" have a special kerning to make them
closer than other characters. Most of the glyphs pairs have a
kerning offset of zero, though.

* *first* - Unicode code point of the first character
* *second* - Unicode code point of the second character
* *character_size* - Reference character size

*Returns:* Kerning value for *first* and *second,* in pixels

## SF::Font#get_line_spacing(character_size)

Get the line spacing

Line spacing is the vertical offset to apply between two
consecutive lines of text.

* *character_size* - Reference character size

*Returns:* Line spacing, in pixels

## SF::Font#get_texture(character_size)

Retrieve the texture containing the loaded glyphs of a certain size

The contents of the returned texture changes as more glyphs
are requested, thus it is not very relevant. It is mainly
used internally by `SF::Text`.

* *character_size* - Reference character size

*Returns:* Texture containing the glyphs of the requested size

## SF::Font#get_underline_position(character_size)

Get the position of the underline

Underline position is the vertical offset to apply between the
baseline and the underline.

* *character_size* - Reference character size

*Returns:* Underline position, in pixels

*See also:* `underline_thickness`

## SF::Font#get_underline_thickness(character_size)

Get the thickness of the underline

Underline thickness is the vertical size of the underline.

* *character_size* - Reference character size

*Returns:* Underline thickness, in pixels

*See also:* `underline_position`

## SF::Font#info()

Get the font information

*Returns:* A structure that holds the font information

## SF::Font#initialize()

Default constructor

This constructor defines an empty font

## SF::Font#initialize(copy)

:nodoc:

## SF::Font#load_from_file(filename)

Load the font from a file

The supported font formats are: TrueType, Type 1, CFF,
OpenType, SFNT, X11 PCF, Windows FNT, BDF, PFR and Type 42.
Note that this function knows nothing about the standard
fonts installed on the user's system, thus you can't
load them directly.

*Warning:* SFML cannot preload all the font data in this
function, so the file has to remain accessible until
the `SF::Font` object loads a new font or is destroyed.

* *filename* - Path of the font file to load

*Returns:* True if loading succeeded, false if it failed

*See also:* `load_from_memory`, `load_from_stream`

## SF::Font#load_from_memory(data)

Load the font from a file in memory

The supported font formats are: TrueType, Type 1, CFF,
OpenType, SFNT, X11 PCF, Windows FNT, BDF, PFR and Type 42.

*Warning:* SFML cannot preload all the font data in this
function, so the buffer pointed by *data* has to remain
valid until the `SF::Font` object loads a new font or
is destroyed.

* *data* - Slice containing the file data in memory

*Returns:* True if loading succeeded, false if it failed

*See also:* `load_from_file`, `load_from_stream`

## SF::Font#load_from_stream(stream)

Load the font from a custom stream

The supported font formats are: TrueType, Type 1, CFF,
OpenType, SFNT, X11 PCF, Windows FNT, BDF, PFR and Type 42.
Warning: SFML cannot preload all the font data in this
function, so the contents of *stream* have to remain
valid as long as the font is used.

*Warning:* SFML cannot preload all the font data in this
function, so the stream has to remain accessible until
the `SF::Font` object loads a new font or is destroyed.

* *stream* - Source stream to read from

*Returns:* True if loading succeeded, false if it failed

*See also:* `load_from_file`, `load_from_memory`

# SF::Glyph

Structure describing a glyph

A glyph is the visual representation of a character.

The `SF::Glyph` structure provides the information needed
to handle the glyph:

* its coordinates in the font's texture
* its bounding rectangle
* the offset to apply to get the starting position of the next glyph

*See also:* `SF::Font`

## SF::Glyph#advance()

Offset to move horizontally to the next character

## SF::Glyph#bounds()

Bounding rectangle of the glyph, in coordinates relative to the baseline

## SF::Glyph#initialize()

Default constructor

## SF::Glyph#initialize(copy)

:nodoc:

## SF::Glyph#texture_rect()

Texture coordinates of the glyph inside the font's texture

# SF::Image

Class for loading, manipulating and saving images

`SF::Image` is an abstraction to manipulate images
as bidimensional arrays of pixels. The class provides
functions to load, read, write and save pixels, as well
as many other useful functions.

`SF::Image` can handle a unique internal representation of
pixels, which is RGBA 32 bits. This means that a pixel
must be composed of 8 bits red, green, blue and alpha
channels -- just like a `SF::Color`.
All the functions that return an array of pixels follow
this rule, and all parameters that you pass to `SF::Image`
functions (such as load_from_memory) must use this
representation as well.

A `SF::Image` can be copied, but it is a heavy resource and
if possible you should always use [const] references to
pass or return them to avoid useless copies.

Usage example:
```
# Load an image file from a file
background = SF::Image.from_file("background.jpg")

# Create a 20x20 image filled with black color
image = SF::Image.new(20, 20, SF::Color::Black)

# Copy image1 on image2 at position (10, 10)
image.copy(background, 10, 10)

# Make the top-left pixel transparent
color = image.get_pixel(0, 0)
color.a = 128
image.set_pixel(0, 0, color)

# Save the image to a file
image.save_to_file("result.png") || error
```

*See also:* `SF::Texture`

## SF::Image#copy(source,dest_x,dest_y,source_rect,apply_alpha)

Copy pixels from another image onto this one

This function does a slow pixel copy and should not be
used intensively. It can be used to prepare a complex
static image from several others, but if you need this
kind of feature in real-time you'd better use `SF::RenderTexture`.

If *source_rect* is empty, the whole image is copied.
If *apply_alpha* is set to true, the transparency of
source pixels is applied. If it is false, the pixels are
copied unchanged with their alpha value.

* *source* - Source image to copy
* *dest_x* - X coordinate of the destination position
* *dest_y* - Y coordinate of the destination position
* *source_rect* - Sub-rectangle of the source image to copy
* *apply_alpha* - Should the copy take into account the source transparency?

## SF::Image#create(width,height,color)

Create the image and fill it with a unique color

* *width* - Width of the image
* *height* - Height of the image
* *color* - Fill color

## SF::Image#create(width,height,pixels)

Create the image from an array of pixels

The *pixel* array is assumed to contain 32-bits RGBA pixels,
and have the given *width* and *height.* If not, this is
an undefined behavior.
If *pixels* is null, an empty image is created.

* *width* - Width of the image
* *height* - Height of the image
* *pixels* - Array of pixels to copy to the image

## SF::Image#create_mask_from_color(color,alpha)

Create a transparency mask from a specified color-key

This function sets the alpha value of every pixel matching
the given color to *alpha* (0 by default), so that they
become transparent.

* *color* - Color to make transparent
* *alpha* - Alpha value to assign to transparent pixels

## SF::Image#finalize()

Destructor

## SF::Image#flip_horizontally()

Flip the image horizontally (left &lt;-&gt; right)

## SF::Image#flip_vertically()

Flip the image vertically (top &lt;-&gt; bottom)

## SF::Image#get_pixel(x,y)

Get the color of a pixel

This function doesn't check the validity of the pixel
coordinates, using out-of-range values will result in
an undefined behavior.

* *x* - X coordinate of pixel to get
* *y* - Y coordinate of pixel to get

*Returns:* Color of the pixel at coordinates (x, y)

*See also:* `pixel=`

## SF::Image#initialize()

Default constructor

Creates an empty image.

## SF::Image#initialize(copy)

:nodoc:

## SF::Image#load_from_file(filename)

Load the image from a file on disk

The supported image formats are bmp, png, tga, jpg, gif,
psd, hdr and pic. Some format options are not supported,
like progressive jpeg.
If this function fails, the image is left unchanged.

* *filename* - Path of the image file to load

*Returns:* True if loading was successful

*See also:* `load_from_memory`, `load_from_stream`, `save_to_file`

## SF::Image#load_from_memory(data)

Load the image from a file in memory

The supported image formats are bmp, png, tga, jpg, gif,
psd, hdr and pic. Some format options are not supported,
like progressive jpeg.
If this function fails, the image is left unchanged.

* *data* - Slice containing the file data in memory

*Returns:* True if loading was successful

*See also:* `load_from_file`, `load_from_stream`

## SF::Image#load_from_stream(stream)

Load the image from a custom stream

The supported image formats are bmp, png, tga, jpg, gif,
psd, hdr and pic. Some format options are not supported,
like progressive jpeg.
If this function fails, the image is left unchanged.

* *stream* - Source stream to read from

*Returns:* True if loading was successful

*See also:* `load_from_file`, `load_from_memory`

## SF::Image#pixels_ptr()

Get a read-only pointer to the array of pixels

The returned value points to an array of RGBA pixels made of
8 bits integers components. The size of the array is
width * height * 4 (size().x * size().y * 4).
Warning: the returned pointer may become invalid if you
modify the image, so you should never store it for too long.
If the image is empty, a null pointer is returned.

*Returns:* Read-only pointer to the array of pixels

## SF::Image#save_to_file(filename)

Save the image to a file on disk

The format of the image is automatically deduced from
the extension. The supported image formats are bmp, png,
tga and jpg. The destination file is overwritten
if it already exists. This function fails if the image is empty.

* *filename* - Path of the file to save

*Returns:* True if saving was successful

*See also:* `create`, `load_from_file`, `load_from_memory`

## SF::Image#set_pixel(x,y,color)

Change the color of a pixel

This function doesn't check the validity of the pixel
coordinates, using out-of-range values will result in
an undefined behavior.

* *x* - X coordinate of pixel to change
* *y* - Y coordinate of pixel to change
* *color* - New color of the pixel

*See also:* `pixel`

## SF::Image#size()

Return the size (width and height) of the image

*Returns:* Size of the image, in pixels

# SF::PrimitiveType

Types of primitives that a `SF::VertexArray` can render

Points and lines have no area, therefore their thickness
will always be 1 pixel, regardless the current transform
and view.

## SF::PrimitiveType::LineStrip

List of connected lines, a point uses the previous point to form a line

## SF::PrimitiveType::Lines

List of individual lines

## SF::PrimitiveType::LinesStrip

DEPRECATED: Use LineStrip instead

## SF::PrimitiveType::Points

List of individual points

## SF::PrimitiveType::Quads

List of individual quads (deprecated, don't work with OpenGL ES)

## SF::PrimitiveType::TriangleFan

List of connected triangles, a point uses the common center and the previous point to form a triangle

## SF::PrimitiveType::TriangleStrip

List of connected triangles, a point uses the two previous points to form a triangle

## SF::PrimitiveType::Triangles

List of individual triangles

## SF::PrimitiveType::TrianglesFan

DEPRECATED: Use TriangleFan instead

## SF::PrimitiveType::TrianglesStrip

DEPRECATED: Use TriangleStrip instead

# SF::RectangleShape

Specialized shape representing a rectangle

This class inherits all the functions of `SF::Transformable`
(position, rotation, scale, bounds, ...) as well as the
functions of `SF::Shape` (outline, color, texture, ...).

Usage example:
```
rectangle = SF::RectangleShape.new
rectangle.size = SF.vector2f(100, 50)
rectangle.outline_color = SF::Color::Red
rectangle.outline_thickness = 5
rectangle.position = {10, 20}
...
window.draw rectangle
```

*See also:* `SF::Shape`, `SF::CircleShape`, `SF::ConvexShape`

## SF::RectangleShape#draw(target,states)

:nodoc:

## SF::RectangleShape#draw(target,states)

:nodoc:

## SF::RectangleShape#draw(target,states)

:nodoc:

## SF::RectangleShape#fill_color()

:nodoc:

## SF::RectangleShape#fill_color=(color)

:nodoc:

## SF::RectangleShape#get_point(index)

Get a point of the rectangle

The returned point is in local coordinates, that is,
the shape's transforms (position, rotation, scale) are
not taken into account.
The result is undefined if *index* is out of the valid range.

* *index* - Index of the point to get, in range `0..3`

*Returns:* index-th point of the shape

## SF::RectangleShape#global_bounds()

:nodoc:

## SF::RectangleShape#initialize(copy)

:nodoc:

## SF::RectangleShape#initialize(size)

Default constructor

* *size* - Size of the rectangle

## SF::RectangleShape#inverse_transform()

:nodoc:

## SF::RectangleShape#local_bounds()

:nodoc:

## SF::RectangleShape#move(offset)

:nodoc:

## SF::RectangleShape#move(offset_x,offset_y)

:nodoc:

## SF::RectangleShape#origin()

:nodoc:

## SF::RectangleShape#origin=(origin)

:nodoc:

## SF::RectangleShape#outline_color()

:nodoc:

## SF::RectangleShape#outline_color=(color)

:nodoc:

## SF::RectangleShape#outline_thickness()

:nodoc:

## SF::RectangleShape#outline_thickness=(thickness)

:nodoc:

## SF::RectangleShape#point_count()

Get the number of points defining the shape

*Returns:* Number of points of the shape. For rectangle
shapes, this number is always 4.

## SF::RectangleShape#position()

:nodoc:

## SF::RectangleShape#position=(position)

:nodoc:

## SF::RectangleShape#rotate(angle)

:nodoc:

## SF::RectangleShape#rotation()

:nodoc:

## SF::RectangleShape#rotation=(angle)

:nodoc:

## SF::RectangleShape#scale()

:nodoc:

## SF::RectangleShape#scale(factor)

:nodoc:

## SF::RectangleShape#scale(factor_x,factor_y)

:nodoc:

## SF::RectangleShape#scale=(factors)

:nodoc:

## SF::RectangleShape#set_origin(x,y)

:nodoc:

## SF::RectangleShape#set_position(x,y)

:nodoc:

## SF::RectangleShape#set_scale(factor_x,factor_y)

:nodoc:

## SF::RectangleShape#set_texture(texture,reset_rect)

:nodoc:

## SF::RectangleShape#size()

Get the size of the rectangle

*Returns:* Size of the rectangle

*See also:* `size=`

## SF::RectangleShape#size=(size)

Set the size of the rectangle

* *size* - New size of the rectangle

*See also:* `size`

## SF::RectangleShape#texture()

:nodoc:

## SF::RectangleShape#texture_rect()

:nodoc:

## SF::RectangleShape#texture_rect=(rect)

:nodoc:

## SF::RectangleShape#transform()

:nodoc:

# SF::RenderStates

Define the states used for drawing to a RenderTarget

There are four global states that can be applied to
the drawn objects:

* the blend mode: how pixels of the object are blended with the background
* the transform: how the object is positioned/rotated/scaled
* the texture: what image is mapped to the object
* the shader: what custom effect is applied to the object

High-level objects such as sprites or text force some of
these states when they are drawn. For example, a sprite
will set its own texture, so that you don't have to care
about it when drawing the sprite.

The transform is a special case: sprites, texts and shapes
(and it's a good idea to do it with your own drawable classes
too) combine their transform with the one that is passed in the
RenderStates structure. So that you can use a "global" transform
on top of each object's transform.

Most objects, especially high-level drawables, can be drawn
directly without defining render states explicitly -- the
default set of states is OK in most cases.
```
window.draw(sprite)
```

If you want to use a single specific render state, for example a
shader, you can pass it to the constructor of `SF::RenderStates`.
```
window.draw(sprite, SF::RenderStates.new(shader))
```

When you're inside the Draw function of a drawable
object (one that includes `SF::Drawable`), you can
either pass the render states unmodified, or change
some of them.
For example, a transformable object will combine the
current transform with its own transform. A sprite will
set its texture. Etc.

*See also:* `SF::RenderTarget`, `SF::Drawable`

## SF::RenderStates#blend_mode()

Blending mode

## SF::RenderStates#initialize()

Default constructor

Constructing a default set of render states is equivalent
to using `SF::RenderStates::Default`.
The default set defines:

* the BlendAlpha blend mode
* the identity transform
* a null texture
* a null shader

## SF::RenderStates#initialize(blend_mode)

Construct a default set of render states with a custom blend mode

* *blend_mode* - Blend mode to use

## SF::RenderStates#initialize(blend_mode,transform,texture,shader)

Construct a set of render states with all its attributes

* *blend_mode* - Blend mode to use
* *transform* - Transform to use
* *texture* - Texture to use
* *shader* - Shader to use

## SF::RenderStates#initialize(copy)

:nodoc:

## SF::RenderStates#initialize(shader)

Construct a default set of render states with a custom shader

* *shader* - Shader to use

## SF::RenderStates#initialize(texture)

Construct a default set of render states with a custom texture

* *texture* - Texture to use

## SF::RenderStates#initialize(transform)

Construct a default set of render states with a custom transform

* *transform* - Transform to use

## SF::RenderStates#shader()

Shader

## SF::RenderStates#texture()

Texture

## SF::RenderStates#transform()

Transform

# SF::RenderTarget

Base module for all render targets (window, texture, ...)

`SF::RenderTarget` defines the common behavior of all the
2D render targets usable in the graphics module. It makes
it possible to draw 2D entities like sprites, shapes, text
without using any OpenGL command directly.

A `SF::RenderTarget` is also able to use views (`SF::View`),
which are a kind of 2D cameras. With views you can globally
scroll, rotate or zoom everything that is drawn,
without having to transform every single entity. See the
documentation of `SF::View` for more details and sample pieces of
code about this module.

On top of that, render targets are still able to render direct
OpenGL stuff. It is even possible to mix together OpenGL calls
and regular SFML drawing commands. When doing so, make sure that
OpenGL states are not messed up by calling the
push_gl_states/pop_gl_states functions.

*See also:* `SF::RenderWindow`, `SF::RenderTexture`, `SF::View`

## SF::RenderTarget#active=(active)

Activate or deactivate the render target for rendering

This function makes the render target's context current for
future OpenGL rendering operations (so you shouldn't care
about it if you're not doing direct OpenGL stuff).
A render target's context is active only on the current thread,
if you want to make it active on another thread you have
to deactivate it on the previous thread first if it was active.
Only one context can be current in a thread, so if you
want to draw OpenGL geometry to another render target
don't forget to activate it again. Activating a render
target will automatically deactivate the previously active
context (if any).

* *active* - True to activate, false to deactivate

*Returns:* True if operation was successful, false otherwise

## SF::RenderTarget#clear(color)

Clear the entire target with a single color

This function is usually called once every frame,
to clear the previous contents of the target.

* *color* - Fill color to use to clear the render target

## SF::RenderTarget#default_view()

Get the default view of the render target

The default view has the initial size of the render target,
and never changes after the target has been created.

*Returns:* The default view of the render target

*See also:* `view=`, `view`

## SF::RenderTarget#draw(vertex_buffer,first_vertex,vertex_count,states)

Draw primitives defined by a vertex buffer

* *vertex_buffer* - Vertex buffer
* *first_vertex* - Index of the first vertex to render
* *vertex_count* - Number of vertices to render
* *states* - Render states to use for drawing

## SF::RenderTarget#draw(vertex_buffer,states)

Draw primitives defined by a vertex buffer

* *vertex_buffer* - Vertex buffer
* *states* - Render states to use for drawing

## SF::RenderTarget#draw(vertices,type,states)

Draw primitives defined by an array of vertices

* *vertices* - Pointer to the vertices
* *vertex_count* - Number of vertices in the array
* *type* - Type of primitives to draw
* *states* - Render states to use for drawing

## SF::RenderTarget#get_viewport(view)

Get the viewport of a view, applied to this render target

The viewport is defined in the view as a ratio, this function
simply applies this ratio to the current dimensions of the
render target to calculate the pixels rectangle that the viewport
actually covers in the target.

* *view* - The view for which we want to compute the viewport

*Returns:* Viewport rectangle, expressed in pixels

## SF::RenderTarget#map_coords_to_pixel(point)

Convert a point from world coordinates to target
coordinates, using the current view

This function is an overload of the map_coords_to_pixel
function that implicitly uses the current view.
It is equivalent to:
```
target.map_coords_to_pixel(point, target.view)
```

* *point* - Point to convert

*Returns:* The converted point, in target coordinates (pixels)

*See also:* `map_pixel_to_coords`

## SF::RenderTarget#map_coords_to_pixel(point,view)

Convert a point from world coordinates to target coordinates

This function finds the pixel of the render target that matches
the given 2D point. In other words, it goes through the same process
as the graphics card, to compute the final position of a rendered point.

Initially, both coordinate systems (world units and target pixels)
match perfectly. But if you define a custom view or resize your
render target, this assertion is not true anymore, i.e. a point
located at (150, 75) in your 2D world may map to the pixel
(10, 50) of your render target -- if the view is translated by (140, 25).

This version uses a custom view for calculations, see the other
overload of the function if you want to use the current view of the
render target.

* *point* - Point to convert
* *view* - The view to use for converting the point

*Returns:* The converted point, in target coordinates (pixels)

*See also:* `map_pixel_to_coords`

## SF::RenderTarget#map_pixel_to_coords(point)

Convert a point from target coordinates to world
coordinates, using the current view

This function is an overload of the map_pixel_to_coords
function that implicitly uses the current view.
It is equivalent to:
```
target.map_pixel_to_coords(point, target.view)
```

* *point* - Pixel to convert

*Returns:* The converted point, in "world" coordinates

*See also:* `map_coords_to_pixel`

## SF::RenderTarget#map_pixel_to_coords(point,view)

Convert a point from target coordinates to world coordinates

This function finds the 2D position that matches the
given pixel of the render target. In other words, it does
the inverse of what the graphics card does, to find the
initial position of a rendered pixel.

Initially, both coordinate systems (world units and target pixels)
match perfectly. But if you define a custom view or resize your
render target, this assertion is not true anymore, i.e. a point
located at (10, 50) in your render target may map to the point
(150, 75) in your 2D world -- if the view is translated by (140, 25).

For render-windows, this function is typically used to find
which point (or object) is located below the mouse cursor.

This version uses a custom view for calculations, see the other
overload of the function if you want to use the current view of the
render target.

* *point* - Pixel to convert
* *view* - The view to use for converting the point

*Returns:* The converted point, in "world" units

*See also:* `map_coords_to_pixel`

## SF::RenderTarget#pop_gl_states()

Restore the previously saved OpenGL render states and matrices

See the description of push_gl_states to get a detailed
description of these functions.

*See also:* `push_gl_states`

## SF::RenderTarget#push_gl_states()

Save the current OpenGL render states and matrices

This function can be used when you mix SFML drawing
and direct OpenGL rendering. Combined with pop_gl_states,
it ensures that:

* SFML's internal states are not messed up by your OpenGL code
* your OpenGL states are not modified by a call to a SFML function

More specifically, it must be used around code that
calls Draw functions. Example:
```
# OpenGL code here...
window.push_gl_states()
window.draw(...)
window.draw(...)
window.pop_gl_states()
# OpenGL code here...
```

Note that this function is quite expensive: it saves all the
possible OpenGL states and matrices, even the ones you
don't care about. Therefore it should be used wisely.
It is provided for convenience, but the best results will
be achieved if you handle OpenGL states yourself (because
you know which states have really changed, and need to be
saved and restored). Take a look at the reset_gl_states
function if you do so.

*See also:* `pop_gl_states`

## SF::RenderTarget#reset_gl_states()

Reset the internal OpenGL states so that the target is ready for drawing

This function can be used when you mix SFML drawing
and direct OpenGL rendering, if you choose not to use
push_gl_states/pop_gl_states. It makes sure that all OpenGL
states needed by SFML are set, so that subsequent draw()
calls will work as expected.

Example:
```
# OpenGL code here...
glPushAttrib(...)
window.reset_gl_states()
window.draw(...)
window.draw(...)
glPopAttrib(...)
# OpenGL code here...
```

## SF::RenderTarget#size()

Return the size of the rendering region of the target

*Returns:* Size in pixels

## SF::RenderTarget#view()

Get the view currently in use in the render target

*Returns:* The view object that is currently used

*See also:* `view=`, `default_view`

## SF::RenderTarget#view=(view)

Change the current active view

The view is like a 2D camera, it controls which part of
the 2D scene is visible, and how it is viewed in the
render target.
The new view will affect everything that is drawn, until
another view is set.
The render target keeps its own copy of the view object,
so it is not necessary to keep the original one alive
after calling this function.
To restore the original view of the target, you can pass
the result of default_view() to this function.

* *view* - New view to use

*See also:* `view`, `default_view`

# SF::RenderTexture

Target for off-screen 2D rendering into a texture

`SF::RenderTexture` is the little brother of `SF::RenderWindow`.
It implements the same 2D drawing and OpenGL-related functions
(see their base class `SF::RenderTarget` for more details),
the difference is that the result is stored in an off-screen
texture rather than being show in a window.

Rendering to a texture can be useful in a variety of situations:

* precomputing a complex static texture (like a level's background from multiple tiles)
* applying post-effects to the whole scene with shaders
* creating a sprite from a 3D object rendered with OpenGL
* etc.

Usage example:

```
# Create a new render-window
window = SF::RenderWindow.new(SF::VideoMode.new(800, 600), "SFML window")

# Create a new render-texture
texture = SF::RenderTexture.new(500, 500)

# The main loop
while window.open?
  # Event processing
  # ...

  # Clear the whole texture with red color
  texture.clear(SF::Color::Red)

  # Draw stuff to the texture
  texture.draw(sprite)  # sprite is a SF::Sprite
  texture.draw(shape)   # shape is a SF::Shape
  texture.draw(text)    # text is a SF::Text

  # We're done drawing to the texture
  texture.display()

  # Now we start rendering to the window, clear it first
  window.clear()

  # Draw the texture
  sprite = SF::Sprite(texture.texture)
  window.draw(sprite)

  # End the current frame and display its contents on screen
  window.display()
end
```

Like `SF::RenderWindow`, `SF::RenderTexture` is still able to render direct
OpenGL stuff. It is even possible to mix together OpenGL calls
and regular SFML drawing commands. If you need a depth buffer for
3D rendering, don't forget to request it when calling RenderTexture.create.

*See also:* `SF::RenderTarget`, `SF::RenderWindow`, `SF::View`, `SF::Texture`

## SF::RenderTexture#active=(active)

Activate or deactivate the render-texture for rendering

This function makes the render-texture's context current for
future OpenGL rendering operations (so you shouldn't care
about it if you're not doing direct OpenGL stuff).
Only one context can be current in a thread, so if you
want to draw OpenGL geometry to another render target
(like a RenderWindow) don't forget to activate it again.

* *active* - True to activate, false to deactivate

*Returns:* True if operation was successful, false otherwise

## SF::RenderTexture#clear(color)

:nodoc:

## SF::RenderTexture#create(width,height,depth_buffer)

Create the render-texture

Before calling this function, the render-texture is in
an invalid state, thus it is mandatory to call it before
doing anything with the render-texture.
The last parameter, *depth_buffer,* is useful if you want
to use the render-texture for 3D OpenGL rendering that requires
a depth buffer. Otherwise it is unnecessary, and you should
leave this parameter to false (which is its default value).

* *width* - Width of the render-texture
* *height* - Height of the render-texture
* *depth_buffer* - Do you want this render-texture to have a depth buffer?

*Returns:* True if creation has been successful

DEPRECATED: Use create(unsigned int, unsigned int, const ContextSettings&) instead.

## SF::RenderTexture#create(width,height,settings)

Create the render-texture

Before calling this function, the render-texture is in
an invalid state, thus it is mandatory to call it before
doing anything with the render-texture.
The last parameter, *settings,* is useful if you want to enable
multi-sampling or use the render-texture for OpenGL rendering that
requires a depth or stencil buffer. Otherwise it is unnecessary, and
you should leave this parameter at its default value.

* *width* - Width of the render-texture
* *height* - Height of the render-texture
* *settings* - Additional settings for the underlying OpenGL texture and context

*Returns:* True if creation has been successful

## SF::RenderTexture#default_view()

:nodoc:

## SF::RenderTexture#display()

Update the contents of the target texture

This function updates the target texture with what
has been drawn so far. Like for windows, calling this
function is mandatory at the end of rendering. Not calling
it may leave the texture in an undefined state.

## SF::RenderTexture#draw(vertex_buffer,first_vertex,vertex_count,states)

:nodoc:

## SF::RenderTexture#draw(vertex_buffer,states)

:nodoc:

## SF::RenderTexture#draw(vertices,type,states)

:nodoc:

## SF::RenderTexture#finalize()

Destructor

## SF::RenderTexture#generate_mipmap()

Generate a mipmap using the current texture data

This function is similar to Texture.generate_mipmap and operates
on the texture used as the target for drawing.
Be aware that any draw operation may modify the base level image data.
For this reason, calling this function only makes sense after all
drawing is completed and display has been called. Not calling display
after subsequent drawing will lead to undefined behavior if a mipmap
had been previously generated.

*Returns:* True if mipmap generation was successful, false if unsuccessful

## SF::RenderTexture#get_viewport(view)

:nodoc:

## SF::RenderTexture#initialize()

Default constructor

Constructs an empty, invalid render-texture. You must
call create to have a valid render-texture.

*See also:* `create`

## SF::RenderTexture#map_coords_to_pixel(point)

:nodoc:

## SF::RenderTexture#map_coords_to_pixel(point,view)

:nodoc:

## SF::RenderTexture#map_pixel_to_coords(point)

:nodoc:

## SF::RenderTexture#map_pixel_to_coords(point,view)

:nodoc:

## SF::RenderTexture.maximum_antialiasing_level()

Get the maximum anti-aliasing level supported by the system

*Returns:* The maximum anti-aliasing level supported by the system

## SF::RenderTexture#pop_gl_states()

:nodoc:

## SF::RenderTexture#push_gl_states()

:nodoc:

## SF::RenderTexture#repeated?()

Tell whether the texture is repeated or not

*Returns:* True if texture is repeated

*See also:* `repeated=`

## SF::RenderTexture#repeated=(repeated)

Enable or disable texture repeating

This function is similar to Texture.repeated=.
This parameter is disabled by default.

* *repeated* - True to enable repeating, false to disable it

*See also:* `repeated?`

## SF::RenderTexture#reset_gl_states()

:nodoc:

## SF::RenderTexture#size()

Return the size of the rendering region of the texture

The returned value is the size that you passed to
the create function.

*Returns:* Size in pixels

## SF::RenderTexture#smooth?()

Tell whether the smooth filtering is enabled or not

*Returns:* True if texture smoothing is enabled

*See also:* `smooth=`

## SF::RenderTexture#smooth=(smooth)

Enable or disable texture smoothing

This function is similar to Texture.smooth=.
This parameter is disabled by default.

* *smooth* - True to enable smoothing, false to disable it

*See also:* `smooth?`

## SF::RenderTexture#texture()

Get a read-only reference to the target texture

After drawing to the render-texture and calling Display,
you can retrieve the updated texture using this function,
and draw it using a sprite (for example).
The internal `SF::Texture` of a render-texture is always the
same instance, so that it is possible to call this function
once and keep a reference to the texture even after it is
modified.

*Returns:* Const reference to the texture

## SF::RenderTexture#view()

:nodoc:

## SF::RenderTexture#view=(view)

:nodoc:

# SF::RenderWindow

Window that can serve as a target for 2D drawing

`SF::RenderWindow` is the main class of the Graphics module.
It defines an OS window that can be painted using the other
classes of the graphics module.

`SF::RenderWindow` is derived from `SF::Window`, thus it inherits
all its features: events, window management, OpenGL rendering,
etc. See the documentation of `SF::Window` for a more complete
description of all these features, as well as code examples.

On top of that, `SF::RenderWindow` adds more features related to
2D drawing with the graphics module (see its base module
`SF::RenderTarget` for more details).
Here is a typical rendering and event loop with a `SF::RenderWindow:`

```
# Declare and create a new render-window
window = SF::RenderWindow.new(SF::VideoMode.new(800, 600), "SFML window")

# Limit the framerate to 60 frames per second (this step is optional)
window.framerate_limit = 60

# The main loop - ends as soon as the window is closed
while window.open?
  # Event processing
  while (event = window.poll_event)
    # Request for closing the window
    if event.is_a? SF::Event::Closed
      window.close()
    end
  end

  # Clear the whole window before rendering a new frame
  window.clear()

  # Draw some graphical entities
  window.draw sprite
  window.draw circle
  window.draw text

  # End the current frame and display its contents on screen
  window.display()
end
```

Like `SF::Window`, `SF::RenderWindow` is still able to render direct
OpenGL stuff. It is even possible to mix together OpenGL calls
and regular SFML drawing commands.

```
# Create the render window
window = SF::RenderWindow.new(SF::VideoMode.new(800, 600), "SFML OpenGL")

# Create a sprite and a text to display
sprite = SF::Sprite.new
text = SF::Text.new
...

# Perform OpenGL initializations
glMatrixMode(GL_PROJECTION)
...

# Start the rendering loop
while window.open?
  # Process events
  ...

  # Draw a background sprite
  window.push_gl_states()
  window.draw sprite
  window.pop_gl_states()

  # Draw a 3D object using OpenGL
  glBegin(GL_QUADS)
    glVertex3f(...)
    ...
  glEnd()

  # Draw text on top of the 3D object
  window.push_gl_states()
  window.draw text
  window.pop_gl_states()

  # Finally, display the rendered frame on screen
  window.display()
end
```

*See also:* `SF::Window`, `SF::RenderTarget`, `SF::RenderTexture`, `SF::View`

## SF::RenderWindow#active=(active)

Activate or deactivate the window as the current target
for OpenGL rendering

A window is active only on the current thread, if you want to
make it active on another thread you have to deactivate it
on the previous thread first if it was active.
Only one window can be active on a thread at a time, thus
the window previously active (if any) automatically gets deactivated.
This is not to be confused with request_focus().

* *active* - True to activate, false to deactivate

*Returns:* True if operation was successful, false otherwise

## SF::RenderWindow#capture()

Copy the current contents of the window to an image

DEPRECATED:
Use a `SF::Texture` and its `SF::Texture#update(window)`
method and copy its contents into an `SF::Image` instead.
```
texture = SF::Texture.new(window.size.x, window.size.y)
texture.update(window)
screenshot = texture.copy_to_image()
```

This is a slow operation, whose main purpose is to make
screenshots of the application. If you want to update an
image with the contents of the window and then use it for
drawing, you should rather use a `SF::Texture` and its
`update(window)` method.
You can also draw things directly to a texture with the
`SF::RenderTexture` class.

*Returns:* Image containing the captured contents

## SF::RenderWindow#clear(color)

:nodoc:

## SF::RenderWindow#close()

:nodoc:

## SF::RenderWindow#create(handle,settings)

:nodoc:

## SF::RenderWindow#create(mode,title,style,settings)

:nodoc:

## SF::RenderWindow#default_view()

:nodoc:

## SF::RenderWindow#display()

:nodoc:

## SF::RenderWindow#draw(vertex_buffer,first_vertex,vertex_count,states)

:nodoc:

## SF::RenderWindow#draw(vertex_buffer,states)

:nodoc:

## SF::RenderWindow#draw(vertices,type,states)

:nodoc:

## SF::RenderWindow#finalize()

Destructor

Closes the window and frees all the resources attached to it.

## SF::RenderWindow#focus?()

:nodoc:

## SF::RenderWindow#framerate_limit=(limit)

:nodoc:

## SF::RenderWindow#get_viewport(view)

:nodoc:

## SF::RenderWindow#initialize()

Default constructor

This constructor doesn't actually create the window,
use the other constructors or call create() to do so.

## SF::RenderWindow#initialize(handle,settings)

Construct the window from an existing control

Use this constructor if you want to create an SFML
rendering area into an already existing control.

The second parameter is an optional structure specifying
advanced OpenGL context settings such as antialiasing,
depth-buffer bits, etc. You shouldn't care about these
parameters for a regular usage of the graphics module.

* *handle* - Platform-specific handle of the control (*hwnd* on
Windows, *%window* on Linux/FreeBSD, *ns_window* on OS X)
* *settings* - Additional settings for the underlying OpenGL context

## SF::RenderWindow#initialize(mode,title,style,settings)

Construct a new window

This constructor creates the window with the size and pixel
depth defined in *mode.* An optional style can be passed to
customize the look and behavior of the window (borders,
title bar, resizable, closable, ...).

The fourth parameter is an optional structure specifying
advanced OpenGL context settings such as antialiasing,
depth-buffer bits, etc. You shouldn't care about these
parameters for a regular usage of the graphics module.

* *mode* - Video mode to use (defines the width, height and depth of the rendering area of the window)
* *title* - Title of the window
* *style* - Window style, a bitwise OR combination of `SF::Style` enumerators
* *settings* - Additional settings for the underlying OpenGL context

## SF::RenderWindow#joystick_threshold=(threshold)

:nodoc:

## SF::RenderWindow#key_repeat_enabled=(enabled)

:nodoc:

## SF::RenderWindow#map_coords_to_pixel(point)

:nodoc:

## SF::RenderWindow#map_coords_to_pixel(point,view)

:nodoc:

## SF::RenderWindow#map_pixel_to_coords(point)

:nodoc:

## SF::RenderWindow#map_pixel_to_coords(point,view)

:nodoc:

## SF::RenderWindow#mouse_cursor=(cursor)

:nodoc:

## SF::RenderWindow#mouse_cursor_grabbed=(grabbed)

:nodoc:

## SF::RenderWindow#mouse_cursor_visible=(visible)

:nodoc:

## SF::RenderWindow#open?()

:nodoc:

## SF::RenderWindow#poll_event()

:nodoc:

## SF::RenderWindow#pop_gl_states()

:nodoc:

## SF::RenderWindow#position()

:nodoc:

## SF::RenderWindow#position=(position)

:nodoc:

## SF::RenderWindow#push_gl_states()

:nodoc:

## SF::RenderWindow#request_focus()

:nodoc:

## SF::RenderWindow#reset_gl_states()

:nodoc:

## SF::RenderWindow#set_icon(width,height,pixels)

:nodoc:

## SF::RenderWindow#settings()

:nodoc:

## SF::RenderWindow#size()

Get the size of the rendering region of the window

The size doesn't include the titlebar and borders
of the window.

*Returns:* Size in pixels

## SF::RenderWindow#size=(size)

:nodoc:

## SF::RenderWindow#system_handle()

:nodoc:

## SF::RenderWindow#title=(title)

:nodoc:

## SF::RenderWindow#vertical_sync_enabled=(enabled)

:nodoc:

## SF::RenderWindow#view()

:nodoc:

## SF::RenderWindow#view=(view)

:nodoc:

## SF::RenderWindow#visible=(visible)

:nodoc:

## SF::RenderWindow#wait_event()

:nodoc:

# SF::Shader

Shader class (vertex, geometry and fragment)

Shaders are programs written using a specific language,
executed directly by the graphics card and allowing
to apply real-time operations to the rendered entities.

There are three kinds of shaders:

* Vertex shaders, that process vertices
* Geometry shaders, that process primitives
* Fragment (pixel) shaders, that process pixels

A `SF::Shader` can be composed of either a vertex shader
alone, a geometry shader alone, a fragment shader alone,
or any combination of them. (see the variants of the
load functions).

Shaders are written in GLSL, which is a C-like
language dedicated to OpenGL shaders. You'll probably
need to learn its basics before writing your own shaders
for SFML.

Like any C/C++ program, a GLSL shader has its own variables
called *uniforms* that you can set from your C++ application.
`SF::Shader` handles different types of uniforms:

* scalars: `float`, `int`, `bool`
* vectors (2, 3 or 4 components)
* matrices (3x3 or 4x4)
* samplers (textures)

Some SFML-specific types can be converted:

* `SF::Color` as a 4D vector (`vec4`)
* `SF::Transform` as matrices (`mat3` or `mat4`)

Every uniform variable in a shader can be set through one of the
`set_parameter` overloads, or through a shorthand. For example, if you
have a shader with the following uniforms:
```glsl
uniform float offset;
uniform vec3 point;
uniform vec4 color;
uniform mat4 matrix;
uniform sampler2D overlay;
uniform sampler2D current;
```
You can set their values from Crystal code as follows:
```
shader.offset 2.0
shader.point 0.5, 0.8, 0.3
shader.color color          # color is a SF::Color
shader.matrix transform     # transform is a SF::Transform
shader.overlay texture      # texture is a SF::Texture
shader.current SF::Shader::CurrentTexture
```

The special Shader::CurrentTexture argument maps the
given `sampler2d` uniform to the current texture of the
object being drawn (which cannot be known in advance).

To apply a shader to a drawable, you must pass it as an
additional parameter to the `Window.draw` function:
```
states = SF::RenderStates.new(shader)
window.draw(sprite, states)
```

In the code above we pass a pointer to the shader, because it may
be null (which means "no shader").

Shaders can be used on any drawable, but some combinations are
not interesting. For example, using a vertex shader on a `SF::Sprite`
is limited because there are only 4 vertices, the sprite would
have to be subdivided in order to apply wave effects.
Another bad example is a fragment shader with `SF::Text:` the texture
of the text is not the actual text that you see on screen, it is
a big texture containing all the characters of the font in an
arbitrary order; thus, texture lookups on pixels other than the
current one may not give you the expected result.

Shaders can also be used to apply global post-effects to the
current contents of the target. This can be done in two different ways:

* draw everything to a `SF::RenderTexture`, then draw it to
the main target using the shader
* draw everything directly to the main target, then use
`SF::Texture::update(window)` to copy its contents to a texture
and draw it to the main target using the shader

The first technique is more optimized because it doesn't involve
retrieving the target's pixels to system memory, but the
second one doesn't impact the rendering process and can be
easily inserted anywhere without impacting all the code.

Like `SF::Texture` that can be used as a raw OpenGL texture,
`SF::Shader` can also be used directly as a raw shader for
custom OpenGL geometry.
```
SF::Shader.bind shader
... render OpenGL geometry ...
SF::Shader.bind nil
```

## SF::Shader::Type

Types of shaders

### SF::Shader::Type::Fragment

Fragment (pixel) shader

### SF::Shader::Type::Geometry

Geometry shader

### SF::Shader::Type::Vertex

Vertex shader

## SF::Shader.available?()

Tell whether or not the system supports shaders

This function should always be called before using
the shader features. If it returns false, then
any attempt to use `SF::Shader` will fail.

*Returns:* True if shaders are supported, false otherwise

## SF::Shader.bind(shader)

Bind a shader for rendering

This function is not part of the graphics API, it mustn't be
used when drawing SFML entities. It must be used only if you
mix `SF::Shader` with OpenGL code.

```
s1 = SF::Shader.new
s2 = SF::Shader.new
...
SF::Shader.bind s1
# draw OpenGL stuff that use s1...
SF::Shader.bind s2
# draw OpenGL stuff that use s2...
SF::Shader.bind nil
# draw OpenGL stuff that use no shader...
```

* *shader* - Shader to bind, can be null to use no shader

## SF::Shader#finalize()

Destructor

## SF::Shader.geometry_available?()

Tell whether or not the system supports geometry shaders

This function should always be called before using
the geometry shader features. If it returns false, then
any attempt to use `SF::Shader` geometry shader features will fail.

This function can only return true if available?() would also
return true, since shaders in general have to be supported in
order for geometry shaders to be supported as well.

Note: The first call to this function, whether by your
code or SFML will result in a context switch.

*Returns:* True if geometry shaders are supported, false otherwise

## SF::Shader#initialize()

Default constructor

This constructor creates an invalid shader.

## SF::Shader#load_from_file(filename,type)

Load the vertex, geometry or fragment shader from a file

This function loads a single shader, vertex, geometry or
fragment, identified by the second argument.
The source must be a text file containing a valid
shader in GLSL language. GLSL is a C-like language
dedicated to OpenGL shaders; you'll probably need to
read a good documentation for it before writing your
own shaders.

* *filename* - Path of the vertex, geometry or fragment shader file to load
* *type* - Type of shader (vertex, geometry or fragment)

*Returns:* True if loading succeeded, false if it failed

*See also:* `load_from_memory`, `load_from_stream`

## SF::Shader#load_from_file(vertex_shader_filename,fragment_shader_filename)

Load both the vertex and fragment shaders from files

This function loads both the vertex and the fragment
shaders. If one of them fails to load, the shader is left
empty (the valid shader is unloaded).
The sources must be text files containing valid shaders
in GLSL language. GLSL is a C-like language dedicated to
OpenGL shaders; you'll probably need to read a good documentation
for it before writing your own shaders.

* *vertex_shader_filename* - Path of the vertex shader file to load
* *fragment_shader_filename* - Path of the fragment shader file to load

*Returns:* True if loading succeeded, false if it failed

*See also:* `load_from_memory`, `load_from_stream`

## SF::Shader#load_from_file(vertex_shader_filename,geometry_shader_filename,fragment_shader_filename)

Load the vertex, geometry and fragment shaders from files

This function loads the vertex, geometry and fragment
shaders. If one of them fails to load, the shader is left
empty (the valid shader is unloaded).
The sources must be text files containing valid shaders
in GLSL language. GLSL is a C-like language dedicated to
OpenGL shaders; you'll probably need to read a good documentation
for it before writing your own shaders.

* *vertex_shader_filename* - Path of the vertex shader file to load
* *geometry_shader_filename* - Path of the geometry shader file to load
* *fragment_shader_filename* - Path of the fragment shader file to load

*Returns:* True if loading succeeded, false if it failed

*See also:* `load_from_memory`, `load_from_stream`

## SF::Shader#load_from_memory(shader,type)

Load the vertex, geometry or fragment shader from a source code in memory

This function loads a single shader, vertex, geometry
or fragment, identified by the second argument.
The source code must be a valid shader in GLSL language.
GLSL is a C-like language dedicated to OpenGL shaders
you'll probably need to read a good documentation for
it before writing your own shaders.

* *shader* - String containing the source code of the shader
* *type* - Type of shader (vertex, geometry or fragment)

*Returns:* True if loading succeeded, false if it failed

*See also:* `load_from_file`, `load_from_stream`

## SF::Shader#load_from_memory(vertex_shader,fragment_shader)

Load both the vertex and fragment shaders from source codes in memory

This function loads both the vertex and the fragment
shaders. If one of them fails to load, the shader is left
empty (the valid shader is unloaded).
The sources must be valid shaders in GLSL language. GLSL is
a C-like language dedicated to OpenGL shaders; you'll
probably need to read a good documentation for it before
writing your own shaders.

* *vertex_shader* - String containing the source code of the vertex shader
* *fragment_shader* - String containing the source code of the fragment shader

*Returns:* True if loading succeeded, false if it failed

*See also:* `load_from_file`, `load_from_stream`

## SF::Shader#load_from_memory(vertex_shader,geometry_shader,fragment_shader)

Load the vertex, geometry and fragment shaders from source codes in memory

This function loads the vertex, geometry and fragment
shaders. If one of them fails to load, the shader is left
empty (the valid shader is unloaded).
The sources must be valid shaders in GLSL language. GLSL is
a C-like language dedicated to OpenGL shaders; you'll
probably need to read a good documentation for it before
writing your own shaders.

* *vertex_shader* - String containing the source code of the vertex shader
* *geometry_shader* - String containing the source code of the geometry shader
* *fragment_shader* - String containing the source code of the fragment shader

*Returns:* True if loading succeeded, false if it failed

*See also:* `load_from_file`, `load_from_stream`

## SF::Shader#load_from_stream(stream,type)

Load the vertex, geometry or fragment shader from a custom stream

This function loads a single shader, vertex, geometry
or fragment, identified by the second argument.
The source code must be a valid shader in GLSL language.
GLSL is a C-like language dedicated to OpenGL shaders
you'll probably need to read a good documentation for it
before writing your own shaders.

* *stream* - Source stream to read from
* *type* - Type of shader (vertex, geometry or fragment)

*Returns:* True if loading succeeded, false if it failed

*See also:* `load_from_file`, `load_from_memory`

## SF::Shader#load_from_stream(vertex_shader_stream,fragment_shader_stream)

Load both the vertex and fragment shaders from custom streams

This function loads both the vertex and the fragment
shaders. If one of them fails to load, the shader is left
empty (the valid shader is unloaded).
The source codes must be valid shaders in GLSL language.
GLSL is a C-like language dedicated to OpenGL shaders
you'll probably need to read a good documentation for
it before writing your own shaders.

* *vertex_shader_stream* - Source stream to read the vertex shader from
* *fragment_shader_stream* - Source stream to read the fragment shader from

*Returns:* True if loading succeeded, false if it failed

*See also:* `load_from_file`, `load_from_memory`

## SF::Shader#load_from_stream(vertex_shader_stream,geometry_shader_stream,fragment_shader_stream)

Load the vertex, geometry and fragment shaders from custom streams

This function loads the vertex, geometry and fragment
shaders. If one of them fails to load, the shader is left
empty (the valid shader is unloaded).
The source codes must be valid shaders in GLSL language.
GLSL is a C-like language dedicated to OpenGL shaders
you'll probably need to read a good documentation for
it before writing your own shaders.

* *vertex_shader_stream* - Source stream to read the vertex shader from
* *geometry_shader_stream* - Source stream to read the geometry shader from
* *fragment_shader_stream* - Source stream to read the fragment shader from

*Returns:* True if loading succeeded, false if it failed

*See also:* `load_from_file`, `load_from_memory`

## SF::Shader#native_handle()

Get the underlying OpenGL handle of the shader.

You shouldn't need to use this function, unless you have
very specific stuff to implement that SFML doesn't support,
or implement a temporary workaround until a bug is fixed.

*Returns:* OpenGL handle of the shader or 0 if not yet loaded

## SF::Shader#set_parameter(name,color)

Change a color parameter of the shader

## SF::Shader#set_parameter(name,p1)

Change a texture parameter of the shader

## SF::Shader#set_parameter(name,texture)

Change a texture parameter of the shader

## SF::Shader#set_parameter(name,transform)

Change a matrix parameter of the shader

## SF::Shader#set_parameter(name,vector)

Change a 2-components vector parameter of the shader

DEPRECATED: Use uniform=(const std::string&, const Glsl::Vec2&) instead.

## SF::Shader#set_parameter(name,vector)

Change a 3-components vector parameter of the shader

## SF::Shader#set_parameter(name,x)

Change a float parameter of the shader

## SF::Shader#set_parameter(name,x,y)

Change a 2-components vector parameter of the shader

## SF::Shader#set_parameter(name,x,y,z)

Change a 3-components vector parameter of the shader

## SF::Shader#set_parameter(name,x,y,z,w)

Change a 4-components vector parameter of the shader

# SF::Shape

Base class for textured shapes with outline

`SF::Shape` is a drawable class that allows to define and
display a custom convex shape on a render target.
It's only an abstract base, it needs to be specialized for
concrete types of shapes (circle, rectangle, convex polygon,
star, ...).

In addition to the attributes provided by the specialized
shape classes, a shape always has the following attributes:

* a texture
* a texture rectangle
* a fill color
* an outline color
* an outline thickness

Each feature is optional, and can be disabled easily:

* the texture can be null
* the fill/outline colors can be `SF::Color::Transparent`
* the outline thickness can be zero

You can write your own derived shape class, there are only
two virtual functions to override:

* `point_count` must return the number of points of the shape
* `get_point` must return the points of the shape

*See also:* `SF::RectangleShape`, `SF::CircleShape`, `SF::ConvexShape`, `SF::Transformable`

## SF::Shape#draw(target,states)

:nodoc:

## SF::Shape#draw(target,states)

:nodoc:

## SF::Shape#draw(target,states)

:nodoc:

## SF::Shape#fill_color()

Get the fill color of the shape

*Returns:* Fill color of the shape

*See also:* `fill_color=`

## SF::Shape#fill_color=(color)

Set the fill color of the shape

This color is modulated (multiplied) with the shape's
texture if any. It can be used to colorize the shape,
or change its global opacity.
You can use `SF::Color::Transparent` to make the inside of
the shape transparent, and have the outline alone.
By default, the shape's fill color is opaque white.

* *color* - New color of the shape

*See also:* `fill_color`, `outline_color=`

## SF::Shape#finalize()

Virtual destructor

## SF::Shape#get_point(index)

Get a point of the shape

The returned point is in local coordinates, that is,
the shape's transforms (position, rotation, scale) are
not taken into account.
The result is undefined if *index* is out of the valid range.

* *index* - Index of the point to get, in range `0 ... point_count`

*Returns:* index-th point of the shape

*See also:* `point_count`

## SF::Shape#global_bounds()

Get the global (non-minimal) bounding rectangle of the entity

The returned rectangle is in global coordinates, which means
that it takes into account the transformations (translation,
rotation, scale, ...) that are applied to the entity.
In other words, this function returns the bounds of the
shape in the global 2D world's coordinate system.

This function does not necessarily return the *minimal*
bounding rectangle. It merely ensures that the returned
rectangle covers all the vertices (but possibly more).
This allows for a fast approximation of the bounds as a
first check; you may want to use more precise checks
on top of that.

*Returns:* Global bounding rectangle of the entity

## SF::Shape#initialize()

Default constructor

## SF::Shape#inverse_transform()

:nodoc:

## SF::Shape#local_bounds()

Get the local bounding rectangle of the entity

The returned rectangle is in local coordinates, which means
that it ignores the transformations (translation, rotation,
scale, ...) that are applied to the entity.
In other words, this function returns the bounds of the
entity in the entity's coordinate system.

*Returns:* Local bounding rectangle of the entity

## SF::Shape#move(offset)

:nodoc:

## SF::Shape#move(offset_x,offset_y)

:nodoc:

## SF::Shape#origin()

:nodoc:

## SF::Shape#origin=(origin)

:nodoc:

## SF::Shape#outline_color()

Get the outline color of the shape

*Returns:* Outline color of the shape

*See also:* `outline_color=`

## SF::Shape#outline_color=(color)

Set the outline color of the shape

By default, the shape's outline color is opaque white.

* *color* - New outline color of the shape

*See also:* `outline_color`, `fill_color=`

## SF::Shape#outline_thickness()

Get the outline thickness of the shape

*Returns:* Outline thickness of the shape

*See also:* `outline_thickness=`

## SF::Shape#outline_thickness=(thickness)

Set the thickness of the shape's outline

Note that negative values are allowed (so that the outline
expands towards the center of the shape), and using zero
disables the outline.
By default, the outline thickness is 0.

* *thickness* - New outline thickness

*See also:* `outline_thickness`

## SF::Shape#point_count()

Get the total number of points of the shape

*Returns:* Number of points of the shape

*See also:* `point`

## SF::Shape#position()

:nodoc:

## SF::Shape#position=(position)

:nodoc:

## SF::Shape#rotate(angle)

:nodoc:

## SF::Shape#rotation()

:nodoc:

## SF::Shape#rotation=(angle)

:nodoc:

## SF::Shape#scale()

:nodoc:

## SF::Shape#scale(factor)

:nodoc:

## SF::Shape#scale(factor_x,factor_y)

:nodoc:

## SF::Shape#scale=(factors)

:nodoc:

## SF::Shape#set_origin(x,y)

:nodoc:

## SF::Shape#set_position(x,y)

:nodoc:

## SF::Shape#set_scale(factor_x,factor_y)

:nodoc:

## SF::Shape#set_texture(texture,reset_rect)

Change the source texture of the shape

The *texture* argument refers to a texture that must
exist as long as the shape uses it. Indeed, the shape
doesn't store its own copy of the texture, but rather keeps
a pointer to the one that you passed to this function.
If the source texture is destroyed and the shape tries to
use it, the behavior is undefined.
*texture* can be NULL to disable texturing.
If *reset_rect* is true, the TextureRect property of
the shape is automatically adjusted to the size of the new
texture. If it is false, the texture rect is left unchanged.

* *texture* - New texture
* *reset_rect* - Should the texture rect be reset to the size of the new texture?

*See also:* `texture`, `texture_rect=`

## SF::Shape#texture()

Get the source texture of the shape

If the shape has no source texture, a NULL pointer is returned.
The returned pointer is const, which means that you can't
modify the texture when you retrieve it with this function.

*Returns:* Pointer to the shape's texture

*See also:* `texture=`

## SF::Shape#texture()

:nodoc:

## SF::Shape#texture_rect()

Get the sub-rectangle of the texture displayed by the shape

*Returns:* Texture rectangle of the shape

*See also:* `texture_rect=`

## SF::Shape#texture_rect=(rect)

Set the sub-rectangle of the texture that the shape will display

The texture rect is useful when you don't want to display
the whole texture, but rather a part of it.
By default, the texture rect covers the entire texture.

* *rect* - Rectangle defining the region of the texture to display

*See also:* `texture_rect`, `texture=`

## SF::Shape#transform()

:nodoc:

## SF::Shape#update()

Recompute the internal geometry of the shape

This function must be called by the derived class everytime
the shape's points change (i.e. the result of either
`point_count` or `get_point` is different).

# SF::Sprite

Drawable representation of a texture, with its
own transformations, color, etc.

`SF::Sprite` is a drawable class that allows to easily display
a texture (or a part of it) on a render target.

It inherits all the functions from `SF::Transformable:`
position, rotation, scale, origin. It also adds sprite-specific
properties such as the texture to use, the part of it to display,
and some convenience functions to change the overall color of the
sprite, or to get its bounding rectangle.

`SF::Sprite` works in combination with the `SF::Texture` class, which
loads and provides the pixel data of a given texture.

The separation of `SF::Sprite` and `SF::Texture` allows more flexibility
and better performances: indeed a `SF::Texture` is a heavy resource,
and any operation on it is slow (often too slow for real-time
applications). On the other side, a `SF::Sprite` is a lightweight
object which can use the pixel data of a `SF::Texture` and draw
it with its own transformation/color/blending attributes.

It is important to note that the `SF::Sprite` instance doesn't
copy the texture that it uses, it only keeps a reference to it.
Thus, a `SF::Texture` must not be destroyed while it is
used by a `SF::Sprite` (i.e. never write a function that
uses a local `SF::Texture` instance for creating a sprite).

See also the note on coordinates and undistorted rendering in `SF::Transformable`.

Usage example:
```
# Declare and load a texture
texture = SF::Texture.from_file("texture.png")

# Create a sprite
sprite = SF::Sprite.new
sprite.texture = texture
sprite.texture_rect = SF.int_rect(10, 10, 50, 30)
sprite.color = SF.color(255, 255, 255, 200)
sprite.position = {100, 25}

# Draw it
window.draw sprite
```

*See also:* `SF::Texture`, `SF::Transformable`

## SF::Sprite#color()

Get the global color of the sprite

*Returns:* Global color of the sprite

*See also:* `color=`

## SF::Sprite#color=(color)

Set the global color of the sprite

This color is modulated (multiplied) with the sprite's
texture. It can be used to colorize the sprite, or change
its global opacity.
By default, the sprite's color is opaque white.

* *color* - New color of the sprite

*See also:* `color`

## SF::Sprite#draw(target,states)

:nodoc:

## SF::Sprite#draw(target,states)

:nodoc:

## SF::Sprite#draw(target,states)

:nodoc:

## SF::Sprite#global_bounds()

Get the global bounding rectangle of the entity

The returned rectangle is in global coordinates, which means
that it takes into account the transformations (translation,
rotation, scale, ...) that are applied to the entity.
In other words, this function returns the bounds of the
sprite in the global 2D world's coordinate system.

*Returns:* Global bounding rectangle of the entity

## SF::Sprite#initialize()

Default constructor

Creates an empty sprite with no source texture.

## SF::Sprite#initialize(copy)

:nodoc:

## SF::Sprite#initialize(texture)

Construct the sprite from a source texture

* *texture* - Source texture

*See also:* `texture=`

## SF::Sprite#initialize(texture,rectangle)

Construct the sprite from a sub-rectangle of a source texture

* *texture* - Source texture
* *rectangle* - Sub-rectangle of the texture to assign to the sprite

*See also:* `texture=`, `texture_rect=`

## SF::Sprite#inverse_transform()

:nodoc:

## SF::Sprite#local_bounds()

Get the local bounding rectangle of the entity

The returned rectangle is in local coordinates, which means
that it ignores the transformations (translation, rotation,
scale, ...) that are applied to the entity.
In other words, this function returns the bounds of the
entity in the entity's coordinate system.

*Returns:* Local bounding rectangle of the entity

## SF::Sprite#move(offset)

:nodoc:

## SF::Sprite#move(offset_x,offset_y)

:nodoc:

## SF::Sprite#origin()

:nodoc:

## SF::Sprite#origin=(origin)

:nodoc:

## SF::Sprite#position()

:nodoc:

## SF::Sprite#position=(position)

:nodoc:

## SF::Sprite#rotate(angle)

:nodoc:

## SF::Sprite#rotation()

:nodoc:

## SF::Sprite#rotation=(angle)

:nodoc:

## SF::Sprite#scale()

:nodoc:

## SF::Sprite#scale(factor)

:nodoc:

## SF::Sprite#scale(factor_x,factor_y)

:nodoc:

## SF::Sprite#scale=(factors)

:nodoc:

## SF::Sprite#set_origin(x,y)

:nodoc:

## SF::Sprite#set_position(x,y)

:nodoc:

## SF::Sprite#set_scale(factor_x,factor_y)

:nodoc:

## SF::Sprite#set_texture(texture,reset_rect)

Change the source texture of the sprite

The *texture* argument refers to a texture that must
exist as long as the sprite uses it. Indeed, the sprite
doesn't store its own copy of the texture, but rather keeps
a pointer to the one that you passed to this function.
If the source texture is destroyed and the sprite tries to
use it, the behavior is undefined.
If *reset_rect* is true, the TextureRect property of
the sprite is automatically adjusted to the size of the new
texture. If it is false, the texture rect is left unchanged.

* *texture* - New texture
* *reset_rect* - Should the texture rect be reset to the size of the new texture?

*See also:* `texture`, `texture_rect=`

## SF::Sprite#texture()

Get the source texture of the sprite

If the sprite has no source texture, a NULL pointer is returned.
The returned pointer is const, which means that you can't
modify the texture when you retrieve it with this function.

*Returns:* Pointer to the sprite's texture

*See also:* `texture=`

## SF::Sprite#texture()

:nodoc:

## SF::Sprite#texture_rect()

Get the sub-rectangle of the texture displayed by the sprite

*Returns:* Texture rectangle of the sprite

*See also:* `texture_rect=`

## SF::Sprite#texture_rect=(rectangle)

Set the sub-rectangle of the texture that the sprite will display

The texture rect is useful when you don't want to display
the whole texture, but rather a part of it.
By default, the texture rect covers the entire texture.

* *rectangle* - Rectangle defining the region of the texture to display

*See also:* `texture_rect`, `texture=`

## SF::Sprite#transform()

:nodoc:

# SF::Text

Graphical text that can be drawn to a render target

`SF::Text` is a drawable class that allows to easily display
some text with custom style and color on a render target.

It inherits all the functions from `SF::Transformable:`
position, rotation, scale, origin. It also adds text-specific
properties such as the font to use, the character size,
the font style (bold, italic, underlined and strike through), the
text color, the outline thickness, the outline color, the character
spacing, the line spacing and the text to display of course.
It also provides convenience functions to calculate the
graphical size of the text, or to get the global position
of a given character.

`SF::Text` works in combination with the `SF::Font` class, which
loads and provides the glyphs (visual characters) of a given font.

The separation of `SF::Font` and `SF::Text` allows more flexibility
and better performances: indeed a `SF::Font` is a heavy resource,
and any operation on it is slow (often too slow for real-time
applications). On the other side, a `SF::Text` is a lightweight
object which can combine the glyphs data and metrics of a `SF::Font`
to display any text on a render target.

It is important to note that the `SF::Text` instance doesn't
copy the font that it uses, it only keeps a reference to it.
Thus, a `SF::Font` must not be destructed while it is
used by a `SF::Text` (i.e. never write a function that
uses a local `SF::Font` instance for creating a text).

See also the note on coordinates and undistorted rendering in `SF::Transformable`.

Usage example:
```
# Declare and load a font
font = SF::Font.from_file("arial.ttf")

# Create a text
text = SF::Text.new("hello", font)
text.character_size = 30
text.style = SF::Text::Bold
text.color = SF::Color::Red

# Draw it
window.draw text
```

*See also:* `SF::Font`, `SF::Transformable`

## SF::Text::Style

Enumeration of the string drawing styles

### SF::Text::Style::Bold

Bold characters

### SF::Text::Style::Italic

Italic characters

### SF::Text::Style::Regular

Regular characters, no style

### SF::Text::Style::StrikeThrough

Strike through characters

### SF::Text::Style::Underlined

Underlined characters

## SF::Text#character_size()

Get the character size

*Returns:* Size of the characters, in pixels

*See also:* `character_size=`

## SF::Text#character_size=(size)

Set the character size

The default size is 30.

Note that if the used font is a bitmap font, it is not
scalable, thus not all requested sizes will be available
to use. This needs to be taken into consideration when
setting the character size. If you need to display text
of a certain size, make sure the corresponding bitmap
font that supports that size is used.

* *size* - New character size, in pixels

*See also:* `character_size`

## SF::Text#color()

Get the fill color of the text

*Returns:* Fill color of the text

*See also:* `fill_color=`

DEPRECATED: There is now fill and outline colors instead
of a single global color.
Use fill_color() or outline_color() instead.

## SF::Text#color=(color)

Set the fill color of the text

By default, the text's fill color is opaque white.
Setting the fill color to a transparent color with an outline
will cause the outline to be displayed in the fill area of the text.

* *color* - New fill color of the text

*See also:* `fill_color`

DEPRECATED: There is now fill and outline colors instead
of a single global color.
Use fill_color=() or outline_color=() instead.

## SF::Text#draw(target,states)

:nodoc:

## SF::Text#draw(target,states)

:nodoc:

## SF::Text#draw(target,states)

:nodoc:

## SF::Text#fill_color()

Get the fill color of the text

*Returns:* Fill color of the text

*See also:* `fill_color=`

## SF::Text#fill_color=(color)

Set the fill color of the text

By default, the text's fill color is opaque white.
Setting the fill color to a transparent color with an outline
will cause the outline to be displayed in the fill area of the text.

* *color* - New fill color of the text

*See also:* `fill_color`

## SF::Text#find_character_pos(index)

Return the position of the *index-th* character

This function computes the visual position of a character
from its index in the string. The returned position is
in global coordinates (translation, rotation, scale and
origin are applied).
If *index* is out of range, the position of the end of
the string is returned.

* *index* - Index of the character

*Returns:* Position of the character

## SF::Text#font()

Get the text's font

If the text has no font attached, a NULL pointer is returned.
The returned pointer is const, which means that you
cannot modify the font when you get it from this function.

*Returns:* Pointer to the text's font

*See also:* `font=`

## SF::Text#font()

:nodoc:

## SF::Text#font=(font)

Set the text's font

The *font* argument refers to a font that must
exist as long as the text uses it. Indeed, the text
doesn't store its own copy of the font, but rather keeps
a pointer to the one that you passed to this function.
If the font is destroyed and the text tries to
use it, the behavior is undefined.

* *font* - New font

*See also:* `font`

## SF::Text#global_bounds()

Get the global bounding rectangle of the entity

The returned rectangle is in global coordinates, which means
that it takes into account the transformations (translation,
rotation, scale, ...) that are applied to the entity.
In other words, this function returns the bounds of the
text in the global 2D world's coordinate system.

*Returns:* Global bounding rectangle of the entity

## SF::Text#initialize()

Default constructor

Creates an empty text.

## SF::Text#initialize(copy)

:nodoc:

## SF::Text#initialize(string,font,character_size)

Construct the text from a string, font and size

Note that if the used font is a bitmap font, it is not
scalable, thus not all requested sizes will be available
to use. This needs to be taken into consideration when
setting the character size. If you need to display text
of a certain size, make sure the corresponding bitmap
font that supports that size is used.

* *string* - Text assigned to the string
* *font* - Font used to draw the string
* *character_size* - Base size of characters, in pixels

## SF::Text#inverse_transform()

:nodoc:

## SF::Text#letter_spacing()

Get the size of the letter spacing factor

*Returns:* Size of the letter spacing factor

*See also:* `letter_spacing=`

## SF::Text#letter_spacing=(spacing_factor)

Set the letter spacing factor

The default spacing between letters is defined by the font.
This factor doesn't directly apply to the existing
spacing between each character, it rather adds a fixed
space between them which is calculated from the font
metrics and the character size.
Note that factors below 1 (including negative numbers) bring
characters closer to each other.
By default the letter spacing factor is 1.

* *spacing_factor* - New letter spacing factor

*See also:* `letter_spacing`

## SF::Text#line_spacing()

Get the size of the line spacing factor

*Returns:* Size of the line spacing factor

*See also:* `line_spacing=`

## SF::Text#line_spacing=(spacing_factor)

Set the line spacing factor

The default spacing between lines is defined by the font.
This method enables you to set a factor for the spacing
between lines. By default the line spacing factor is 1.

* *spacing_factor* - New line spacing factor

*See also:* `line_spacing`

## SF::Text#local_bounds()

Get the local bounding rectangle of the entity

The returned rectangle is in local coordinates, which means
that it ignores the transformations (translation, rotation,
scale, ...) that are applied to the entity.
In other words, this function returns the bounds of the
entity in the entity's coordinate system.

*Returns:* Local bounding rectangle of the entity

## SF::Text#move(offset)

:nodoc:

## SF::Text#move(offset_x,offset_y)

:nodoc:

## SF::Text#origin()

:nodoc:

## SF::Text#origin=(origin)

:nodoc:

## SF::Text#outline_color()

Get the outline color of the text

*Returns:* Outline color of the text

*See also:* `outline_color=`

## SF::Text#outline_color=(color)

Set the outline color of the text

By default, the text's outline color is opaque black.

* *color* - New outline color of the text

*See also:* `outline_color`

## SF::Text#outline_thickness()

Get the outline thickness of the text

*Returns:* Outline thickness of the text, in pixels

*See also:* `outline_thickness=`

## SF::Text#outline_thickness=(thickness)

Set the thickness of the text's outline

By default, the outline thickness is 0.

Be aware that using a negative value for the outline
thickness will cause distorted rendering.

* *thickness* - New outline thickness, in pixels

*See also:* `outline_thickness`

## SF::Text#position()

:nodoc:

## SF::Text#position=(position)

:nodoc:

## SF::Text#rotate(angle)

:nodoc:

## SF::Text#rotation()

:nodoc:

## SF::Text#rotation=(angle)

:nodoc:

## SF::Text#scale()

:nodoc:

## SF::Text#scale(factor)

:nodoc:

## SF::Text#scale(factor_x,factor_y)

:nodoc:

## SF::Text#scale=(factors)

:nodoc:

## SF::Text#set_origin(x,y)

:nodoc:

## SF::Text#set_position(x,y)

:nodoc:

## SF::Text#set_scale(factor_x,factor_y)

:nodoc:

## SF::Text#string()

Get the text's string

*Returns:* Text's string

*See also:* `string=`

## SF::Text#string=(string)

Set the text's string

A text's string is empty by default.

* *string* - New string

*See also:* `string`

## SF::Text#style()

Get the text's style

*Returns:* Text's style

*See also:* `style=`

## SF::Text#style=(style)

Set the text's style

You can pass a combination of one or more styles, for
example `SF::Text::Bold` | `SF::Text::Italic`.
The default style is `SF::Text::Regular`.

* *style* - New style

*See also:* `style`

## SF::Text#transform()

:nodoc:

# SF::Texture

Image living on the graphics card that can be used for drawing

`SF::Texture` stores pixels that can be drawn, with a sprite
for example. A texture lives in the graphics card memory,
therefore it is very fast to draw a texture to a render target,
or copy a render target to a texture (the graphics card can
access both directly).

Being stored in the graphics card memory has some drawbacks.
A texture cannot be manipulated as freely as a `SF::Image`,
you need to prepare the pixels first and then upload them
to the texture in a single operation (see Texture.update).

`SF::Texture` makes it easy to convert from/to `SF::Image`, but
keep in mind that these calls require transfers between
the graphics card and the central memory, therefore they are
slow operations.

A texture can be loaded from an image, but also directly
from a file/memory/stream. The necessary shortcuts are defined
so that you don't need an image first for the most common cases.
However, if you want to perform some modifications on the pixels
before creating the final texture, you can load your file to a
`SF::Image`, do whatever you need with the pixels, and then call
Texture.load_from_image.

Since they live in the graphics card memory, the pixels of a texture
cannot be accessed without a slow copy first. And they cannot be
accessed individually. Therefore, if you need to read the texture's
pixels (like for pixel-perfect collisions), it is recommended to
store the collision information separately, for example in an array
of booleans.

Like `SF::Image`, `SF::Texture` can handle a unique internal
representation of pixels, which is RGBA 32 bits. This means
that a pixel must be composed of 8 bits red, green, blue and
alpha channels -- just like a `SF::Color`.

Usage example:
```
# This example shows the most common use of SF::Texture:
# drawing a sprite

# Load a texture from a file
texture = SF::Texture.from_file("texture.png")

# Assign it to a sprite
sprite = SF::Sprite.new(texture)

# Draw the textured sprite
window.draw sprite
```

```
# This example shows another common use of SF::Texture:
# streaming real-time data, like video frames

# Create an empty texture
texture = SF::Texture.new(640, 480)

# Create a sprite that will display the texture
sprite = SF::Sprite.new(texture)

loop do # the main loop
  ...

  # update the texture
  pixels = (...).to_unsafe # get a fresh chunk of pixels (the next frame of a movie, for example)
  texture.update(pixels)

  # draw it
  window.draw sprite

  ...
end

```

Like `SF::Shader` that can be used as a raw OpenGL shader,
`SF::Texture` can also be used directly as a raw texture for
custom OpenGL geometry.
```
SF::Texture.bind(texture)
... render OpenGL geometry ...
SF::Texture.bind(nil)
```

*See also:* `SF::Sprite`, `SF::Image`, `SF::RenderTexture`

## SF::Texture::CoordinateType

Types of texture coordinates that can be used for rendering

### SF::Texture::CoordinateType::Normalized

Texture coordinates in range `0.0 .. 1.0`

### SF::Texture::CoordinateType::Pixels

Texture coordinates in range `0.0 .. size`

## SF::Texture.bind(texture,coordinate_type)

Bind a texture for rendering

This function is not part of the graphics API, it mustn't be
used when drawing SFML entities. It must be used only if you
mix `SF::Texture` with OpenGL code.

```
t1 = SF::Texture.new
t2 = SF::Texture.new
...
SF::Texture.bind t1
# draw OpenGL stuff that use t1...
SF::Texture.bind t2
# draw OpenGL stuff that use t2...
SF::Texture.bind nil
# draw OpenGL stuff that use no texture...
```

The *coordinate_type* argument controls how texture
coordinates will be interpreted. If Normalized (the default), they
must be in range `0.0 .. 1.0`, which is the default way of handling
texture coordinates with OpenGL. If Pixels, they must be given
in pixels (range `0.0 .. size`). This mode is used internally by
the graphics classes of SFML, it makes the definition of texture
coordinates more intuitive for the high-level API, users don't need
to compute normalized values.

* *texture* - Pointer to the texture to bind, can be null to use no texture
* *coordinate_type* - Type of texture coordinates to use

## SF::Texture#copy_to_image()

Copy the texture pixels to an image

This function performs a slow operation that downloads
the texture's pixels from the graphics card and copies
them to a new image, potentially applying transformations
to pixels if necessary (texture may be padded or flipped).

*Returns:* Image containing the texture's pixels

*See also:* `load_from_image`

## SF::Texture#create(width,height)

Create the texture

If this function fails, the texture is left unchanged.

* *width* - Width of the texture
* *height* - Height of the texture

*Returns:* True if creation was successful

## SF::Texture#finalize()

Destructor

## SF::Texture#generate_mipmap()

Generate a mipmap using the current texture data

Mipmaps are pre-computed chains of optimized textures. Each
level of texture in a mipmap is generated by halving each of
the previous level's dimensions. This is done until the final
level has the size of 1x1. The textures generated in this process may
make use of more advanced filters which might improve the visual quality
of textures when they are applied to objects much smaller than they are.
This is known as minification. Because fewer texels (texture elements)
have to be sampled from when heavily minified, usage of mipmaps
can also improve rendering performance in certain scenarios.

Mipmap generation relies on the necessary OpenGL extension being
available. If it is unavailable or generation fails due to another
reason, this function will return false. Mipmap data is only valid from
the time it is generated until the next time the base level image is
modified, at which point this function will have to be called again to
regenerate it.

*Returns:* True if mipmap generation was successful, false if unsuccessful

## SF::Texture#initialize()

Default constructor

Creates an empty texture.

## SF::Texture#initialize(copy)

:nodoc:

## SF::Texture#load_from_file(filename,area)

Load the texture from a file on disk

This function is a shortcut for the following code:
```
image = SF::Image.new
image.load_from_file(filename)
texture.load_from_image(image, area)
```

The *area* argument can be used to load only a sub-rectangle
of the whole image. If you want the entire image then leave
the default value (which is an empty IntRect).
If the *area* rectangle crosses the bounds of the image, it
is adjusted to fit the image size.

The maximum size for a texture depends on the graphics
driver and can be retrieved with the maximum_size function.

If this function fails, the texture is left unchanged.

* *filename* - Path of the image file to load
* *area* - Area of the image to load

*Returns:* True if loading was successful

*See also:* `load_from_memory`, `load_from_stream`, `load_from_image`

## SF::Texture#load_from_image(image,area)

Load the texture from an image

The *area* argument can be used to load only a sub-rectangle
of the whole image. If you want the entire image then leave
the default value (which is an empty IntRect).
If the *area* rectangle crosses the bounds of the image, it
is adjusted to fit the image size.

The maximum size for a texture depends on the graphics
driver and can be retrieved with the maximum_size function.

If this function fails, the texture is left unchanged.

* *image* - Image to load into the texture
* *area* - Area of the image to load

*Returns:* True if loading was successful

*See also:* `load_from_file`, `load_from_memory`

## SF::Texture#load_from_memory(data,area)

Load the texture from a file in memory

This function is a shortcut for the following code:
```
image = SF::Image.new
image.load_from_memory(data, size)
texture.load_from_image(image, area)
```

The *area* argument can be used to load only a sub-rectangle
of the whole image. If you want the entire image then leave
the default value (which is an empty IntRect).
If the *area* rectangle crosses the bounds of the image, it
is adjusted to fit the image size.

The maximum size for a texture depends on the graphics
driver and can be retrieved with the maximum_size function.

If this function fails, the texture is left unchanged.

* *data* - Slice containing the file data in memory
* *area* - Area of the image to load

*Returns:* True if loading was successful

*See also:* `load_from_file`, `load_from_stream`, `load_from_image`

## SF::Texture#load_from_stream(stream,area)

Load the texture from a custom stream

This function is a shortcut for the following code:
```
image = SF::Image.new
image.load_from_stream(stream)
texture.load_from_image(image, area)
```

The *area* argument can be used to load only a sub-rectangle
of the whole image. If you want the entire image then leave
the default value (which is an empty IntRect).
If the *area* rectangle crosses the bounds of the image, it
is adjusted to fit the image size.

The maximum size for a texture depends on the graphics
driver and can be retrieved with the maximum_size function.

If this function fails, the texture is left unchanged.

* *stream* - Source stream to read from
* *area* - Area of the image to load

*Returns:* True if loading was successful

*See also:* `load_from_file`, `load_from_memory`, `load_from_image`

## SF::Texture.maximum_size()

Get the maximum texture size allowed

This maximum size is defined by the graphics driver.
You can expect a value of 512 pixels for low-end graphics
card, and up to 8192 pixels or more for newer hardware.

*Returns:* Maximum size allowed for textures, in pixels

## SF::Texture#native_handle()

Get the underlying OpenGL handle of the texture.

You shouldn't need to use this function, unless you have
very specific stuff to implement that SFML doesn't support,
or implement a temporary workaround until a bug is fixed.

*Returns:* OpenGL handle of the texture or 0 if not yet created

## SF::Texture#repeated?()

Tell whether the texture is repeated or not

*Returns:* True if repeat mode is enabled, false if it is disabled

*See also:* `repeated=`

## SF::Texture#repeated=(repeated)

Enable or disable repeating

Repeating is involved when using texture coordinates
outside the texture rectangle [0, 0, width, height].
In this case, if repeat mode is enabled, the whole texture
will be repeated as many times as needed to reach the
coordinate (for example, if the X texture coordinate is
3 * width, the texture will be repeated 3 times).
If repeat mode is disabled, the "extra space" will instead
be filled with border pixels.
Warning: on very old graphics cards, white pixels may appear
when the texture is repeated. With such cards, repeat mode
can be used reliably only if the texture has power-of-two
dimensions (such as 256x128).
Repeating is disabled by default.

* *repeated* - True to repeat the texture, false to disable repeating

*See also:* `repeated?`

## SF::Texture#size()

Return the size of the texture

*Returns:* Size in pixels

## SF::Texture#smooth?()

Tell whether the smooth filter is enabled or not

*Returns:* True if smoothing is enabled, false if it is disabled

*See also:* `smooth=`

## SF::Texture#smooth=(smooth)

Enable or disable the smooth filter

When the filter is activated, the texture appears smoother
so that pixels are less noticeable. However if you want
the texture to look exactly the same as its source file,
you should leave it disabled.
The smooth filter is disabled by default.

* *smooth* - True to enable smoothing, false to disable it

*See also:* `smooth?`

## SF::Texture#srgb?()

Tell whether the texture source is converted from sRGB or not

*Returns:* True if the texture source is converted from sRGB, false if not

*See also:* `srgb=`

## SF::Texture#srgb=(s_rgb)

Enable or disable conversion from sRGB

When providing texture data from an image file or memory, it can
either be stored in a linear color space or an sRGB color space.
Most digital images account for gamma correction already, so they
would need to be "uncorrected" back to linear color space before
being processed by the hardware. The hardware can automatically
convert it from the sRGB color space to a linear color space when
it gets sampled. When the rendered image gets output to the final
framebuffer, it gets converted back to sRGB.

After enabling or disabling sRGB conversion, make sure to reload
the texture data in order for the setting to take effect.

This option is only useful in conjunction with an sRGB capable
framebuffer. This can be requested during window creation.

* *s_rgb* - True to enable sRGB conversion, false to disable it

*See also:* `srgb?`

## SF::Texture#swap(right)

Swap the contents of this texture with those of another

* *right* - Instance to swap with

## SF::Texture#update(image)

Update the texture from an image

Although the source image can be smaller than the texture,
this function is usually used for updating the whole texture.
The other overload, which has (x, y) additional arguments,
is more convenient for updating a sub-area of the texture.

No additional check is performed on the size of the image,
passing an image bigger than the texture will lead to an
undefined behavior.

This function does nothing if the texture was not
previously created.

* *image* - Image to copy to the texture

## SF::Texture#update(image,x,y)

Update a part of the texture from an image

No additional check is performed on the size of the image,
passing an invalid combination of image size and offset
will lead to an undefined behavior.

This function does nothing if the texture was not
previously created.

* *image* - Image to copy to the texture
* *x* - X offset in the texture where to copy the source image
* *y* - Y offset in the texture where to copy the source image

## SF::Texture#update(pixels)

Update the whole texture from an array of pixels

The *pixel* array is assumed to have the same size as
the *area* rectangle, and to contain 32-bits RGBA pixels.

No additional check is performed on the size of the pixel
array, passing invalid arguments will lead to an undefined
behavior.

This function does nothing if *pixels* is null or if the
texture was not previously created.

* *pixels* - Array of pixels to copy to the texture

## SF::Texture#update(pixels,width,height,x,y)

Update a part of the texture from an array of pixels

The size of the *pixel* array must match the *width* and
*height* arguments, and it must contain 32-bits RGBA pixels.

No additional check is performed on the size of the pixel
array or the bounds of the area to update, passing invalid
arguments will lead to an undefined behavior.

This function does nothing if *pixels* is null or if the
texture was not previously created.

* *pixels* - Array of pixels to copy to the texture
* *width* - Width of the pixel region contained in *pixels*
* *height* - Height of the pixel region contained in *pixels*
* *x* - X offset in the texture where to copy the source pixels
* *y* - Y offset in the texture where to copy the source pixels

## SF::Texture#update(texture)

Update a part of this texture from another texture

Although the source texture can be smaller than this texture,
this function is usually used for updating the whole texture.
The other overload, which has (x, y) additional arguments,
is more convenient for updating a sub-area of this texture.

No additional check is performed on the size of the passed
texture, passing a texture bigger than this texture
will lead to an undefined behavior.

This function does nothing if either texture was not
previously created.

* *texture* - Source texture to copy to this texture

## SF::Texture#update(texture,x,y)

Update a part of this texture from another texture

No additional check is performed on the size of the texture,
passing an invalid combination of texture size and offset
will lead to an undefined behavior.

This function does nothing if either texture was not
previously created.

* *texture* - Source texture to copy to this texture
* *x* - X offset in this texture where to copy the source texture
* *y* - Y offset in this texture where to copy the source texture

## SF::Texture#update(window)

Update the texture from the contents of a window

Although the source window can be smaller than the texture,
this function is usually used for updating the whole texture.
The other overload, which has (x, y) additional arguments,
is more convenient for updating a sub-area of the texture.

No additional check is performed on the size of the window,
passing a window bigger than the texture will lead to an
undefined behavior.

This function does nothing if either the texture or the window
was not previously created.

* *window* - Window to copy to the texture

## SF::Texture#update(window,x,y)

Update a part of the texture from the contents of a window

No additional check is performed on the size of the window,
passing an invalid combination of window size and offset
will lead to an undefined behavior.

This function does nothing if either the texture or the window
was not previously created.

* *window* - Window to copy to the texture
* *x* - X offset in the texture where to copy the source window
* *y* - Y offset in the texture where to copy the source window

# SF::Transform

Define a 3x3 transform matrix

A `SF::Transform` specifies how to translate, rotate, scale,
shear, project, whatever things. In mathematical terms, it defines
how to transform a coordinate system into another.

For example, if you apply a rotation transform to a sprite, the
result will be a rotated sprite. And anything that is transformed
by this rotation transform will be rotated the same way, according
to its initial position.

Transforms are typically used for drawing. But they can also be
used for any computation that requires to transform points between
the local and global coordinate systems of an entity (like collision
detection).

Example:
```
# define a translation transform
translation = SF::Transform.new
translation.translate(20, 50)

# define a rotation transform
rotation = SF::Transform.new
rotation.rotate(45)

# combine them
transform = translation * rotation

# use the result to transform stuff...
point = transform.transform_point(10, 20)
rect = transform.transform_rect(SF.float_rect(0, 0, 10, 100))
```

*See also:* `SF::Transformable`, `SF::RenderStates`

## SF::Transform#combine(transform)

Combine the current transform with another one

The result is a transform that is equivalent to applying
*this followed by *transform.* Mathematically, it is
equivalent to a matrix multiplication.

* *transform* - Transform to combine with this transform

*Returns:* Reference to *this

## SF::Transform#initialize()

Default constructor

Creates an identity transform (a transform that does nothing).

## SF::Transform#initialize(a00,a01,a02,a10,a11,a12,a20,a21,a22)

Construct a transform from a 3x3 matrix

* *a00* - Element (0, 0) of the matrix
* *a01* - Element (0, 1) of the matrix
* *a02* - Element (0, 2) of the matrix
* *a10* - Element (1, 0) of the matrix
* *a11* - Element (1, 1) of the matrix
* *a12* - Element (1, 2) of the matrix
* *a20* - Element (2, 0) of the matrix
* *a21* - Element (2, 1) of the matrix
* *a22* - Element (2, 2) of the matrix

## SF::Transform#initialize(copy)

:nodoc:

## SF::Transform#inverse()

Return the inverse of the transform

If the inverse cannot be computed, an identity transform
is returned.

*Returns:* A new transform which is the inverse of self

## SF::Transform#matrix()

Return the transform as a 4x4 matrix

This function returns a pointer to an array of 16 floats
containing the transform elements as a 4x4 matrix, which
is directly compatible with OpenGL functions.

```
transform = ...
glLoadMatrixf(transform.matrix())
```

*Returns:* Pointer to a 4x4 matrix

## SF::Transform#*(right)

Overload of binary operator * to combine two transforms

This call is equivalent to calling Transform(left).combine(right).

* *left* - Left operand (the first transform)
* *right* - Right operand (the second transform)

*Returns:* New combined transform

## SF::Transform#*(right)

Overload of binary operator * to transform a point

This call is equivalent to calling left.transform_point(right).

* *left* - Left operand (the transform)
* *right* - Right operand (the point to transform)

*Returns:* New transformed point

## SF::Transform#==(right)

Overload of binary operator == to compare two transforms

Performs an element-wise comparison of the elements of the
left transform with the elements of the right transform.

* *left* - Left operand (the first transform)
* *right* - Right operand (the second transform)

*Returns:* true if the transforms are equal, false otherwise

## SF::Transform#!=(right)

Overload of binary operator != to compare two transforms

This call is equivalent to !(left == right).

* *left* - Left operand (the first transform)
* *right* - Right operand (the second transform)

*Returns:* true if the transforms are not equal, false otherwise

## SF::Transform#rotate(angle)

Combine the current transform with a rotation

This function returns a reference to *this, so that calls
can be chained.
```
transform = SF::Transform.new
transform.rotate(90).translate(50, 20)
```

* *angle* - Rotation angle, in degrees

*Returns:* Reference to *this

*See also:* `translate`, `scale`

## SF::Transform#rotate(angle,center)

Combine the current transform with a rotation

The center of rotation is provided for convenience as a second
argument, so that you can build rotations around arbitrary points
more easily (and efficiently) than the usual
translate(-center).rotate(angle).translate(center).

This function returns a reference to *this, so that calls
can be chained.
```
transform = SF::Transform.new
transform.rotate(90, SF.vector2f(8, 3)).translate(SF.vector2f(50, 20))
```

* *angle* - Rotation angle, in degrees
* *center* - Center of rotation

*Returns:* Reference to *this

*See also:* `translate`, `scale`

## SF::Transform#rotate(angle,center_x,center_y)

Combine the current transform with a rotation

The center of rotation is provided for convenience as a second
argument, so that you can build rotations around arbitrary points
more easily (and efficiently) than the usual
translate(-center).rotate(angle).translate(center).

This function returns a reference to *this, so that calls
can be chained.
```
transform = SF::Transform.new
transform.rotate(90, 8, 3).translate(50, 20)
```

* *angle* - Rotation angle, in degrees
* *center_x* - X coordinate of the center of rotation
* *center_y* - Y coordinate of the center of rotation

*Returns:* Reference to *this

*See also:* `translate`, `scale`

## SF::Transform#scale(factors)

Combine the current transform with a scaling

This function returns a reference to *this, so that calls
can be chained.
```
transform = SF::Transform.new
transform.scale(SF.vector2f(2, 1)).rotate(45)
```

* *factors* - Scaling factors

*Returns:* Reference to *this

*See also:* `translate`, `rotate`

## SF::Transform#scale(factors,center)

Combine the current transform with a scaling

The center of scaling is provided for convenience as a second
argument, so that you can build scaling around arbitrary points
more easily (and efficiently) than the usual
translate(-center).scale(factors).translate(center).

This function returns a reference to *this, so that calls
can be chained.
```
transform = SF::Transform.new
transform.scale(SF.vector2f(2, 1), SF.vector2f(8, 3)).rotate(45)
```

* *factors* - Scaling factors
* *center* - Center of scaling

*Returns:* Reference to *this

*See also:* `translate`, `rotate`

## SF::Transform#scale(scale_x,scale_y)

Combine the current transform with a scaling

This function returns a reference to *this, so that calls
can be chained.
```
transform = SF::Transform.new
transform.scale(2, 1).rotate(45)
```

* *scale_x* - Scaling factor on the X axis
* *scale_y* - Scaling factor on the Y axis

*Returns:* Reference to *this

*See also:* `translate`, `rotate`

## SF::Transform#scale(scale_x,scale_y,center_x,center_y)

Combine the current transform with a scaling

The center of scaling is provided for convenience as a second
argument, so that you can build scaling around arbitrary points
more easily (and efficiently) than the usual
translate(-center).scale(factors).translate(center).

This function returns a reference to *this, so that calls
can be chained.
```
transform = SF::Transform.new
transform.scale(2, 1, 8, 3).rotate(45)
```

* *scale_x* - Scaling factor on X axis
* *scale_y* - Scaling factor on Y axis
* *center_x* - X coordinate of the center of scaling
* *center_y* - Y coordinate of the center of scaling

*Returns:* Reference to *this

*See also:* `translate`, `rotate`

## SF::Transform#transform_point(point)

Transform a 2D point

* *point* - Point to transform

*Returns:* Transformed point

## SF::Transform#transform_point(x,y)

Transform a 2D point

* *x* - X coordinate of the point to transform
* *y* - Y coordinate of the point to transform

*Returns:* Transformed point

## SF::Transform#transform_rect(rectangle)

Transform a rectangle

Since SFML doesn't provide support for oriented rectangles,
the result of this function is always an axis-aligned
rectangle. Which means that if the transform contains a
rotation, the bounding rectangle of the transformed rectangle
is returned.

* *rectangle* - Rectangle to transform

*Returns:* Transformed rectangle

## SF::Transform#translate(offset)

Combine the current transform with a translation

This function returns a reference to *this, so that calls
can be chained.
```
transform = SF::Transform.new
transform.translate(SF.vector2f(100, 200)).rotate(45)
```

* *offset* - Translation offset to apply

*Returns:* Reference to *this

*See also:* `rotate`, `scale`

## SF::Transform#translate(x,y)

Combine the current transform with a translation

This function returns a reference to *this, so that calls
can be chained.
```
transform = SF::Transform.new
transform.translate(100, 200).rotate(45)
```

* *x* - Offset to apply on X axis
* *y* - Offset to apply on Y axis

*Returns:* Reference to *this

*See also:* `rotate`, `scale`

# SF::Transformable

Decomposed transform defined by a position, a rotation and a scale

This class is provided for convenience, on top of `SF::Transform`.

`SF::Transform`, as a low-level class, offers a great level of
flexibility but it is not always convenient to manage. Indeed,
one can easily combine any kind of operation, such as a translation
followed by a rotation followed by a scaling, but once the result
transform is built, there's no way to go backward and, let's say,
change only the rotation without modifying the translation and scaling.
The entire transform must be recomputed, which means that you
need to retrieve the initial translation and scale factors as
well, and combine them the same way you did before updating the
rotation. This is a tedious operation, and it requires to store
all the individual components of the final transform.

That's exactly what `SF::Transformable` was written for: it hides
these variables and the composed transform behind an easy to use
interface. You can set or get any of the individual components
without worrying about the others. It also provides the composed
transform (as a `SF::Transform`), and keeps it up-to-date.

In addition to the position, rotation and scale, `SF::Transformable`
provides an "origin" component, which represents the local origin
of the three other components. Let's take an example with a 10x10
pixels sprite. By default, the sprite is positioned/rotated/scaled
relatively to its top-left corner, because it is the local point
(0, 0). But if we change the origin to be (5, 5), the sprite will
be positioned/rotated/scaled around its center instead. And if
we set the origin to (10, 10), it will be transformed around its
bottom-right corner.

To keep the `SF::Transformable` class simple, there's only one
origin for all the components. You cannot position the sprite
relatively to its top-left corner while rotating it around its
center, for example. To do such things, use `SF::Transform` directly.

`SF::Transformable` can be used as a base class. It is often
combined with `SF::Drawable` -- that's what SFML's sprites,
texts and shapes do.
```
class MyEntity < SF::Transformable
  include SF::Drawable

  def draw(target, states)
    states.transform *= self.transform
    target.draw(..., states)
  end
end

entity = MyEntity.new
entity.position = {10, 20}
entity.rotation = 45
window.draw entity
```

It can also be used as a member, if you don't want to use
its API directly (because you don't need all its functions,
or you have different naming conventions for example).
```
class MyEntity
  @transform : SF::Transformable
  forward_missing_to @transform
end
```

A note on coordinates and undistorted rendering:
By default, SFML (or more exactly, OpenGL) may interpolate drawable objects
such as sprites or texts when rendering. While this allows transitions
like slow movements or rotations to appear smoothly, it can lead to
unwanted results in some cases, for example blurred or distorted objects.
In order to render a `SF::Drawable` object pixel-perfectly, make sure
the involved coordinates allow a 1:1 mapping of pixels in the window
to texels (pixels in the texture). More specifically, this means:
* The object's position, origin and scale have no fractional part
* The object's and the view's rotation are a multiple of 90 degrees
* The view's center and size have no fractional part

*See also:* `SF::Transform`

## SF::Transformable#finalize()

Virtual destructor

## SF::Transformable#initialize()

Default constructor

## SF::Transformable#initialize(copy)

:nodoc:

## SF::Transformable#inverse_transform()

get the inverse of the combined transform of the object

*Returns:* Inverse of the combined transformations applied to the object

*See also:* `transform`

## SF::Transformable#move(offset)

Move the object by a given offset

This function adds to the current position of the object,
unlike position= which overwrites it.
Thus, it is equivalent to the following code:
```
object.position += offset
```

* *offset* - Offset

*See also:* `position=`

## SF::Transformable#move(offset_x,offset_y)

Move the object by a given offset

This function adds to the current position of the object,
unlike position= which overwrites it.
Thus, it is equivalent to the following code:
```
pos = object.position
object.set_position(pos.x + offset_x, pos.y + offset_y)
```

* *offset_x* - X offset
* *offset_y* - Y offset

*See also:* `position=`

## SF::Transformable#origin()

get the local origin of the object

*Returns:* Current origin

*See also:* `origin=`

## SF::Transformable#origin=(origin)

set the local origin of the object

The origin of an object defines the center point for
all transformations (position, scale, rotation).
The coordinates of this point must be relative to the
top-left corner of the object, and ignore all
transformations (position, scale, rotation).
The default origin of a transformable object is (0, 0).

* *origin* - New origin

*See also:* `origin`

## SF::Transformable#position()

get the position of the object

*Returns:* Current position

*See also:* `position=`

## SF::Transformable#position=(position)

set the position of the object

This function completely overwrites the previous position.
See the move function to apply an offset based on the previous position instead.
The default position of a transformable object is (0, 0).

* *position* - New position

*See also:* `move`, `position`

## SF::Transformable#rotate(angle)

Rotate the object

This function adds to the current rotation of the object,
unlike rotation= which overwrites it.
Thus, it is equivalent to the following code:
```
object.rotation += angle
```

* *angle* - Angle of rotation, in degrees

## SF::Transformable#rotation()

get the orientation of the object

The rotation is always in the range `0.0 ... 360.0`

*Returns:* Current rotation, in degrees

*See also:* `rotation=`

## SF::Transformable#rotation=(angle)

set the orientation of the object

This function completely overwrites the previous rotation.
See the rotate function to add an angle based on the previous rotation instead.
The default rotation of a transformable object is 0.

* *angle* - New rotation, in degrees

*See also:* `rotate`, `rotation`

## SF::Transformable#scale()

get the current scale of the object

*Returns:* Current scale factors

*See also:* `scale=`

## SF::Transformable#scale(factor)

Scale the object

This function multiplies the current scale of the object,
unlike scale= which overwrites it.
Thus, it is equivalent to the following code:
```
scale = object.scale
object.scale = {scale.x * factor.x, scale.y * factor.y}
```

* *factor* - Scale factors

*See also:* `scale=`

## SF::Transformable#scale(factor_x,factor_y)

Scale the object

This function multiplies the current scale of the object,
unlike scale= which overwrites it.
Thus, it is equivalent to the following code:
```
scale = object.scale
object.set_scale(scale.x * factor_x, scale.y * factor_y)
```

* *factor_x* - Horizontal scale factor
* *factor_y* - Vertical scale factor

*See also:* `scale=`

## SF::Transformable#scale=(factors)

set the scale factors of the object

This function completely overwrites the previous scale.
See the scale function to add a factor based on the previous scale instead.
The default scale of a transformable object is (1, 1).

* *factors* - New scale factors

*See also:* `scale`, `scale`

## SF::Transformable#set_origin(x,y)

set the local origin of the object

The origin of an object defines the center point for
all transformations (position, scale, rotation).
The coordinates of this point must be relative to the
top-left corner of the object, and ignore all
transformations (position, scale, rotation).
The default origin of a transformable object is (0, 0).

* *x* - X coordinate of the new origin
* *y* - Y coordinate of the new origin

*See also:* `origin`

## SF::Transformable#set_position(x,y)

set the position of the object

This function completely overwrites the previous position.
See the move function to apply an offset based on the previous position instead.
The default position of a transformable object is (0, 0).

* *x* - X coordinate of the new position
* *y* - Y coordinate of the new position

*See also:* `move`, `position`

## SF::Transformable#set_scale(factor_x,factor_y)

set the scale factors of the object

This function completely overwrites the previous scale.
See the scale function to add a factor based on the previous scale instead.
The default scale of a transformable object is (1, 1).

* *factor_x* - New horizontal scale factor
* *factor_y* - New vertical scale factor

*See also:* `scale`, `scale`

## SF::Transformable#transform()

get the combined transform of the object

*Returns:* Transform combining the position/rotation/scale/origin of the object

*See also:* `inverse_transform`

# SF::Vertex

Define a point with color and texture coordinates

A vertex is an improved point. It has a position and other
extra attributes that will be used for drawing: in SFML,
vertices also have a color and a pair of texture coordinates.

The vertex is the building block of drawing. Everything which
is visible on screen is made of vertices. They are grouped
as 2D primitives (triangles, quads, ...), and these primitives
are grouped to create even more complex 2D entities such as
sprites, texts, etc.

If you use the graphical entities of SFML (sprite, text, shape)
you won't have to deal with vertices directly. But if you want
to define your own 2D entities, such as tiled maps or particle
systems, using vertices will allow you to get maximum performances.

Example:
```
# define a 100x100 square, red, with a 10x10 texture mapped on it
vertices = [
  SF::Vertex.new(SF.vector2f(  0,   0), SF::Color::Red, SF.vector2f( 0,  0)),
  SF::Vertex.new(SF.vector2f(  0, 100), SF::Color::Red, SF.vector2f( 0, 10)),
  SF::Vertex.new(SF.vector2f(100, 100), SF::Color::Red, SF.vector2f(10, 10)),
  SF::Vertex.new(SF.vector2f(100,   0), SF::Color::Red, SF.vector2f(10,  0)),
]

# draw it
window.draw(vertices, SF::Quads)
```

Note: although texture coordinates are supposed to be an integer
amount of pixels, their type is float because of some buggy graphics
drivers that are not able to process integer coordinates correctly.

*See also:* `SF::VertexArray`

## SF::Vertex#color()

Color of the vertex

## SF::Vertex#initialize()

Default constructor

## SF::Vertex#initialize(copy)

:nodoc:

## SF::Vertex#initialize(position)

Construct the vertex from its position

The vertex color is white and texture coordinates are (0, 0).

* *position* - Vertex position

## SF::Vertex#initialize(position,color)

Construct the vertex from its position and color

The texture coordinates are (0, 0).

* *position* - Vertex position
* *color* - Vertex color

## SF::Vertex#initialize(position,color,tex_coords)

Construct the vertex from its position, color and texture coordinates

* *position* - Vertex position
* *color* - Vertex color
* *tex_coords* - Vertex texture coordinates

## SF::Vertex#initialize(position,tex_coords)

Construct the vertex from its position and texture coordinates

The vertex color is white.

* *position* - Vertex position
* *tex_coords* - Vertex texture coordinates

## SF::Vertex#position()

2D position of the vertex

## SF::Vertex#tex_coords()

Coordinates of the texture's pixel to map to the vertex

# SF::VertexArray

Define a set of one or more 2D primitives

`SF::VertexArray` is a very simple wrapper around a dynamic
array of vertices and a primitives type.

It includes `SF::Drawable`, but unlike other drawables it
is not transformable.

Example:
```
lines = SF::VertexArray.new(SF::LineStrip, 4)
lines[0] = SF::Vertex.new(SF.vector2f(10, 0))
lines[1] = SF::Vertex.new(SF.vector2f(20, 0))
lines[2] = SF::Vertex.new(SF.vector2f(30, 5))
lines[3] = SF::Vertex.new(SF.vector2f(40, 2))

window.draw(lines)
```

*See also:* `SF::Vertex`

## SF::VertexArray#append(vertex)

Add a vertex to the array

* *vertex* - Vertex to add

## SF::VertexArray#bounds()

Compute the bounding rectangle of the vertex array

This function returns the minimal axis-aligned rectangle
that contains all the vertices of the array.

*Returns:* Bounding rectangle of the vertex array

## SF::VertexArray#clear()

Clear the vertex array

This function removes all the vertices from the array.
It doesn't deallocate the corresponding memory, so that
adding new vertices after clearing doesn't involve
reallocating all the memory.

## SF::VertexArray#draw(target,states)

:nodoc:

## SF::VertexArray#draw(target,states)

:nodoc:

## SF::VertexArray#draw(target,states)

:nodoc:

## SF::VertexArray#[](index)

Get the vertex by its index

This method doesn't check *index*, it must be in range
`0 ... vertex_count`. The behavior is undefined otherwise.

* *index* - Index of the vertex to get

*Returns:* The index-th vertex

*See also:* `vertex_count`

## SF::VertexArray#[]=(index,value)

Set the vertex by its index

This method doesn't check *index*, it must be in range
`0 ... vertex_count`. The behavior is undefined otherwise.

* *index* - Index of the vertex to set

*See also:* `vertex_count`

## SF::VertexArray#initialize()

Default constructor

Creates an empty vertex array.

## SF::VertexArray#initialize(copy)

:nodoc:

## SF::VertexArray#initialize(type,vertex_count)

Construct the vertex array with a type and an initial number of vertices

* *type* - Type of primitives
* *vertex_count* - Initial number of vertices in the array

## SF::VertexArray#primitive_type()

Get the type of primitives drawn by the vertex array

*Returns:* Primitive type

## SF::VertexArray#primitive_type=(type)

Set the type of primitives to draw

This function defines how the vertices must be interpreted
when it's time to draw them:

* As points
* As lines
* As triangles
* As quads
The default primitive type is `SF::Points`.

* *type* - Type of primitive

## SF::VertexArray#resize(vertex_count)

Resize the vertex array

If *vertex_count* is greater than the current size, the previous
vertices are kept and new (default-constructed) vertices are
added.
If *vertex_count* is less than the current size, existing vertices
are removed from the array.

* *vertex_count* - New size of the array (number of vertices)

## SF::VertexArray#vertex_count()

Return the vertex count

*Returns:* Number of vertices in the array

# SF::VertexBuffer

Vertex buffer storage for one or more 2D primitives

`SF::VertexBuffer` is a simple wrapper around a dynamic
buffer of vertices and a primitives type.

Unlike `SF::VertexArray`, the vertex data is stored in
graphics memory.

In situations where a large amount of vertex data would
have to be transferred from system memory to graphics memory
every frame, using `SF::VertexBuffer` can help. By using a
`SF::VertexBuffer`, data that has not been changed between frames
does not have to be re-transferred from system to graphics
memory as would be the case with `SF::VertexArray`. If data transfer
is a bottleneck, this can lead to performance gains.

Using `SF::VertexBuffer`, the user also has the ability to only modify
a portion of the buffer in graphics memory. This way, a large buffer
can be allocated at the start of the application and only the
applicable portions of it need to be updated during the course of
the application. This allows the user to take full control of data
transfers between system and graphics memory if they need to.

In special cases, the user can make use of multiple threads to update
vertex data in multiple distinct regions of the buffer simultaneously.
This might make sense when e.g. the position of multiple objects has to
be recalculated very frequently. The computation load can be spread
across multiple threads as long as there are no other data dependencies.

Simultaneous updates to the vertex buffer are not guaranteed to be
carried out by the driver in any specific order. Updating the same
region of the buffer from multiple threads will not cause undefined
behaviour, however the final state of the buffer will be unpredictable.

Simultaneous updates of distinct non-overlapping regions of the buffer
are also not guaranteed to complete in a specific order. However, in
this case the user can make sure to synchronize the writer threads at
well-defined points in their code. The driver will make sure that all
pending data transfers complete before the vertex buffer is sourced
by the rendering pipeline.

It inherits `SF::Drawable`, but unlike other drawables it
is not transformable.

Example:
```c++
sf::Vertex vertices[15];
...
sf::VertexBuffer triangles(sf::Triangles);
triangles.create(15);
triangles.update(vertices);
...
window.draw(triangles);
```

*See also:* `SF::Vertex`, `SF::VertexArray`

## SF::VertexBuffer::Usage

Usage specifiers

If data is going to be updated once or more every frame,
set the usage to Stream. If data is going to be set once
and used for a long time without being modified, set the
usage to Static. For everything else Dynamic should be a
good compromise.

### SF::VertexBuffer::Usage::Dynamic

Occasionally changing data

### SF::VertexBuffer::Usage::Static

Rarely changing data

### SF::VertexBuffer::Usage::Stream

Constantly changing data

## SF::VertexBuffer.available?()

Tell whether or not the system supports vertex buffers

This function should always be called before using
the vertex buffer features. If it returns false, then
any attempt to use `SF::VertexBuffer` will fail.

*Returns:* True if vertex buffers are supported, false otherwise

## SF::VertexBuffer.bind(vertex_buffer)

Bind a vertex buffer for rendering

This function is not part of the graphics API, it mustn't be
used when drawing SFML entities. It must be used only if you
mix `SF::VertexBuffer` with OpenGL code.

```c++
sf::VertexBuffer vb1, vb2;
...
sf::VertexBuffer::bind(&vb1);
// draw OpenGL stuff that use vb1...
sf::VertexBuffer::bind(&vb2);
// draw OpenGL stuff that use vb2...
sf::VertexBuffer::bind(NULL);
// draw OpenGL stuff that use no vertex buffer...
```

* *vertex_buffer* - Pointer to the vertex buffer to bind, can be null to use no vertex buffer

## SF::VertexBuffer#create(vertex_count)

Create the vertex buffer

Creates the vertex buffer and allocates enough graphics
memory to hold \p vertex_count vertices. Any previously
allocated memory is freed in the process.

In order to deallocate previously allocated memory pass 0
as \p vertex_count. Don't forget to recreate with a non-zero
value when graphics memory should be allocated again.

* *vertex_count* - Number of vertices worth of memory to allocate

*Returns:* True if creation was successful

## SF::VertexBuffer#draw(target,states)

:nodoc:

## SF::VertexBuffer#draw(target,states)

:nodoc:

## SF::VertexBuffer#draw(target,states)

:nodoc:

## SF::VertexBuffer#finalize()

Destructor

## SF::VertexBuffer#initialize()

Default constructor

Creates an empty vertex buffer.

## SF::VertexBuffer#initialize(copy)

:nodoc:

## SF::VertexBuffer#initialize(type)

Construct a VertexBuffer with a specific PrimitiveType

Creates an empty vertex buffer and sets its primitive type to \p type.

* *type* - Type of primitive

## SF::VertexBuffer#initialize(type,usage)

Construct a VertexBuffer with a specific PrimitiveType and usage specifier

Creates an empty vertex buffer and sets its primitive type
to \p type and usage to \p usage.

* *type* - Type of primitive
* *usage* - Usage specifier

## SF::VertexBuffer#initialize(usage)

Construct a VertexBuffer with a specific usage specifier

Creates an empty vertex buffer and sets its usage to \p usage.

* *usage* - Usage specifier

## SF::VertexBuffer#native_handle()

Get the underlying OpenGL handle of the vertex buffer.

You shouldn't need to use this function, unless you have
very specific stuff to implement that SFML doesn't support,
or implement a temporary workaround until a bug is fixed.

*Returns:* OpenGL handle of the vertex buffer or 0 if not yet created

## SF::VertexBuffer#primitive_type()

Get the type of primitives drawn by the vertex buffer

*Returns:* Primitive type

## SF::VertexBuffer#primitive_type=(type)

Set the type of primitives to draw

This function defines how the vertices must be interpreted
when it's time to draw them.

The default primitive type is `SF::Points`.

* *type* - Type of primitive

## SF::VertexBuffer#swap(right)

Swap the contents of this vertex buffer with those of another

* *right* - Instance to swap with

## SF::VertexBuffer#update(vertex_buffer)

Copy the contents of another buffer into this buffer

* *vertex_buffer* - Vertex buffer whose contents to copy into this vertex buffer

*Returns:* True if the copy was successful

## SF::VertexBuffer#update(vertices)

Update the whole buffer from an array of vertices

The *vertex* array is assumed to have the same size as
the *created* buffer.

No additional check is performed on the size of the vertex
array, passing invalid arguments will lead to undefined
behavior.

This function does nothing if *vertices* is null or if the
buffer was not previously created.

* *vertices* - Array of vertices to copy to the buffer

*Returns:* True if the update was successful

## SF::VertexBuffer#update(vertices,offset)

Update a part of the buffer from an array of vertices

\p offset is specified as the number of vertices to skip
from the beginning of the buffer.

If \p offset is 0 and \p vertex_count is equal to the size of
the currently created buffer, its whole contents are replaced.

If \p offset is 0 and \p vertex_count is greater than the
size of the currently created buffer, a new buffer is created
containing the vertex data.

If \p offset is 0 and \p vertex_count is less than the size of
the currently created buffer, only the corresponding region
is updated.

If \p offset is not 0 and \p offset + \p vertex_count is greater
than the size of the currently created buffer, the update fails.

No additional check is performed on the size of the vertex
array, passing invalid arguments will lead to undefined
behavior.

* *vertices* - Array of vertices to copy to the buffer
* *vertex_count* - Number of vertices to copy
* *offset* - Offset in the buffer to copy to

*Returns:* True if the update was successful

## SF::VertexBuffer#usage()

Get the usage specifier of this vertex buffer

*Returns:* Usage specifier

## SF::VertexBuffer#usage=(usage)

Set the usage specifier of this vertex buffer

This function provides a hint about how this vertex buffer is
going to be used in terms of data update frequency.

After changing the usage specifier, the vertex buffer has
to be updated with new data for the usage specifier to
take effect.

The default primitive type is `SF::VertexBuffer::Stream`.

* *usage* - Usage specifier

## SF::VertexBuffer#vertex_count()

Return the vertex count

*Returns:* Number of vertices in the vertex buffer

# SF::View

2D camera that defines what region is shown on screen

`SF::View` defines a camera in the 2D scene. This is a
very powerful concept: you can scroll, rotate or zoom
the entire scene without altering the way that your
drawable objects are drawn.

A view is composed of a source rectangle, which defines
what part of the 2D scene is shown, and a target viewport,
which defines where the contents of the source rectangle
will be displayed on the render target (window or texture).

The viewport allows to map the scene to a custom part
of the render target, and can be used for split-screen
or for displaying a minimap, for example. If the source
rectangle doesn't have the same size as the viewport, its
contents will be stretched to fit in.

To apply a view, you have to assign it to the render target.
Then, objects drawn in this render target will be
affected by the view until you use another view.

Usage example:
```
window = SF::RenderWindow.new
view = SF::View.new

# Initialize the view to a rectangle located at (100, 100) and with a size of 400x200
view.reset(SF.float_rect(100, 100, 400, 200))

# Rotate it by 45 degrees
view.rotate(45)

# Set its target viewport to be half of the window
view.viewport = SF.float_rect(0.0, 0.0, 0.5, 1.0)

# Apply it
window.view = view

# Render stuff
window.draw some_sprite

# Set the default view back
window.view = window.default_view

# Render stuff not affected by the view
window.draw some_text
```

See also the note on coordinates and undistorted rendering in `SF::Transformable`.

*See also:* `SF::RenderWindow`, `SF::RenderTexture`

## SF::View#center()

Get the center of the view

*Returns:* Center of the view

*See also:* `size`, `center=`

## SF::View#center=(center)

Set the center of the view

* *center* - New center

*See also:* `size=`, `center`

## SF::View#initialize()

Default constructor

This constructor creates a default view of (0, 0, 1000, 1000)

## SF::View#initialize(center,size)

Construct the view from its center and size

* *center* - Center of the zone to display
* *size* - Size of zone to display

## SF::View#initialize(copy)

:nodoc:

## SF::View#initialize(rectangle)

Construct the view from a rectangle

* *rectangle* - Rectangle defining the zone to display

## SF::View#inverse_transform()

Get the inverse projection transform of the view

This function is meant for internal use only.

*Returns:* Inverse of the projection transform defining the view

*See also:* `transform`

## SF::View#move(offset)

Move the view relatively to its current position

* *offset* - Move offset

*See also:* `center=`, `rotate`, `zoom`

## SF::View#move(offset_x,offset_y)

Move the view relatively to its current position

* *offset_x* - X coordinate of the move offset
* *offset_y* - Y coordinate of the move offset

*See also:* `center=`, `rotate`, `zoom`

## SF::View#reset(rectangle)

Reset the view to the given rectangle

Note that this function resets the rotation angle to 0.

* *rectangle* - Rectangle defining the zone to display

*See also:* `center=`, `size=`, `rotation=`

## SF::View#rotate(angle)

Rotate the view relatively to its current orientation

* *angle* - Angle to rotate, in degrees

*See also:* `rotation=`, `move`, `zoom`

## SF::View#rotation()

Get the current orientation of the view

*Returns:* Rotation angle of the view, in degrees

*See also:* `rotation=`

## SF::View#rotation=(angle)

Set the orientation of the view

The default rotation of a view is 0 degree.

* *angle* - New angle, in degrees

*See also:* `rotation`

## SF::View#set_center(x,y)

Set the center of the view

* *x* - X coordinate of the new center
* *y* - Y coordinate of the new center

*See also:* `size=`, `center`

## SF::View#set_size(width,height)

Set the size of the view

* *width* - New width of the view
* *height* - New height of the view

*See also:* `center=`, `center`

## SF::View#size()

Get the size of the view

*Returns:* Size of the view

*See also:* `center`, `size=`

## SF::View#size=(size)

Set the size of the view

* *size* - New size

*See also:* `center=`, `center`

## SF::View#transform()

Get the projection transform of the view

This function is meant for internal use only.

*Returns:* Projection transform defining the view

*See also:* `inverse_transform`

## SF::View#viewport()

Get the target viewport rectangle of the view

*Returns:* Viewport rectangle, expressed as a factor of the target size

*See also:* `viewport=`

## SF::View#viewport=(viewport)

Set the target viewport

The viewport is the rectangle into which the contents of the
view are displayed, expressed as a factor (between 0 and 1)
of the size of the RenderTarget to which the view is applied.
For example, a view which takes the left side of the target would
be defined with View.viewport=(`SF::FloatRect`(0, 0, 0.5, 1)).
By default, a view has a viewport which covers the entire target.

* *viewport* - New viewport rectangle

*See also:* `viewport`

## SF::View#zoom(factor)

Resize the view rectangle relatively to its current size

Resizing the view simulates a zoom, as the zone displayed on
screen grows or shrinks.
*factor* is a multiplier:

* 1 keeps the size unchanged
* &gt; 1 makes the view bigger (objects appear smaller)
* &lt; 1 makes the view smaller (objects appear bigger)

* *factor* - Zoom factor to apply

*See also:* `size=`, `move`, `rotate`
