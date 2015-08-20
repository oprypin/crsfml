# Text and fonts

## Loading a font

Before drawing any text, you need to have an available font, just like any other program that prints text. Fonts are encapsulated in the [Font]({{book.api}}/Font.html) class, which provides three main features: loading a font, getting glyphs (i.e. visual characters) from it, and reading its attributes. In a typical program, you'll only have to make use of the first feature, loading the font, so let's focus on that first. 

The most common way of loading a font is from a file on disk, which is done with the `loadFromFile` function. 

```
sf::Font font;
if (!font.loadFromFile("arial.ttf"))
{
    // error...
}
```

Note that SFML won't load your system fonts automatically, i.e. `font.loadFromFile("Courier New")` won't work. Firstly, because SFML requires *file names*, not font names, and secondly because SFML doesn't have magical access to your system's font folder. If you want to load a font, you will need to include the font file with your application, just like every other resource (images, sounds, ...). 

The `loadFromFile` function can sometimes fail with no obvious reason. First, check the error message that SFML prints to the standard output (check the console). If the message is unable to open file, make sure that the *working directory* (which is the directory that any file path will be interpreted relative to) is what you think it is: When you run the application from your desktop environment, the working directory is the executable folder. However, when you launch your program from your IDE (Visual Studio, Code::Blocks, ...) the working directory might sometimes be set to the *project* directory instead. This can usually be changed quite easily in the project settings. 

You can also load a font file from memory (`loadFromMemory`), or from a [custom input stream](./system-stream.html "Input streams tutorial") (`loadFromStream`). 

SFML supports most common font formats. The full list is available in the API documentation. 

That's all you need to do. Once your font is loaded, you can start drawing text. 

## Drawing text

To draw text, you will be using the [Text]({{book.api}}/Text.html) class. It's very simple to use: 

```
sf::Text text;

// select the font
text.setFont(font); // font is a sf::Font

// set the string to display
text.setString("Hello world");

// set the character size
text.setCharacterSize(24); // in pixels, not points!

// set the color
text.setColor(sf::Color::Red);

// set the text style
text.setStyle(sf::Text::Bold | sf::Text::Underlined);

...

// inside the main loop, between window.clear() and window.display()
window.draw(text);
```

![](./images/graphics-text-draw.png)

Text can also be transformed: They have a position, an orientation and a scale. The functions involved are the same as for the [Sprite]({{book.api}}/Sprite.html) class and other SFML entities. They are explained in the [Transforming entities](./graphics-transform.html "'Transforming entities' tutorial") tutorial. 

## How to avoid problems with non-ASCII characters?

Handling non-ASCII characters (such as accented European, Arabic, or Chinese characters) correctly can be tricky. It requires a good understanding of the various encodings involved in the process of interpreting and drawing your text. To avoid having to bother with these encodings, there's a simple solution: Use *wide literal strings*. 

```
text.setString(L"יטאח");
```

It is this simple "L" prefix in front of the string that makes it work by telling the compiler to produce a wide string. Wide strings are a strange beast in C++: the standard doesn't say anything about their size (16-bit? 32-bit?), nor about the encoding that they use (UTF-16? UTF-32?). However we know that on most platforms, if not all, they'll produce Unicode strings, and SFML knows how to handle them correctly. 

Note that the C++11 standard supports new character types and prefixes to build UTF-8, UTF-16 and UTF-32 string literals, but SFML doesn't support them yet. 

It may seem obvious, but you also have to make sure that the font that you use contains the characters that you want to draw. Indeed, fonts don't contain glyphs for all possible characters (there are more than 100000 in the Unicode standard!), and an Arabic font won't be able to display Japanese text, for example. 

## Making your own text class

If [Text]({{book.api}}/Text.html) is too limited, or if you want to do something else with pre-rendered glyphs, [Font]({{book.api}}/Font.html) provides everything that you need. 

You can retrieve the texture which contains all the pre-rendered glyphs of a certain size: 

```
const sf::Texture& texture = font.getTexture(characterSize);
```

It is important to note that glyphs are added to the texture when they are requested. There are so many characters (remember, more than 100000) that they can't all be generated when you load the font. Instead, they are rendered on the fly when you call the `getGlyph` function (see below). 

To do something meaningful with the font texture, you must get the texture coordinates of glyphs that are contained in it: 

```
sf::Glyph glyph = font.getGlyph(character, characterSize, bold);
```

`character` is the UTF-32 code of the character whose glyph that you want to get. You must also specify the character size, and whether you want the bold or the regular version of the glyph. 

The [Glyph]({{book.api}}/Glyph.html) structure contains three members: 

  * `textureRect` contains the texture coordinates of the glyph within the texture
  * `bounds` contains the bounding rectangle of the glyph, which helps position it relative to the baseline of the text
  * `advance` is the horizontal offset to apply to get the starting position of the next glyph in the text

You can also get some of the font's other metrics, such as the kerning between two characters or the line spacing (always for a certain character size): 

```
int lineSpacing = font.getLineSpacing(characterSize);

int kerning = font.getKerning(character1, character2, characterSize);
```

