--- SF::AlResource
+++ SF::AlResource
@@ -1,5 +1 @@
-Base class for classes that require an OpenAL context
-
-This class is for internal use only, it must be the base
-of every class that requires a valid OpenAL context in
-order to work.
+Empty module that indicates the class requires an OpenAL context
--- SF::Listener
+++ SF::Listener
@@ -17,11 +17,11 @@
 Usage example:
-```c++
-// Move the listener to the position (1, 0, -5)
-sf::Listener::setPosition(1, 0, -5);
+```
+# Move the listener to the position (1, 0, -5)
+SF::Listener.set_position(1, 0, -5)
 
-// Make it face the right axis (1, 0, 0)
-sf::Listener::setDirection(1, 0, 0);
+# Make it face the right axis (1, 0, 0)
+SF::Listener.direction = SF.vector3f(1, 0, 0)
 
-// Reduce the global volume
-sf::Listener::setGlobalVolume(50);
+# Reduce the global volume
+SF::Listener.global_volume = 50
 ```
--- SF::SoundBufferRecorder
+++ SF::SoundBufferRecorder
@@ -16,17 +16,16 @@
 Usage example:
-```c++
-if (sf::SoundBufferRecorder::isAvailable())
-{
-    // Record some audio data
-    sf::SoundBufferRecorder recorder;
-    recorder.start();
-    ...
-    recorder.stop();
+```
+if SF::SoundBufferRecorder.available?
+  # Record some audio data
+  recorder = SF::SoundBufferRecorder.new
+  recorder.start()
+  ...
+  recorder.stop()
 
-    // Get the buffer containing the captured audio data
-    const sf::SoundBuffer& buffer = recorder.getBuffer();
+  # Get the buffer containing the captured audio data
+  buffer = recorder.buffer
 
-    // Save it to a file (for example...)
-    buffer.saveToFile("my_record.ogg");
-}
+  # Save it to a file (for example...)
+  buffer.save_to_file("my_record.ogg")
+end
 ```
--- SF::SoundRecorder
+++ SF::SoundRecorder
@@ -54,47 +54,41 @@
 Usage example:
-```c++
-class CustomRecorder : public sf::SoundRecorder
-{
-    ~CustomRecorder()
-    {
-        // Make sure to stop the recording thread
-        stop();
-    }
-
-    virtual bool onStart() // optional
-    {
-        // Initialize whatever has to be done before the capture starts
-        ...
-
-        // Return true to start playing
-        return true;
-    }
-
-    virtual bool onProcessSamples(const Int16* samples, std::size_t sampleCount)
-    {
-        // Do something with the new chunk of samples (store them, send them, ...)
-        ...
-
-        // Return true to continue playing
-        return true;
-    }
-
-    virtual void onStop() // optional
-    {
-        // Clean up whatever has to be done after the capture ends
-        ...
-    }
-}
-
-// Usage
-if (CustomRecorder::isAvailable())
-{
-    CustomRecorder recorder;
+```
+class CustomRecorder < SF::SoundRecorder
+  def finalize
+    # Make sure to stop the recording thread
+    stop()
+  end
+
+  def on_start() # optional
+    # Initialize whatever has to be done before the capture starts
+    ...
+
+    # Return true to start playing
+    true
+  end
+
+  def on_process_samples(samples)
+    # Do something with the new chunk of samples (store them, send them, ...)
+    ...
+
+    # Return true to continue playing
+    true
+  end
+
+  def on_stop() # optional
+    # Clean up whatever has to be done after the capture ends
+    ...
+  end
+end
+
+# Usage
+if (CustomRecorder.isAvailable())
+    CustomRecorder recorder
 
     if (!recorder.start())
-        return -1;
+        return -1
 
     ...
-    recorder.stop();
-}
+    recorder.stop()
+end
 ```
--- SF::Music
+++ SF::Music
@@ -22,20 +22,19 @@
 Usage example:
-```c++
-// Declare a new music
-sf::Music music;
-
-// Open it from an audio file
-if (!music.openFromFile("music.ogg"))
-{
-    // error...
-}
-
-// Change some parameters
-music.setPosition(0, 1, 10); // change its 3D position
-music.setPitch(2);           // increase the pitch
-music.setVolume(50);         // reduce the volume
-music.setLoop(true);         // make it loop
-
-// Play it
-music.play();
+```
+# Declare a new music
+music = SF::Music.new
+
+# Open it from an audio file
+if !music.open_from_file("music.ogg")
+    # error...
+end
+
+# Change some parameters
+music.set_position(0, 1, 10) # change its 3D position
+music.pitch = 2              # increase the pitch
+music.volume = 50            # reduce the volume
+music.loop = true            # make it loop
+
+# Play it
+music.play()
 ```
--- SF::SoundSource#volume()
+++ SF::SoundSource#volume()
@@ -2,3 +2,3 @@
 
-*Returns:* Volume of the sound, in the range [0, 100]
+*Returns:* Volume of the sound, in the range `0..100`
 
--- SF::SoundStream
+++ SF::SoundStream
@@ -31,42 +31,26 @@
 Usage example:
-```c++
-class CustomStream : public sf::SoundStream
-{
-public:
-
-    bool open(const std::string& location)
-    {
-        // Open the source and get audio settings
-        ...
-        unsigned int channelCount = ...;
-        unsigned int sampleRate = ...;
-
-        // Initialize the stream -- important!
-        initialize(channelCount, sampleRate);
-    }
-
-private:
-
-    virtual bool onGetData(Chunk& data)
-    {
-        // Fill the chunk with audio data from the stream source
-        // (note: must not be empty if you want to continue playing)
-        data.samples = ...;
-        data.sampleCount = ...;
-
-        // Return true to continue playing
-        return true;
-    }
-
-    virtual void onSeek(Uint32 timeOffset)
-    {
-        // Change the current position in the stream source
-        ...
-    }
-}
-
-// Usage
-CustomStream stream;
-stream.open("path/to/stream");
-stream.play();
+```
+class CustomStream < SF::SoundStream
+  def initialize(location : String)
+    # Open the source and get audio settings
+    ...
+
+    # Initialize the stream -- important!
+    super(channel_count, sample_rate)
+  end
+
+  def on_get_data()
+    # Return a slice with audio data from the stream source
+    # (note: must not be empty if you want to continue playing)
+    Slice.new(samples.to_unsafe, samples.size)
+  end
+
+  def on_seek(time_offset)
+    # Change the current position in the stream source
+  end
+end
+
+# Usage
+stream = CustomStream.new("path/to/stream")
+stream.play()
 ```
--- SF::Music#open_from_memory(data)
+++ SF::Music#open_from_memory(data)
@@ -12,4 +12,3 @@
 
-* *data* - Pointer to the file data in memory
-* *size_in_bytes* - Size of the data to load, in bytes
+* *data* - Slice containing the file data in memory
 
--- SF::Listener.global_volume()
+++ SF::Listener.global_volume()
@@ -2,3 +2,3 @@
 
-*Returns:* Current global volume, in the range [0, 100]
+*Returns:* Current global volume, in the range `0..100`
 
--- SF::Listener.global_volume=(volume)
+++ SF::Listener.global_volume=(volume)
@@ -6,3 +6,3 @@
 
-* *volume* - New global volume, in the range [0, 100]
+* *volume* - New global volume, in the range `0..100`
 
--- SF::Sound
+++ SF::Sound
@@ -22,9 +22,8 @@
 Usage example:
-```c++
-sf::SoundBuffer buffer;
-buffer.loadFromFile("sound.wav");
+```
+buffer = SF::SoundBuffer.from_file("sound.wav")
 
-sf::Sound sound;
-sound.setBuffer(buffer);
-sound.play();
+sound = SF::Sound.new
+sound.buffer = buffer
+sound.play()
 ```
--- SF::SoundBuffer
+++ SF::SoundBuffer
@@ -35,26 +35,20 @@
 Usage example:
-```c++
-// Declare a new sound buffer
-sf::SoundBuffer buffer;
-
-// Load it from a file
-if (!buffer.loadFromFile("sound.wav"))
-{
-    // error...
-}
-
-// Create a sound source and bind it to the buffer
-sf::Sound sound1;
-sound1.setBuffer(buffer);
-
-// Play the sound
-sound1.play();
-
-// Create another sound source bound to the same buffer
-sf::Sound sound2;
-sound2.setBuffer(buffer);
-
-// Play it with a higher pitch -- the first sound remains unchanged
-sound2.setPitch(2);
-sound2.play();
+```
+# Load a new sound buffer from a file
+buffer = SF::SoundBuffer.from_file("sound.wav")
+
+# Create a sound source and bind it to the buffer
+sound1 = SF::Sound.new
+sound1.buffer = buffer
+
+# Play the sound
+sound1.play()
+
+# Create another sound source bound to the same buffer
+sound2 = SF::Sound.new
+sound2.buffer = buffer
+
+# Play it with a higher pitch -- the first sound remains unchanged
+sound2.pitch = 2
+sound2.play()
 ```
--- SF::SoundBuffer#load_from_memory(data)
+++ SF::SoundBuffer#load_from_memory(data)
@@ -5,4 +5,3 @@
 
-* *data* - Pointer to the file data in memory
-* *size_in_bytes* - Size of the data to load, in bytes
+* *data* - Slice containing the file data in memory
 
