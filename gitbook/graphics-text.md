# Text and fonts

## Loading a font

Before drawing any text, you need to have an available font, just like any other program that prints text. Fonts are encapsulated in the [Font]({{book.api}}/Font.html) class, which provides three main features: loading a font, getting glyphs (i.e. visual characters) from it, and reading its attributes. In a typical program, you'll only have to make use of the first feature, loading the font, so let's focus on that first.

The most common way of loading a font is from a file on disk, which is done with the `from_file` function.

```ruby
font = SF::Font.from_file("DejaVuSans.ttf")
```

Note that CrSFML won't load your system fonts automatically, i.e. `SF::Font.from_file("Courier New")` won't work. Firstly, because CrSFML requires *file names*, not font names, and secondly because CrSFML doesn't have magical access to your system's font folder. If you want to load a font, you will need to include the font file with your application, just like every other resource (images, sounds, ...).

The `from_file` function can sometimes fail with no obvious reason. First, check the error message that CrSFML prints to the standard output (check the console). If the message is unable to open file, make sure that the *working directory* (which is the directory that any file path will be interpreted relative to) is what you think it is: When you run the application from your desktop environment, the working directory is the executable folder. However, when you launch your program from your IDE (Visual Studio, Code::Blocks, ...) the working directory might sometimes be set to the *project* directory instead. This can usually be changed quite easily in the project settings.

You can also load a font file from memory (`loadFromMemory`), or from a [custom input stream](system-stream.md "Input streams tutorial") (`loadFromStream`).

CrSFML supports most common font formats. The full list is available in the API documentation.

That's all you need to do. Once your font is loaded, you can start drawing text.

## Drawing text

To draw text, you will be using the [Text]({{book.api}}/Text.html) class. It's very simple to use:

```ruby
text = SF::Text.new

# select the font
text.font = font # font is a SF::Font

# set the string to display
text.string = "Hello world"

# set the character size
text.character_size = 24 # in pixels, not points!

# set the color
text.color = SF::Color::Red

# set the text style
text.style = (SF::Text::Bold | SF::Text::Underlined)

...

# inside the main loop, between window.clear() and window.display()
window.draw(text)
```

![](./images/graphics-text-draw.png)

Text can also be transformed: They have a position, an orientation and a scale. The functions involved are the same as for the [Sprite]({{book.api}}/Sprite.html) class and other CrSFML entities. They are explained in the [Transforming entities](graphics-transform.md "'Transforming entities' tutorial") tutorial.

## Making your own text class

If [Text]({{book.api}}/Text.html) is too limited, or if you want to do something else with pre-rendered glyphs, [Font]({{book.api}}/Font.html) provides everything that you need.

You can retrieve the texture which contains all the pre-rendered glyphs of a certain size:

```ruby
texture = font.get_texture(character_size)
```

It is important to note that glyphs are added to the texture when they are requested. There are so many characters (remember, more than 100000) that they can't all be generated when you load the font. Instead, they are rendered on the fly when you call the `get_glyph` function (see below).

To do something meaningful with the font texture, you must get the texture coordinates of glyphs that are contained in it:

```ruby
glyph = font.get_glyph(character, character_size, bold)
```

`character` is the character, the glyph of which you want to get. You must also specify the character size, and whether you want the bold or the regular version of the glyph.

The [Glyph]({{book.api}}/Glyph.html) structure contains three members:

* `texture_rect` contains the texture coordinates of the glyph within the texture
* `bounds` contains the bounding rectangle of the glyph, which helps position it relative to the baseline of the text
* `advance` is the horizontal offset to apply to get the starting position of the next glyph in the text

You can also get some of the font's other metrics, such as the kerning between two characters or the line spacing (always for a certain character size):

```ruby
line_spacing = font.get_line_spacing(character_size)

kerning = font.get_kerning(character_1, character_2, character_size)
```

