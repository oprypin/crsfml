# SF::AlResource

Empty module that indicates the class requires an OpenAL context

# SF::Listener

The audio listener is the point in the scene
from where all the sounds are heard

The audio listener defines the global properties of the
audio environment, it defines where and how sounds and musics
are heard. If `SF::View` is the eyes of the user, then `SF::Listener`
is his ears (by the way, they are often linked together --
same position, orientation, etc.).

`SF::Listener` is a simple interface, which allows to setup the
listener in the 3D audio environment (position, direction and
up vector), and to adjust the global volume.

Because the listener is unique in the scene, `SF::Listener` only
contains static functions and doesn't have to be instantiated.

Usage example:
```
# Move the listener to the position (1, 0, -5)
SF::Listener.set_position(1, 0, -5)

# Make it face the right axis (1, 0, 0)
SF::Listener.direction = SF.vector3f(1, 0, 0)

# Reduce the global volume
SF::Listener.global_volume = 50
```

## SF::Listener.direction()

Get the current forward vector of the listener in the scene

*Returns:* Listener's forward vector (not normalized)

*See also:* `direction=`

## SF::Listener.direction=(direction)

Set the forward vector of the listener in the scene

The direction (also called "at vector") is the vector
pointing forward from the listener's perspective. Together
with the up vector, it defines the 3D orientation of the
listener in the scene. The direction vector doesn't
have to be normalized.
The default listener's direction is (0, 0, -1).

* *direction* - New listener's direction

*See also:* `direction`, `up_vector=`, `position=`

## SF::Listener.global_volume()

Get the current value of the global volume

*Returns:* Current global volume, in the range `0..100`

*See also:* `global_volume=`

## SF::Listener.global_volume=(volume)

Change the global volume of all the sounds and musics

The volume is a number between 0 and 100; it is combined with
the individual volume of each sound / music.
The default value for the volume is 100 (maximum).

* *volume* - New global volume, in the range `0..100`

*See also:* `global_volume`

## SF::Listener.position()

Get the current position of the listener in the scene

*Returns:* Listener's position

*See also:* `position=`

## SF::Listener.position=(position)

Set the position of the listener in the scene

The default listener's position is (0, 0, 0).

* *position* - New listener's position

*See also:* `position`, `direction=`

## SF::Listener.set_direction(x,y,z)

Set the forward vector of the listener in the scene

The direction (also called "at vector") is the vector
pointing forward from the listener's perspective. Together
with the up vector, it defines the 3D orientation of the
listener in the scene. The direction vector doesn't
have to be normalized.
The default listener's direction is (0, 0, -1).

* *x* - X coordinate of the listener's direction
* *y* - Y coordinate of the listener's direction
* *z* - Z coordinate of the listener's direction

*See also:* `direction`, `up_vector=`, `position=`

## SF::Listener.set_position(x,y,z)

Set the position of the listener in the scene

The default listener's position is (0, 0, 0).

* *x* - X coordinate of the listener's position
* *y* - Y coordinate of the listener's position
* *z* - Z coordinate of the listener's position

*See also:* `position`, `direction=`

## SF::Listener.set_up_vector(x,y,z)

Set the upward vector of the listener in the scene

The up vector is the vector that points upward from the
listener's perspective. Together with the direction, it
defines the 3D orientation of the listener in the scene.
The up vector doesn't have to be normalized.
The default listener's up vector is (0, 1, 0). It is usually
not necessary to change it, especially in 2D scenarios.

* *x* - X coordinate of the listener's up vector
* *y* - Y coordinate of the listener's up vector
* *z* - Z coordinate of the listener's up vector

*See also:* `up_vector`, `direction=`, `position=`

## SF::Listener.up_vector()

Get the current upward vector of the listener in the scene

*Returns:* Listener's upward vector (not normalized)

*See also:* `up_vector=`

## SF::Listener.up_vector=(up_vector)

Set the upward vector of the listener in the scene

The up vector is the vector that points upward from the
listener's perspective. Together with the direction, it
defines the 3D orientation of the listener in the scene.
The up vector doesn't have to be normalized.
The default listener's up vector is (0, 1, 0). It is usually
not necessary to change it, especially in 2D scenarios.

* *up_vector* - New listener's up vector

*See also:* `up_vector`, `direction=`, `position=`

# SF::Music

Streamed music played from an audio file

Musics are sounds that are streamed rather than completely
loaded in memory. This is especially useful for compressed
musics that usually take hundreds of MB when they are
uncompressed: by streaming it instead of loading it entirely,
you avoid saturating the memory and have almost no loading delay.
This implies that the underlying resource (file, stream or
memory buffer) must remain valid for the lifetime of the
`SF::Music` object.

Apart from that, a `SF::Music` has almost the same features as
the `SF::SoundBuffer` / `SF::Sound` pair: you can play/pause/stop
it, request its parameters (channels, sample rate), change
the way it is played (pitch, volume, 3D position, ...), etc.

As a sound stream, a music is played in its own thread in order
not to block the rest of the program. This means that you can
leave the music alone after calling play(), it will manage itself
very well.

Usage example:
```
# Declare a new music
music = SF::Music.new

# Open it from an audio file
if !music.open_from_file("music.ogg")
    # error...
end

# Change some parameters
music.set_position(0, 1, 10) # change its 3D position
music.pitch = 2              # increase the pitch
music.volume = 50            # reduce the volume
music.loop = true            # make it loop

# Play it
music.play()
```

*See also:* `SF::Sound`, `SF::SoundStream`

## SF::Music#attenuation()

:nodoc:

## SF::Music#attenuation=(attenuation)

:nodoc:

## SF::Music#channel_count()

:nodoc:

## SF::Music#duration()

Get the total duration of the music

*Returns:* Music duration

## SF::Music#finalize()

Destructor

## SF::Music#initialize()

Default constructor

## SF::Music#initialize(channel_count,sample_rate)

:nodoc:

## SF::Music#loop()

:nodoc:

## SF::Music#loop=(loop)

:nodoc:

## SF::Music#loop_points()

Get the positions of the of the sound's looping sequence

*Returns:* Loop Time position class.

*Warning:* Since loop_points=() performs some adjustments on the
provided values and rounds them to internal samples, a call to
loop_points() is not guaranteed to return the same times passed
into a previous call to loop_points=(). However, it is guaranteed
to return times that will map to the valid internal samples of
this Music if they are later passed to loop_points=().

*See also:* `loop_points=`

## SF::Music#loop_points=(time_points)

Sets the beginning and end of the sound's looping sequence using `SF::Time`

Loop points allow one to specify a pair of positions such that, when the music
is enabled for looping, it will seamlessly seek to the beginning whenever it
encounters the end. Valid ranges for time_points.offset and time_points.length are
[0, Dur) and (0, Dur-offset] respectively, where Dur is the value returned by duration().
Note that the EOF "loop point" from the end to the beginning of the stream is still honored,
in case the caller seeks to a point after the end of the loop range. This function can be
safely called at any point after a stream is opened, and will be applied to a playing sound
without affecting the current playing offset.

*Warning:* Setting the loop points while the stream's status is Paused
will set its status to Stopped. The playing offset will be unaffected.

* *time_points* - The definition of the loop. Can be any time points within the sound's length

*See also:* `loop_points`

## SF::Music#min_distance()

:nodoc:

## SF::Music#min_distance=(distance)

:nodoc:

## SF::Music#on_get_data()

Request a new chunk of audio samples from the stream source

This function fills the chunk from the next samples
to read from the audio file.

* *data* - Chunk of data to fill

*Returns:* True to continue playback, false to stop

## SF::Music#on_loop()

Change the current playing position in the stream source to the loop offset

This is called by the underlying SoundStream whenever it needs us to reset
the seek position for a loop. We then determine whether we are looping on a
loop point or the end-of-file, perform the seek, and return the new position.

*Returns:* The seek position after looping (or -1 if there's no loop)

## SF::Music#on_seek(time_offset)

Change the current playing position in the stream source

* *time_offset* - New playing position, from the beginning of the music

## SF::Music#open_from_file(filename)

Open a music from an audio file

This function doesn't start playing the music (call play()
to do so).
See the documentation of `SF::InputSoundFile` for the list
of supported formats.

*Warning:* Since the music is not loaded at once but rather
streamed continuously, the file must remain accessible until
the `SF::Music` object loads a new music or is destroyed.

* *filename* - Path of the music file to open

*Returns:* True if loading succeeded, false if it failed

*See also:* `open_from_memory`, `open_from_stream`

## SF::Music#open_from_memory(data)

Open a music from an audio file in memory

This function doesn't start playing the music (call play()
to do so).
See the documentation of `SF::InputSoundFile` for the list
of supported formats.

*Warning:* Since the music is not loaded at once but rather streamed
continuously, the *data* buffer must remain accessible until
the `SF::Music` object loads a new music or is destroyed. That is,
you can't deallocate the buffer right after calling this function.

* *data* - Slice containing the file data in memory

*Returns:* True if loading succeeded, false if it failed

*See also:* `open_from_file`, `open_from_stream`

## SF::Music#open_from_stream(stream)

Open a music from an audio file in a custom stream

This function doesn't start playing the music (call play()
to do so).
See the documentation of `SF::InputSoundFile` for the list
of supported formats.

*Warning:* Since the music is not loaded at once but rather
streamed continuously, the *stream* must remain accessible
until the `SF::Music` object loads a new music or is destroyed.

* *stream* - Source stream to read from

*Returns:* True if loading succeeded, false if it failed

*See also:* `open_from_file`, `open_from_memory`

## SF::Music#pause()

:nodoc:

## SF::Music#pitch()

:nodoc:

## SF::Music#pitch=(pitch)

:nodoc:

## SF::Music#play()

:nodoc:

## SF::Music#playing_offset()

:nodoc:

## SF::Music#playing_offset=(time_offset)

:nodoc:

## SF::Music#position()

:nodoc:

## SF::Music#position=(position)

:nodoc:

## SF::Music#relative_to_listener?()

:nodoc:

## SF::Music#relative_to_listener=(relative)

:nodoc:

## SF::Music#sample_rate()

:nodoc:

## SF::Music#set_position(x,y,z)

:nodoc:

## SF::Music#status()

:nodoc:

## SF::Music#stop()

:nodoc:

## SF::Music#volume()

:nodoc:

## SF::Music#volume=(volume)

:nodoc:

# SF::Sound

Regular sound that can be played in the audio environment

`SF::Sound` is the class to use to play sounds.
It provides:
* Control (play, pause, stop)
* Ability to modify output parameters in real-time (pitch, volume, ...)
* 3D spatial features (position, attenuation, ...).

`SF::Sound` is perfect for playing short sounds that can
fit in memory and require no latency, like foot steps or
gun shots. For longer sounds, like background musics
or long speeches, rather see `SF::Music` (which is based
on streaming).

In order to work, a sound must be given a buffer of audio
data to play. Audio data (samples) is stored in `SF::SoundBuffer`,
and attached to a sound with the buffer=() function.
The buffer object attached to a sound must remain alive
as long as the sound uses it. Note that multiple sounds
can use the same sound buffer at the same time.

Usage example:
```
buffer = SF::SoundBuffer.from_file("sound.wav")

sound = SF::Sound.new
sound.buffer = buffer
sound.play()
```

*See also:* `SF::SoundBuffer`, `SF::Music`

## SF::Sound#attenuation()

:nodoc:

## SF::Sound#attenuation=(attenuation)

:nodoc:

## SF::Sound#buffer()

Get the audio buffer attached to the sound

*Returns:* Sound buffer attached to the sound (can be NULL)

## SF::Sound#buffer()

:nodoc:

## SF::Sound#buffer=(buffer)

Set the source buffer containing the audio data to play

It is important to note that the sound buffer is not copied,
thus the `SF::SoundBuffer` instance must remain alive as long
as it is attached to the sound.

* *buffer* - Sound buffer to attach to the sound

*See also:* `buffer`

## SF::Sound#finalize()

Destructor

## SF::Sound#initialize()

Default constructor

## SF::Sound#initialize(buffer)

Construct the sound with a buffer

* *buffer* - Sound buffer containing the audio data to play with the sound

## SF::Sound#loop()

Tell whether or not the sound is in loop mode

*Returns:* True if the sound is looping, false otherwise

*See also:* `loop=`

## SF::Sound#loop=(loop)

Set whether or not the sound should loop after reaching the end

If set, the sound will restart from beginning after
reaching the end and so on, until it is stopped or
loop=(false) is called.
The default looping state for sound is false.

* *loop* - True to play in loop, false to play once

*See also:* `loop`

## SF::Sound#min_distance()

:nodoc:

## SF::Sound#min_distance=(distance)

:nodoc:

## SF::Sound#pause()

Pause the sound

This function pauses the sound if it was playing,
otherwise (sound already paused or stopped) it has no effect.

*See also:* `play`, `stop`

## SF::Sound#pitch()

:nodoc:

## SF::Sound#pitch=(pitch)

:nodoc:

## SF::Sound#play()

Start or resume playing the sound

This function starts the stream if it was stopped, resumes
it if it was paused, and restarts it from beginning if it
was it already playing.
This function uses its own thread so that it doesn't block
the rest of the program while the sound is played.

*See also:* `pause`, `stop`

## SF::Sound#playing_offset()

Get the current playing position of the sound

*Returns:* Current playing position, from the beginning of the sound

*See also:* `playing_offset=`

## SF::Sound#playing_offset=(time_offset)

Change the current playing position of the sound

The playing position can be changed when the sound is
either paused or playing. Changing the playing position
when the sound is stopped has no effect, since playing
the sound will reset its position.

* *time_offset* - New playing position, from the beginning of the sound

*See also:* `playing_offset`

## SF::Sound#position()

:nodoc:

## SF::Sound#position=(position)

:nodoc:

## SF::Sound#relative_to_listener?()

:nodoc:

## SF::Sound#relative_to_listener=(relative)

:nodoc:

## SF::Sound#reset_buffer()

Reset the internal buffer of the sound

This function is for internal use only, you don't have
to use it. It is called by the `SF::SoundBuffer` that
this sound uses, when it is destroyed in order to prevent
the sound from using a dead buffer.

## SF::Sound#set_position(x,y,z)

:nodoc:

## SF::Sound#status()

Get the current status of the sound (stopped, paused, playing)

*Returns:* Current status of the sound

## SF::Sound#stop()

stop playing the sound

This function stops the sound if it was playing or paused,
and does nothing if it was already stopped.
It also resets the playing position (unlike pause()).

*See also:* `play`, `pause`

## SF::Sound#volume()

:nodoc:

## SF::Sound#volume=(volume)

:nodoc:

# SF::SoundBuffer

Storage for audio samples defining a sound

A sound buffer holds the data of a sound, which is
an array of audio samples. A sample is a 16 bits signed integer
that defines the amplitude of the sound at a given time.
The sound is then reconstituted by playing these samples at
a high rate (for example, 44100 samples per second is the
standard rate used for playing CDs). In short, audio samples
are like texture pixels, and a `SF::SoundBuffer` is similar to
a `SF::Texture`.

A sound buffer can be loaded from a file (see load_from_file()
for the complete list of supported formats), from memory, from
a custom stream (see `SF::InputStream`) or directly from an array
of samples. It can also be saved back to a file.

Sound buffers alone are not very useful: they hold the audio data
but cannot be played. To do so, you need to use the `SF::Sound` class,
which provides functions to play/pause/stop the sound as well as
changing the way it is outputted (volume, pitch, 3D position, ...).
This separation allows more flexibility and better performances:
indeed a `SF::SoundBuffer` is a heavy resource, and any operation on it
is slow (often too slow for real-time applications). On the other
side, a `SF::Sound` is a lightweight object, which can use the audio data
of a sound buffer and change the way it is played without actually
modifying that data. Note that it is also possible to bind
several `SF::Sound` instances to the same `SF::SoundBuffer`.

It is important to note that the `SF::Sound` instance doesn't
copy the buffer that it uses, it only keeps a reference to it.
Thus, a `SF::SoundBuffer` must not be destructed while it is
used by a `SF::Sound` (i.e. never write a function that
uses a local `SF::SoundBuffer` instance for loading a sound).

Usage example:
```
# Load a new sound buffer from a file
buffer = SF::SoundBuffer.from_file("sound.wav")

# Create a sound source and bind it to the buffer
sound1 = SF::Sound.new
sound1.buffer = buffer

# Play the sound
sound1.play()

# Create another sound source bound to the same buffer
sound2 = SF::Sound.new
sound2.buffer = buffer

# Play it with a higher pitch -- the first sound remains unchanged
sound2.pitch = 2
sound2.play()
```

*See also:* `SF::Sound`, `SF::SoundBufferRecorder`

## SF::SoundBuffer#channel_count()

Get the number of channels used by the sound

If the sound is mono then the number of channels will
be 1, 2 for stereo, etc.

*Returns:* Number of channels

*See also:* `sample_rate`, `duration`

## SF::SoundBuffer#duration()

Get the total duration of the sound

*Returns:* Sound duration

*See also:* `sample_rate`, `channel_count`

## SF::SoundBuffer#finalize()

Destructor

## SF::SoundBuffer#initialize()

Default constructor

## SF::SoundBuffer#load_from_file(filename)

Load the sound buffer from a file

See the documentation of `SF::InputSoundFile` for the list
of supported formats.

* *filename* - Path of the sound file to load

*Returns:* True if loading succeeded, false if it failed

*See also:* `load_from_memory`, `load_from_stream`, `load_from_samples`, `save_to_file`

## SF::SoundBuffer#load_from_memory(data)

Load the sound buffer from a file in memory

See the documentation of `SF::InputSoundFile` for the list
of supported formats.

* *data* - Slice containing the file data in memory

*Returns:* True if loading succeeded, false if it failed

*See also:* `load_from_file`, `load_from_stream`, `load_from_samples`

## SF::SoundBuffer#load_from_samples(samples,channel_count,sample_rate)

Load the sound buffer from an array of audio samples

The assumed format of the audio samples is 16 bits signed integer
(`SF::Int16`).

* *samples* - Pointer to the array of samples in memory
* *sample_count* - Number of samples in the array
* *channel_count* - Number of channels (1 = mono, 2 = stereo, ...)
* *sample_rate* - Sample rate (number of samples to play per second)

*Returns:* True if loading succeeded, false if it failed

*See also:* `load_from_file`, `load_from_memory`, `save_to_file`

## SF::SoundBuffer#load_from_stream(stream)

Load the sound buffer from a custom stream

See the documentation of `SF::InputSoundFile` for the list
of supported formats.

* *stream* - Source stream to read from

*Returns:* True if loading succeeded, false if it failed

*See also:* `load_from_file`, `load_from_memory`, `load_from_samples`

## SF::SoundBuffer#sample_count()

Get the number of samples stored in the buffer

The array of samples can be accessed with the samples()
function.

*Returns:* Number of samples

*See also:* `samples`

## SF::SoundBuffer#sample_rate()

Get the sample rate of the sound

The sample rate is the number of samples played per second.
The higher, the better the quality (for example, 44100
samples/s is CD quality).

*Returns:* Sample rate (number of samples per second)

*See also:* `channel_count`, `duration`

## SF::SoundBuffer#samples()

Get the array of audio samples stored in the buffer

The format of the returned samples is 16 bits signed integer
(`SF::Int16`). The total number of samples in this array
is given by the sample_count() function.

*Returns:* Read-only pointer to the array of sound samples

*See also:* `sample_count`

## SF::SoundBuffer#save_to_file(filename)

Save the sound buffer to an audio file

See the documentation of `SF::OutputSoundFile` for the list
of supported formats.

* *filename* - Path of the sound file to write

*Returns:* True if saving succeeded, false if it failed

*See also:* `load_from_file`, `load_from_memory`, `load_from_samples`

# SF::SoundBufferRecorder

Specialized SoundRecorder which stores the captured
audio data into a sound buffer

`SF::SoundBufferRecorder` allows to access a recorded sound
through a `SF::SoundBuffer`, so that it can be played, saved
to a file, etc.

It has the same simple interface as its base class (start(), stop())
and adds a function to retrieve the recorded sound buffer
(buffer()).

As usual, don't forget to call the available?() function
before using this class (see `SF::SoundRecorder` for more details
about this).

Usage example:
```
if SF::SoundBufferRecorder.available?
  # Record some audio data
  recorder = SF::SoundBufferRecorder.new
  recorder.start()
  ...
  recorder.stop()

  # Get the buffer containing the captured audio data
  buffer = recorder.buffer

  # Save it to a file (for example...)
  buffer.save_to_file("my_record.ogg")
end
```

*See also:* `SF::SoundRecorder`

## SF::SoundBufferRecorder.available?()

:nodoc:

## SF::SoundBufferRecorder.available_devices()

:nodoc:

## SF::SoundBufferRecorder#buffer()

Get the sound buffer containing the captured audio data

The sound buffer is valid only after the capture has ended.
This function provides a read-only access to the internal
sound buffer, but it can be copied if you need to
make any modification to it.

*Returns:* Read-only access to the sound buffer

## SF::SoundBufferRecorder#channel_count()

:nodoc:

## SF::SoundBufferRecorder#channel_count=(channel_count)

:nodoc:

## SF::SoundBufferRecorder.default_device()

:nodoc:

## SF::SoundBufferRecorder#device()

:nodoc:

## SF::SoundBufferRecorder#device=(name)

:nodoc:

## SF::SoundBufferRecorder#finalize()

destructor

## SF::SoundBufferRecorder#on_process_samples(samples)

Process a new chunk of recorded samples

* *samples* - Pointer to the new chunk of recorded samples
* *sample_count* - Number of samples pointed by *samples*

*Returns:* True to continue the capture, or false to stop it

## SF::SoundBufferRecorder#on_start()

Start capturing audio data

*Returns:* True to start the capture, or false to abort it

## SF::SoundBufferRecorder#on_stop()

Stop capturing audio data

## SF::SoundBufferRecorder#processing_interval=(interval)

:nodoc:

## SF::SoundBufferRecorder#sample_rate()

:nodoc:

## SF::SoundBufferRecorder#start(sample_rate)

:nodoc:

## SF::SoundBufferRecorder#stop()

:nodoc:

# SF::SoundRecorder

Abstract base class for capturing sound data

`SF::SoundBuffer` provides a simple interface to access
the audio recording capabilities of the computer
(the microphone). As an abstract base class, it only cares
about capturing sound samples, the task of making something
useful with them is left to the derived class. Note that
SFML provides a built-in specialization for saving the
captured data to a sound buffer (see `SF::SoundBufferRecorder`).

A derived class has only one virtual function to override:
* on_process_samples provides the new chunks of audio samples while the capture happens

Moreover, two additional virtual functions can be overridden
as well if necessary:
* on_start is called before the capture happens, to perform custom initializations
* on_stop is called after the capture ends, to perform custom cleanup

A derived class can also control the frequency of the on_process_samples
calls, with the processing_interval= protected function. The default
interval is chosen so that recording thread doesn't consume too much
CPU, but it can be changed to a smaller value if you need to process
the recorded data in real time, for example.

The audio capture feature may not be supported or activated
on every platform, thus it is recommended to check its
availability with the available?() function. If it returns
false, then any attempt to use an audio recorder will fail.

If you have multiple sound input devices connected to your
computer (for example: microphone, external soundcard, webcam mic, ...)
you can get a list of all available devices through the
available_devices() function. You can then select a device
by calling device=() with the appropriate device. Otherwise
the default capturing device will be used.

By default the recording is in 16-bit mono. Using the
channel_count= method you can change the number of channels
used by the audio capture device to record. Note that you
have to decide whether you want to record in mono or stereo
before starting the recording.

It is important to note that the audio capture happens in a
separate thread, so that it doesn't block the rest of the
program. In particular, the on_process_samples virtual function
(but not on_start and not on_stop) will be called
from this separate thread. It is important to keep this in
mind, because you may have to take care of synchronization
issues if you share data between threads.
Another thing to bear in mind is that you must call stop()
in the destructor of your derived class, so that the recording
thread finishes before your object is destroyed.

Usage example:
```
class CustomRecorder < SF::SoundRecorder
  def finalize
    # Make sure to stop the recording thread
    stop()
  end

  def on_start() # optional
    # Initialize whatever has to be done before the capture starts
    ...

    # Return true to start playing
    true
  end

  def on_process_samples(samples)
    # Do something with the new chunk of samples (store them, send them, ...)
    ...

    # Return true to continue playing
    true
  end

  def on_stop() # optional
    # Clean up whatever has to be done after the capture ends
    ...
  end
end

# Usage
if (CustomRecorder.isAvailable())
    CustomRecorder recorder

    if (!recorder.start())
        return -1

    ...
    recorder.stop()
end
```

*See also:* `SF::SoundBufferRecorder`

## SF::SoundRecorder.available?()

Check if the system supports audio capture

This function should always be called before using
the audio capture features. If it returns false, then
any attempt to use `SF::SoundRecorder` or one of its derived
classes will fail.

*Returns:* True if audio capture is supported, false otherwise

## SF::SoundRecorder.available_devices()

Get a list of the names of all available audio capture devices

This function returns a vector of strings, containing
the names of all available audio capture devices.

*Returns:* A vector of strings containing the names

## SF::SoundRecorder#channel_count()

Get the number of channels used by this recorder

Currently only mono and stereo are supported, so the
value is either 1 (for mono) or 2 (for stereo).

*Returns:* Number of channels

*See also:* `channel_count=`

## SF::SoundRecorder#channel_count=(channel_count)

Set the channel count of the audio capture device

This method allows you to specify the number of channels
used for recording. Currently only 16-bit mono and
16-bit stereo are supported.

* *channel_count* - Number of channels. Currently only
mono (1) and stereo (2) are supported.

*See also:* `channel_count`

## SF::SoundRecorder.default_device()

Get the name of the default audio capture device

This function returns the name of the default audio
capture device. If none is available, an empty string
is returned.

*Returns:* The name of the default audio capture device

## SF::SoundRecorder#device()

Get the name of the current audio capture device

*Returns:* The name of the current audio capture device

## SF::SoundRecorder#device=(name)

Set the audio capture device

This function sets the audio capture device to the device
with the given *name.* It can be called on the fly (i.e:
while recording). If you do so while recording and
opening the device fails, it stops the recording.

* *name* - The name of the audio capture device

*Returns:* True, if it was able to set the requested device

*See also:* `available_devices`, `default_device`

## SF::SoundRecorder#finalize()

destructor

## SF::SoundRecorder#initialize()

Default constructor

This constructor is only meant to be called by derived classes.

## SF::SoundRecorder#on_process_samples(samples)

Process a new chunk of recorded samples

This virtual function is called every time a new chunk of
recorded data is available. The derived class can then do
whatever it wants with it (storing it, playing it, sending
it over the network, etc.).

* *samples* - Pointer to the new chunk of recorded samples
* *sample_count* - Number of samples pointed by *samples*

*Returns:* True to continue the capture, or false to stop it

## SF::SoundRecorder#on_start()

Start capturing audio data

This virtual function may be overridden by a derived class
if something has to be done every time a new capture
starts. If not, this function can be ignored; the default
implementation does nothing.

*Returns:* True to start the capture, or false to abort it

## SF::SoundRecorder#on_stop()

Stop capturing audio data

This virtual function may be overridden by a derived class
if something has to be done every time the capture
ends. If not, this function can be ignored; the default
implementation does nothing.

## SF::SoundRecorder#processing_interval=(interval)

Set the processing interval

The processing interval controls the period
between calls to the on_process_samples function. You may
want to use a small interval if you want to process the
recorded data in real time, for example.

Note: this is only a hint, the actual period may vary.
So don't rely on this parameter to implement precise timing.

The default processing interval is 100 ms.

* *interval* - Processing interval

## SF::SoundRecorder#sample_rate()

Get the sample rate

The sample rate defines the number of audio samples
captured per second. The higher, the better the quality
(for example, 44100 samples/sec is CD quality).

*Returns:* Sample rate, in samples per second

## SF::SoundRecorder#start(sample_rate)

Start the capture

The *sample_rate* parameter defines the number of audio samples
captured per second. The higher, the better the quality
(for example, 44100 samples/sec is CD quality).
This function uses its own thread so that it doesn't block
the rest of the program while the capture runs.
Please note that only one capture can happen at the same time.
You can select which capture device will be used, by passing
the name to the device=() method. If none was selected
before, the default capture device will be used. You can get a
list of the names of all available capture devices by calling
available_devices().

* *sample_rate* - Desired capture rate, in number of samples per second

*Returns:* True, if start of capture was successful

*See also:* `stop`, `available_devices`

## SF::SoundRecorder#stop()

Stop the capture

*See also:* `start`

# SF::SoundSource

Base class defining a sound's properties

`SF::SoundSource` is not meant to be used directly, it
only serves as a common base for all audio objects
that can live in the audio environment.

It defines several properties for the sound: pitch,
volume, position, attenuation, etc. All of them can be
changed at any time with no impact on performances.

*See also:* `SF::Sound`, `SF::SoundStream`

## SF::SoundSource::Status

Enumeration of the sound source states

### SF::SoundSource::Status::Paused

Sound is paused

### SF::SoundSource::Status::Playing

Sound is playing

### SF::SoundSource::Status::Stopped

Sound is not playing

## SF::SoundSource#attenuation()

Get the attenuation factor of the sound

*Returns:* Attenuation factor of the sound

*See also:* `attenuation=`, `min_distance`

## SF::SoundSource#attenuation=(attenuation)

Set the attenuation factor of the sound

The attenuation is a multiplicative factor which makes
the sound more or less loud according to its distance
from the listener. An attenuation of 0 will produce a
non-attenuated sound, i.e. its volume will always be the same
whether it is heard from near or from far. On the other hand,
an attenuation value such as 100 will make the sound fade out
very quickly as it gets further from the listener.
The default value of the attenuation is 1.

* *attenuation* - New attenuation factor of the sound

*See also:* `attenuation`, `min_distance=`

## SF::SoundSource#finalize()

Destructor

## SF::SoundSource#initialize()

Default constructor

This constructor is meant to be called by derived classes only.

## SF::SoundSource#min_distance()

Get the minimum distance of the sound

*Returns:* Minimum distance of the sound

*See also:* `min_distance=`, `attenuation`

## SF::SoundSource#min_distance=(distance)

Set the minimum distance of the sound

The "minimum distance" of a sound is the maximum
distance at which it is heard at its maximum volume. Further
than the minimum distance, it will start to fade out according
to its attenuation factor. A value of 0 ("inside the head
of the listener") is an invalid value and is forbidden.
The default value of the minimum distance is 1.

* *distance* - New minimum distance of the sound

*See also:* `min_distance`, `attenuation=`

## SF::SoundSource#pause()

Pause the sound source

This function pauses the source if it was playing,
otherwise (source already paused or stopped) it has no effect.

*See also:* `play`, `stop`

## SF::SoundSource#pitch()

Get the pitch of the sound

*Returns:* Pitch of the sound

*See also:* `pitch=`

## SF::SoundSource#pitch=(pitch)

Set the pitch of the sound

The pitch represents the perceived fundamental frequency
of a sound; thus you can make a sound more acute or grave
by changing its pitch. A side effect of changing the pitch
is to modify the playing speed of the sound as well.
The default value for the pitch is 1.

* *pitch* - New pitch to apply to the sound

*See also:* `pitch`

## SF::SoundSource#play()

Start or resume playing the sound source

This function starts the source if it was stopped, resumes
it if it was paused, and restarts it from the beginning if
it was already playing.

*See also:* `pause`, `stop`

## SF::SoundSource#position()

Get the 3D position of the sound in the audio scene

*Returns:* Position of the sound

*See also:* `position=`

## SF::SoundSource#position=(position)

Set the 3D position of the sound in the audio scene

Only sounds with one channel (mono sounds) can be
spatialized.
The default position of a sound is (0, 0, 0).

* *position* - Position of the sound in the scene

*See also:* `position`

## SF::SoundSource#relative_to_listener?()

Tell whether the sound's position is relative to the
listener or is absolute

*Returns:* True if the position is relative, false if it's absolute

*See also:* `relative_to_listener=`

## SF::SoundSource#relative_to_listener=(relative)

Make the sound's position relative to the listener or absolute

Making a sound relative to the listener will ensure that it will always
be played the same way regardless of the position of the listener.
This can be useful for non-spatialized sounds, sounds that are
produced by the listener, or sounds attached to it.
The default value is false (position is absolute).

* *relative* - True to set the position relative, false to set it absolute

*See also:* `relative_to_listener?`

## SF::SoundSource#set_position(x,y,z)

Set the 3D position of the sound in the audio scene

Only sounds with one channel (mono sounds) can be
spatialized.
The default position of a sound is (0, 0, 0).

* *x* - X coordinate of the position of the sound in the scene
* *y* - Y coordinate of the position of the sound in the scene
* *z* - Z coordinate of the position of the sound in the scene

*See also:* `position`

## SF::SoundSource#status()

Get the current status of the sound (stopped, paused, playing)

*Returns:* Current status of the sound

## SF::SoundSource#stop()

Stop playing the sound source

This function stops the source if it was playing or paused,
and does nothing if it was already stopped.
It also resets the playing position (unlike pause()).

*See also:* `play`, `pause`

## SF::SoundSource#volume()

Get the volume of the sound

*Returns:* Volume of the sound, in the range `0..100`

*See also:* `volume=`

## SF::SoundSource#volume=(volume)

Set the volume of the sound

The volume is a value between 0 (mute) and 100 (full volume).
The default value for the volume is 100.

* *volume* - Volume of the sound

*See also:* `volume`

# SF::SoundStream

Abstract base class for streamed audio sources

Unlike audio buffers (see `SF::SoundBuffer`), audio streams
are never completely loaded in memory. Instead, the audio
data is acquired continuously while the stream is playing.
This behavior allows to play a sound with no loading delay,
and keeps the memory consumption very low.

Sound sources that need to be streamed are usually big files
(compressed audio musics that would eat hundreds of MB in memory)
or files that would take a lot of time to be received
(sounds played over the network).

`SF::SoundStream` is a base class that doesn't care about the
stream source, which is left to the derived class. SFML provides
a built-in specialization for big files (see `SF::Music`).
No network stream source is provided, but you can write your own
by combining this class with the network module.

A derived class has to override two virtual functions:
* on_get_data fills a new chunk of audio data to be played
* on_seek changes the current playing position in the source

It is important to note that each SoundStream is played in its
own separate thread, so that the streaming loop doesn't block the
rest of the program. In particular, the OnGetData and OnSeek
virtual functions may sometimes be called from this separate thread.
It is important to keep this in mind, because you may have to take
care of synchronization issues if you share data between threads.

Usage example:
```
class CustomStream < SF::SoundStream
  def initialize(location : String)
    # Open the source and get audio settings
    ...

    # Initialize the stream -- important!
    super(channel_count, sample_rate)
  end

  def on_get_data()
    # Return a slice with audio data from the stream source
    # (note: must not be empty if you want to continue playing)
    Slice.new(samples.to_unsafe, samples.size)
  end

  def on_seek(time_offset)
    # Change the current position in the stream source
  end
end

# Usage
stream = CustomStream.new("path/to/stream")
stream.play()
```

*See also:* `SF::Music`

## SF::SoundStream::NoLoop

"Invalid" end_seeks value, telling us to continue uninterrupted

## SF::SoundStream#attenuation()

:nodoc:

## SF::SoundStream#attenuation=(attenuation)

:nodoc:

## SF::SoundStream#channel_count()

Return the number of channels of the stream

1 channel means a mono sound, 2 means stereo, etc.

*Returns:* Number of channels

## SF::SoundStream#finalize()

Destructor

## SF::SoundStream#initialize()

Default constructor

This constructor is only meant to be called by derived classes.

## SF::SoundStream#initialize(channel_count,sample_rate)

Define the audio stream parameters

This function must be called by derived classes as soon
as they know the audio settings of the stream to play.
Any attempt to manipulate the stream (play(), ...) before
calling this function will fail.
It can be called multiple times if the settings of the
audio stream change, but only when the stream is stopped.

* *channel_count* - Number of channels of the stream
* *sample_rate* - Sample rate, in samples per second

## SF::SoundStream#loop()

Tell whether or not the stream is in loop mode

*Returns:* True if the stream is looping, false otherwise

*See also:* `loop=`

## SF::SoundStream#loop=(loop)

Set whether or not the stream should loop after reaching the end

If set, the stream will restart from beginning after
reaching the end and so on, until it is stopped or
loop=(false) is called.
The default looping state for streams is false.

* *loop* - True to play in loop, false to play once

*See also:* `loop`

## SF::SoundStream#min_distance()

:nodoc:

## SF::SoundStream#min_distance=(distance)

:nodoc:

## SF::SoundStream#on_get_data()

Request a new chunk of audio samples from the stream source

This function must be overridden by derived classes to provide
the audio samples to play. It is called continuously by the
streaming loop, in a separate thread.
The source can choose to stop the streaming loop at any time, by
returning false to the caller.
If you return true (i.e. continue streaming) it is important that
the returned array of samples is not empty; this would stop the stream
due to an internal limitation.

* *data* - Chunk of data to fill

*Returns:* True to continue playback, false to stop

## SF::SoundStream#on_loop()

Change the current playing position in the stream source to the beginning of the loop

This function can be overridden by derived classes to
allow implementation of custom loop points. Otherwise,
it just calls on_seek(Time::Zero) and returns 0.

*Returns:* The seek position after looping (or -1 if there's no loop)

## SF::SoundStream#on_seek(time_offset)

Change the current playing position in the stream source

This function must be overridden by derived classes to
allow random seeking into the stream source.

* *time_offset* - New playing position, relative to the beginning of the stream

## SF::SoundStream#pause()

Pause the audio stream

This function pauses the stream if it was playing,
otherwise (stream already paused or stopped) it has no effect.

*See also:* `play`, `stop`

## SF::SoundStream#pitch()

:nodoc:

## SF::SoundStream#pitch=(pitch)

:nodoc:

## SF::SoundStream#play()

Start or resume playing the audio stream

This function starts the stream if it was stopped, resumes
it if it was paused, and restarts it from the beginning if
it was already playing.
This function uses its own thread so that it doesn't block
the rest of the program while the stream is played.

*See also:* `pause`, `stop`

## SF::SoundStream#playing_offset()

Get the current playing position of the stream

*Returns:* Current playing position, from the beginning of the stream

*See also:* `playing_offset=`

## SF::SoundStream#playing_offset=(time_offset)

Change the current playing position of the stream

The playing position can be changed when the stream is
either paused or playing. Changing the playing position
when the stream is stopped has no effect, since playing
the stream would reset its position.

* *time_offset* - New playing position, from the beginning of the stream

*See also:* `playing_offset`

## SF::SoundStream#position()

:nodoc:

## SF::SoundStream#position=(position)

:nodoc:

## SF::SoundStream#relative_to_listener?()

:nodoc:

## SF::SoundStream#relative_to_listener=(relative)

:nodoc:

## SF::SoundStream#sample_rate()

Get the stream sample rate of the stream

The sample rate is the number of audio samples played per
second. The higher, the better the quality.

*Returns:* Sample rate, in number of samples per second

## SF::SoundStream#set_position(x,y,z)

:nodoc:

## SF::SoundStream#status()

Get the current status of the stream (stopped, paused, playing)

*Returns:* Current status

## SF::SoundStream#stop()

Stop playing the audio stream

This function stops the stream if it was playing or paused,
and does nothing if it was already stopped.
It also resets the playing position (unlike pause()).

*See also:* `play`, `pause`

## SF::SoundStream#volume()

:nodoc:

## SF::SoundStream#volume=(volume)

:nodoc:
