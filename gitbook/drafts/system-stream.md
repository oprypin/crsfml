# User data streams

## Introduction

SFML has several resource classes: images, fonts, sounds, etc. In most programs, these resources will be loaded from files, with the help of their `from_file` class method. In a few other situations, resources will be packed directly into the executable or in a big data file, and loaded from memory with `from_memory`. These methods cover *almost* all the possible use cases -- but not all.

Sometimes you want to load files from unusual places, such as a compressed/encrypted archive, or a remote network location for example. For these special situations, SFML provides a third loading method: `from_stream`. This method reads data using an abstract [InputStream]({{book.api}}/InputStream.html) interface, which allows you to provide your own implementation of a stream class that works with SFML.

In this tutorial you'll learn how to write and use your own derived input stream.

## InputStream

The [InputStream]({{book.api}}/InputStream.html) class declares four virtual methods:

```ruby
class InputStream
  def initialize()
  end

  def read(data, Int64 size) : Int64
    0
  end

  def seek(position : Int64) : Int64
    0
  end

  def tell() : Int64
    0
  end

  def size() : Int64
    0
  end
end
```

**read** must extract *size* bytes of data from the stream, and copy them to the supplied *data* address. It returns the number of bytes read, or -1 on error.

**seek** must change the current reading position in the stream. Its *position* argument is the absolute byte offset to jump to (so it is relative to the beginning of the data, not to the current position). It returns the new position, or -1 on error.

**tell** must return the current reading position (in bytes) in the stream, or -1 on error.

**size** must return the total size (in bytes) of the data which is contained in the stream, or -1 on error.

To create your own working stream, you must implement every one of these four methods according to their requirements.

## FileInputStream and MemoryInputStream

Starting with SFML 2.3 two new classes have been created to provide streams for the new internal audio management. `SF::FileInputStream` provides the read-only data stream of a file, while `SF::MemoryInputStream` serves the read-only stream from memory. Both are derived from `SF::InputStream` and can thus be used polymorphic.

## Using an InputStream

Using a custom stream class is straight-forward: instantiate it, and pass it to the `from_stream` class method of the object that you want to load.

```
SF::FileStream stream;
stream.open("image.png");

SF::Texture texture;
texture.from_stream(stream);
```

## Examples

If you need a demonstration that helps you focus on how the code works, and not get lost in implementation details, you could take a look at the implementation of `SF::FileInputStream` or `SF::MemoryInputStream`.

Don't forget to check the forum and wiki. Chances are that another user already wrote a [InputStream]({{book.api}}/InputStream.html) class that suits your needs. And if you write a new one and feel like it could be useful to other people as well, don't hesitate to share!

## Common mistakes

Some resource classes are not loaded completely after `from_stream` has been called. Instead, they continue to read from their data source as long as they are used. This is the case for [Music]({{book.api}}/Music.html), which streams audio samples as they are played, and for [Font]({{book.api}}/Font.html), which loads glyphs on the fly depending on the text that is displayed.

As a consequence, the stream instance that you used to load a music or a font, as well as its data source, must remain alive as long as the resource uses it. If it is destroyed while still being used, it results in undefined behavior (can be a crash, corrupt data, or nothing visible).

Another common mistake is to return whatever the internal functions return directly, but sometimes it doesn't match what SFML expects. For example, in the `SF::FileInputStream` code, one might be tempted to write the `seek` method as follows:

```
SF::Int64 FileInputStream::seek(SF::Int64 position)
{
    return std::fseek(m_file, position, SEEK_SET);
}
```

This code is wrong, because `std::fseek` returns zero on success, whereas SFML expects the new position to be returned.
