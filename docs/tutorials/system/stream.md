# User data streams

## Introduction

SFML has several resource classes: images, fonts, sounds, etc. In most programs, these resources will be loaded from files, with the help of their `from_file` class method. In a few other situations, resources will be packed directly into the executable or in a big data file, and loaded from memory with `from_memory`. These methods cover *almost* all the possible use cases -- but not all.

Sometimes you want to load files from unusual places, such as a compressed/encrypted archive, or a remote network location for example. For these special situations, CrSFML provides a third loading method: `from_stream`. This method reads data using an abstract [SF::InputStream][] interface, which allows you to provide your own implementation of a stream class that works with SFML.

In this tutorial you'll learn how to write and use your own derived input stream.

## InputStream

The [SF::InputStream][] class declares four virtual methods:

```crystal
abstract class InputStream
  abstract def read(data : Slice) : Int64
  abstract def seek(position : Int) : Int64
  abstract def tell() : Int64
  abstract def size() : Int64
end
```

**read** must extract *buffer.size* bytes of data from the stream, and copy them to the supplied *buffer* slice. It returns the number of bytes read, or -1 on error.

**seek** must change the current reading position in the stream. Its *position* argument is the absolute byte offset to jump to (so it is relative to the beginning of the data, not to the current position). It returns the new position, or -1 on error.

**tell** must return the current reading position (in bytes) in the stream, or -1 on error.

**size** must return the total size (in bytes) of the data which is contained in the stream, or -1 on error.

To create your own working stream, you must implement every one of these four methods according to their requirements.

## FileInputStream and MemoryInputStream

`SF::FileInputStream` provides the read-only data stream of a file, while `SF::MemoryInputStream` serves the read-only stream from memory. Both are derived from `SF::InputStream`.

## Using an InputStream

Using a custom stream class is straight-forward: instantiate it, and pass it to the `from_stream` class method of the object that you want to load.

```crystal
stream = SF::FileInputStream.open("image.png")
texture = SF::Texture.from_stream(stream)
```

```crystal
stream = SF::FileInputStream.open("music.ogg")
music = SF::Music.from_stream(stream)
```

```crystal
string = File.read("image.png")
stream = SF::MemoryInputStream.open(string.to_slice)
texture = SF::Texture.from_stream(stream)
```

Note that the examples above are redundant, because `from_file` can be used instead. The real use cases are if you want to implement custom loading of resources. Option 1: read from file, extract into memory, use [SF::MemoryInputStream][]. Option 2: implement a custom stream that reads and extracts on the fly.

## Examples

If you need a demonstration that helps you focus on how the code works, and not get lost in implementation details, you could take a look at the implementation of [SF::FileInputStream][] or [SF::MemoryInputStream][].

## Common mistakes

Some resource classes are not loaded completely after `from_stream` has been called. Instead, they continue to read from their data source as long as they are used. This is the case for [SF::Music][], which streams audio samples as they are played, and for [SF::Font][], which loads glyphs on the fly depending on the text that is displayed.

As a consequence, the stream instance that you used to load a music or a font, as well as its data source, must remain alive as long as the resource uses it. If it is destroyed while still being used, it results in undefined behavior (can be a crash, corrupt data, or nothing visible).

Another common mistake is to return whatever the internal functions return directly, but sometimes it doesn't match what SFML expects. For example, some function may return 0 on success, but `InputStream#seek` expects the actual new position to be returned. Also keep in mind that in case of error -1 must be returned.
