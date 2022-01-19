require "./lib"
require "../common"
require "../system"
module SF
  extend self
  # The audio listener is the point in the scene
  # from where all the sounds are heard
  #
  # The audio listener defines the global properties of the
  # audio environment, it defines where and how sounds and musics
  # are heard. If `SF::View` is the eyes of the user, then `SF::Listener`
  # is his ears (by the way, they are often linked together --
  # same position, orientation, etc.).
  #
  # `SF::Listener` is a simple interface, which allows to setup the
  # listener in the 3D audio environment (position, direction and
  # up vector), and to adjust the global volume.
  #
  # Because the listener is unique in the scene, `SF::Listener` only
  # contains static functions and doesn't have to be instantiated.
  #
  # Usage example:
  # ```crystal
  # # Move the listener to the position (1, 0, -5)
  # SF::Listener.set_position(1, 0, -5)
  #
  # # Make it face the right axis (1, 0, 0)
  # SF::Listener.direction = SF.vector3f(1, 0, 0)
  #
  # # Reduce the global volume
  # SF::Listener.global_volume = 50
  # ```
  module Listener
    # Change the global volume of all the sounds and musics
    #
    # The volume is a number between 0 and 100; it is combined with
    # the individual volume of each sound / music.
    # The default value for the volume is 100 (maximum).
    #
    # * *volume* - New global volume, in the range `0..100`
    #
    # *See also:* `global_volume`
    def self.global_volume=(volume : Number)
      SFMLExt.sfml_listener_setglobalvolume_Bw9(LibC::Float.new(volume))
    end
    # Get the current value of the global volume
    #
    # *Returns:* Current global volume, in the range `0..100`
    #
    # *See also:* `global_volume=`
    def self.global_volume() : Float32
      SFMLExt.sfml_listener_getglobalvolume(out result)
      return result
    end
    # Set the position of the listener in the scene
    #
    # The default listener's position is (0, 0, 0).
    #
    # * *x* - X coordinate of the listener's position
    # * *y* - Y coordinate of the listener's position
    # * *z* - Z coordinate of the listener's position
    #
    # *See also:* `position`, `direction=`
    def self.set_position(x : Number, y : Number, z : Number)
      SFMLExt.sfml_listener_setposition_Bw9Bw9Bw9(LibC::Float.new(x), LibC::Float.new(y), LibC::Float.new(z))
    end
    # Set the position of the listener in the scene
    #
    # The default listener's position is (0, 0, 0).
    #
    # * *position* - New listener's position
    #
    # *See also:* `position`, `direction=`
    def self.position=(position : Vector3f)
      SFMLExt.sfml_listener_setposition_NzM(position)
    end
    # Get the current position of the listener in the scene
    #
    # *Returns:* Listener's position
    #
    # *See also:* `position=`
    def self.position() : Vector3f
      result = Vector3f.allocate
      SFMLExt.sfml_listener_getposition(result)
      return result
    end
    # Set the forward vector of the listener in the scene
    #
    # The direction (also called "at vector") is the vector
    # pointing forward from the listener's perspective. Together
    # with the up vector, it defines the 3D orientation of the
    # listener in the scene. The direction vector doesn't
    # have to be normalized.
    # The default listener's direction is (0, 0, -1).
    #
    # * *x* - X coordinate of the listener's direction
    # * *y* - Y coordinate of the listener's direction
    # * *z* - Z coordinate of the listener's direction
    #
    # *See also:* `direction`, `up_vector=`, `position=`
    def self.set_direction(x : Number, y : Number, z : Number)
      SFMLExt.sfml_listener_setdirection_Bw9Bw9Bw9(LibC::Float.new(x), LibC::Float.new(y), LibC::Float.new(z))
    end
    # Set the forward vector of the listener in the scene
    #
    # The direction (also called "at vector") is the vector
    # pointing forward from the listener's perspective. Together
    # with the up vector, it defines the 3D orientation of the
    # listener in the scene. The direction vector doesn't
    # have to be normalized.
    # The default listener's direction is (0, 0, -1).
    #
    # * *direction* - New listener's direction
    #
    # *See also:* `direction`, `up_vector=`, `position=`
    def self.direction=(direction : Vector3f)
      SFMLExt.sfml_listener_setdirection_NzM(direction)
    end
    # Get the current forward vector of the listener in the scene
    #
    # *Returns:* Listener's forward vector (not normalized)
    #
    # *See also:* `direction=`
    def self.direction() : Vector3f
      result = Vector3f.allocate
      SFMLExt.sfml_listener_getdirection(result)
      return result
    end
    # Set the upward vector of the listener in the scene
    #
    # The up vector is the vector that points upward from the
    # listener's perspective. Together with the direction, it
    # defines the 3D orientation of the listener in the scene.
    # The up vector doesn't have to be normalized.
    # The default listener's up vector is (0, 1, 0). It is usually
    # not necessary to change it, especially in 2D scenarios.
    #
    # * *x* - X coordinate of the listener's up vector
    # * *y* - Y coordinate of the listener's up vector
    # * *z* - Z coordinate of the listener's up vector
    #
    # *See also:* `up_vector`, `direction=`, `position=`
    def self.set_up_vector(x : Number, y : Number, z : Number)
      SFMLExt.sfml_listener_setupvector_Bw9Bw9Bw9(LibC::Float.new(x), LibC::Float.new(y), LibC::Float.new(z))
    end
    # Set the upward vector of the listener in the scene
    #
    # The up vector is the vector that points upward from the
    # listener's perspective. Together with the direction, it
    # defines the 3D orientation of the listener in the scene.
    # The up vector doesn't have to be normalized.
    # The default listener's up vector is (0, 1, 0). It is usually
    # not necessary to change it, especially in 2D scenarios.
    #
    # * *up_vector* - New listener's up vector
    #
    # *See also:* `up_vector`, `direction=`, `position=`
    def self.up_vector=(up_vector : Vector3f)
      SFMLExt.sfml_listener_setupvector_NzM(up_vector)
    end
    # Get the current upward vector of the listener in the scene
    #
    # *Returns:* Listener's upward vector (not normalized)
    #
    # *See also:* `up_vector=`
    def self.up_vector() : Vector3f
      result = Vector3f.allocate
      SFMLExt.sfml_listener_getupvector(result)
      return result
    end
  end
  # Empty module that indicates the class requires an OpenAL context
  module AlResource
  end
  SFMLExt.sfml_soundsource_play_callback(->(self : Void*) {
    self.as(SoundSource).play()
  })
  SFMLExt.sfml_soundsource_pause_callback(->(self : Void*) {
    self.as(SoundSource).pause()
  })
  SFMLExt.sfml_soundsource_stop_callback(->(self : Void*) {
    self.as(SoundSource).stop()
  })
  # Base class defining a sound's properties
  #
  # `SF::SoundSource` is not meant to be used directly, it
  # only serves as a common base for all audio objects
  # that can live in the audio environment.
  #
  # It defines several properties for the sound: pitch,
  # volume, position, attenuation, etc. All of them can be
  # changed at any time with no impact on performances.
  #
  # *See also:* `SF::Sound`, `SF::SoundStream`
  abstract class SoundSource
    @this : Void*
    # Enumeration of the sound source states
    enum Status
      # Sound is not playing
      Stopped
      # Sound is paused
      Paused
      # Sound is playing
      Playing
    end
    Util.extract SoundSource::Status
    # Destructor
    def finalize()
      SFMLExt.sfml_soundsource_finalize(to_unsafe)
      SFMLExt.sfml_soundsource_free(@this)
    end
    # Set the pitch of the sound
    #
    # The pitch represents the perceived fundamental frequency
    # of a sound; thus you can make a sound more acute or grave
    # by changing its pitch. A side effect of changing the pitch
    # is to modify the playing speed of the sound as well.
    # The default value for the pitch is 1.
    #
    # * *pitch* - New pitch to apply to the sound
    #
    # *See also:* `pitch`
    def pitch=(pitch : Number)
      SFMLExt.sfml_soundsource_setpitch_Bw9(to_unsafe, LibC::Float.new(pitch))
    end
    # Set the volume of the sound
    #
    # The volume is a value between 0 (mute) and 100 (full volume).
    # The default value for the volume is 100.
    #
    # * *volume* - Volume of the sound
    #
    # *See also:* `volume`
    def volume=(volume : Number)
      SFMLExt.sfml_soundsource_setvolume_Bw9(to_unsafe, LibC::Float.new(volume))
    end
    # Set the 3D position of the sound in the audio scene
    #
    # Only sounds with one channel (mono sounds) can be
    # spatialized.
    # The default position of a sound is (0, 0, 0).
    #
    # * *x* - X coordinate of the position of the sound in the scene
    # * *y* - Y coordinate of the position of the sound in the scene
    # * *z* - Z coordinate of the position of the sound in the scene
    #
    # *See also:* `position`
    def set_position(x : Number, y : Number, z : Number)
      SFMLExt.sfml_soundsource_setposition_Bw9Bw9Bw9(to_unsafe, LibC::Float.new(x), LibC::Float.new(y), LibC::Float.new(z))
    end
    # Set the 3D position of the sound in the audio scene
    #
    # Only sounds with one channel (mono sounds) can be
    # spatialized.
    # The default position of a sound is (0, 0, 0).
    #
    # * *position* - Position of the sound in the scene
    #
    # *See also:* `position`
    def position=(position : Vector3f)
      SFMLExt.sfml_soundsource_setposition_NzM(to_unsafe, position)
    end
    # Make the sound's position relative to the listener or absolute
    #
    # Making a sound relative to the listener will ensure that it will always
    # be played the same way regardless of the position of the listener.
    # This can be useful for non-spatialized sounds, sounds that are
    # produced by the listener, or sounds attached to it.
    # The default value is false (position is absolute).
    #
    # * *relative* - True to set the position relative, false to set it absolute
    #
    # *See also:* `relative_to_listener?`
    def relative_to_listener=(relative : Bool)
      SFMLExt.sfml_soundsource_setrelativetolistener_GZq(to_unsafe, relative)
    end
    # Set the minimum distance of the sound
    #
    # The "minimum distance" of a sound is the maximum
    # distance at which it is heard at its maximum volume. Further
    # than the minimum distance, it will start to fade out according
    # to its attenuation factor. A value of 0 ("inside the head
    # of the listener") is an invalid value and is forbidden.
    # The default value of the minimum distance is 1.
    #
    # * *distance* - New minimum distance of the sound
    #
    # *See also:* `min_distance`, `attenuation=`
    def min_distance=(distance : Number)
      SFMLExt.sfml_soundsource_setmindistance_Bw9(to_unsafe, LibC::Float.new(distance))
    end
    # Set the attenuation factor of the sound
    #
    # The attenuation is a multiplicative factor which makes
    # the sound more or less loud according to its distance
    # from the listener. An attenuation of 0 will produce a
    # non-attenuated sound, i.e. its volume will always be the same
    # whether it is heard from near or from far. On the other hand,
    # an attenuation value such as 100 will make the sound fade out
    # very quickly as it gets further from the listener.
    # The default value of the attenuation is 1.
    #
    # * *attenuation* - New attenuation factor of the sound
    #
    # *See also:* `attenuation`, `min_distance=`
    def attenuation=(attenuation : Number)
      SFMLExt.sfml_soundsource_setattenuation_Bw9(to_unsafe, LibC::Float.new(attenuation))
    end
    # Get the pitch of the sound
    #
    # *Returns:* Pitch of the sound
    #
    # *See also:* `pitch=`
    def pitch() : Float32
      SFMLExt.sfml_soundsource_getpitch(to_unsafe, out result)
      return result
    end
    # Get the volume of the sound
    #
    # *Returns:* Volume of the sound, in the range `0..100`
    #
    # *See also:* `volume=`
    def volume() : Float32
      SFMLExt.sfml_soundsource_getvolume(to_unsafe, out result)
      return result
    end
    # Get the 3D position of the sound in the audio scene
    #
    # *Returns:* Position of the sound
    #
    # *See also:* `position=`
    def position() : Vector3f
      result = Vector3f.allocate
      SFMLExt.sfml_soundsource_getposition(to_unsafe, result)
      return result
    end
    # Tell whether the sound's position is relative to the
    # listener or is absolute
    #
    # *Returns:* True if the position is relative, false if it's absolute
    #
    # *See also:* `relative_to_listener=`
    def relative_to_listener?() : Bool
      SFMLExt.sfml_soundsource_isrelativetolistener(to_unsafe, out result)
      return result
    end
    # Get the minimum distance of the sound
    #
    # *Returns:* Minimum distance of the sound
    #
    # *See also:* `min_distance=`, `attenuation`
    def min_distance() : Float32
      SFMLExt.sfml_soundsource_getmindistance(to_unsafe, out result)
      return result
    end
    # Get the attenuation factor of the sound
    #
    # *Returns:* Attenuation factor of the sound
    #
    # *See also:* `attenuation=`, `min_distance`
    def attenuation() : Float32
      SFMLExt.sfml_soundsource_getattenuation(to_unsafe, out result)
      return result
    end
    # Start or resume playing the sound source
    #
    # This function starts the source if it was stopped, resumes
    # it if it was paused, and restarts it from the beginning if
    # it was already playing.
    #
    # *See also:* `pause`, `stop`
    abstract def play()
    # Pause the sound source
    #
    # This function pauses the source if it was playing,
    # otherwise (source already paused or stopped) it has no effect.
    #
    # *See also:* `play`, `stop`
    abstract def pause()
    # Stop playing the sound source
    #
    # This function stops the source if it was playing or paused,
    # and does nothing if it was already stopped.
    # It also resets the playing position (unlike `pause()`).
    #
    # *See also:* `play`, `pause`
    abstract def stop()
    # Get the current status of the sound (stopped, paused, playing)
    #
    # *Returns:* Current status of the sound
    def status() : SoundSource::Status
      SFMLExt.sfml_soundsource_getstatus(to_unsafe, out result)
      return SoundSource::Status.new(result)
    end
    # Default constructor
    #
    # This constructor is meant to be called by derived classes only.
    protected def initialize()
      SFMLExt.sfml_soundsource_allocate(out @this)
      SFMLExt.sfml_soundsource_initialize(to_unsafe)
      SFMLExt.sfml_soundsource_parent(@this, self.as(Void*))
    end
    include AlResource
    # :nodoc:
    def to_unsafe()
      @this
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
  end
  SFMLExt.sfml_soundstream_ongetdata_callback(->(self : Void*, data : Int16**, data_size : LibC::SizeT*, result : Bool*) {
    output = self.as(SoundStream).on_get_data()
    data.value, data_size.value = output.to_unsafe, LibC::SizeT.new(output.size) if output
    result.value = !!output
  })
  SFMLExt.sfml_soundstream_onseek_callback(->(self : Void*, time_offset : Void*) {
    self.as(SoundStream).on_seek(time_offset.as(Time*).value)
  })
  SFMLExt.sfml_soundstream_onloop_callback(->(self : Void*, result : Int64*) {
    output = self.as(SoundStream).on_loop()
    result.value = Int64.new(output)
  })
  # Abstract base class for streamed audio sources
  #
  # Unlike audio buffers (see `SF::SoundBuffer`), audio streams
  # are never completely loaded in memory. Instead, the audio
  # data is acquired continuously while the stream is playing.
  # This behavior allows to play a sound with no loading delay,
  # and keeps the memory consumption very low.
  #
  # Sound sources that need to be streamed are usually big files
  # (compressed audio musics that would eat hundreds of MB in memory)
  # or files that would take a lot of time to be received
  # (sounds played over the network).
  #
  # `SF::SoundStream` is a base class that doesn't care about the
  # stream source, which is left to the derived class. SFML provides
  # a built-in specialization for big files (see `SF::Music`).
  # No network stream source is provided, but you can write your own
  # by combining this class with the network module.
  #
  # A derived class has to override two virtual functions:
  #
  # * on_get_data fills a new chunk of audio data to be played
  # * on_seek changes the current playing position in the source
  #
  # It is important to note that each SoundStream is played in its
  # own separate thread, so that the streaming loop doesn't block the
  # rest of the program. In particular, the OnGetData and OnSeek
  # virtual functions may sometimes be called from this separate thread.
  # It is important to keep this in mind, because you may have to take
  # care of synchronization issues if you share data between threads.
  #
  # Usage example:
  # ```crystal
  # class CustomStream < SF::SoundStream
  #   def initialize(location : String)
  #     # Open the source and get audio settings
  #     # [...]
  #
  #     # Initialize the stream -- important!
  #     super(channel_count, sample_rate)
  #   end
  #
  #   def on_get_data
  #     # Return a slice with audio data from the stream source
  #     # (note: must not be empty if you want to continue playing)
  #     Slice.new(samples.to_unsafe, samples.size)
  #   end
  #
  #   def on_seek(time_offset)
  #     # Change the current position in the stream source
  #   end
  # end
  #
  # # Usage
  # stream = CustomStream.new("path/to/stream")
  # stream.play
  # ```
  #
  # *See also:* `SF::Music`
  abstract class SoundStream < SoundSource
    @this : Void*
    # Destructor
    def finalize()
      SFMLExt.sfml_soundstream_finalize(to_unsafe)
      SFMLExt.sfml_soundstream_free(@this)
    end
    # Start or resume playing the audio stream
    #
    # This function starts the stream if it was stopped, resumes
    # it if it was paused, and restarts it from the beginning if
    # it was already playing.
    # This function uses its own thread so that it doesn't block
    # the rest of the program while the stream is played.
    #
    # *See also:* `pause`, `stop`
    def play()
      SFMLExt.sfml_soundstream_play(to_unsafe)
    end
    # Pause the audio stream
    #
    # This function pauses the stream if it was playing,
    # otherwise (stream already paused or stopped) it has no effect.
    #
    # *See also:* `play`, `stop`
    def pause()
      SFMLExt.sfml_soundstream_pause(to_unsafe)
    end
    # Stop playing the audio stream
    #
    # This function stops the stream if it was playing or paused,
    # and does nothing if it was already stopped.
    # It also resets the playing position (unlike `pause()`).
    #
    # *See also:* `play`, `pause`
    def stop()
      SFMLExt.sfml_soundstream_stop(to_unsafe)
    end
    # Return the number of channels of the stream
    #
    # 1 channel means a mono sound, 2 means stereo, etc.
    #
    # *Returns:* Number of channels
    def channel_count() : Int32
      SFMLExt.sfml_soundstream_getchannelcount(to_unsafe, out result)
      return result.to_i
    end
    # Get the stream sample rate of the stream
    #
    # The sample rate is the number of audio samples played per
    # second. The higher, the better the quality.
    #
    # *Returns:* Sample rate, in number of samples per second
    def sample_rate() : Int32
      SFMLExt.sfml_soundstream_getsamplerate(to_unsafe, out result)
      return result.to_i
    end
    # Get the current status of the stream (stopped, paused, playing)
    #
    # *Returns:* Current status
    def status() : SoundSource::Status
      SFMLExt.sfml_soundstream_getstatus(to_unsafe, out result)
      return SoundSource::Status.new(result)
    end
    # Change the current playing position of the stream
    #
    # The playing position can be changed when the stream is
    # either paused or playing. Changing the playing position
    # when the stream is stopped has no effect, since playing
    # the stream would reset its position.
    #
    # * *time_offset* - New playing position, from the beginning of the stream
    #
    # *See also:* `playing_offset`
    def playing_offset=(time_offset : Time)
      SFMLExt.sfml_soundstream_setplayingoffset_f4T(to_unsafe, time_offset)
    end
    # Get the current playing position of the stream
    #
    # *Returns:* Current playing position, from the beginning of the stream
    #
    # *See also:* `playing_offset=`
    def playing_offset() : Time
      result = Time.allocate
      SFMLExt.sfml_soundstream_getplayingoffset(to_unsafe, result)
      return result
    end
    # Set whether or not the stream should loop after reaching the end
    #
    # If set, the stream will restart from beginning after
    # reaching the end and so on, until it is stopped or
    # loop=(false) is called.
    # The default looping state for streams is false.
    #
    # * *loop* - True to play in loop, false to play once
    #
    # *See also:* `loop`
    def loop=(loop : Bool)
      SFMLExt.sfml_soundstream_setloop_GZq(to_unsafe, loop)
    end
    # Tell whether or not the stream is in loop mode
    #
    # *Returns:* True if the stream is looping, false otherwise
    #
    # *See also:* `loop=`
    def loop() : Bool
      SFMLExt.sfml_soundstream_getloop(to_unsafe, out result)
      return result
    end
    # "Invalid" end_seeks value, telling us to continue uninterrupted
    NoLoop = -1
    # Default constructor
    #
    # This constructor is only meant to be called by derived classes.
    protected def initialize()
      SFMLExt.sfml_soundstream_allocate(out @this)
      SFMLExt.sfml_soundstream_initialize(to_unsafe)
      SFMLExt.sfml_soundstream_parent(@this, self.as(Void*))
    end
    # Define the audio stream parameters
    #
    # This function must be called by derived classes as soon
    # as they know the audio settings of the stream to play.
    # Any attempt to manipulate the stream (play(), ...) before
    # calling this function will fail.
    # It can be called multiple times if the settings of the
    # audio stream change, but only when the stream is stopped.
    #
    # * *channel_count* - Number of channels of the stream
    # * *sample_rate* - Sample rate, in samples per second
    def initialize(channel_count : Int, sample_rate : Int)
      SFMLExt.sfml_soundstream_allocate(out @this)
      SFMLExt.sfml_soundstream_initialize(to_unsafe)
      SFMLExt.sfml_soundstream_initialize_emSemS(to_unsafe, LibC::UInt.new(channel_count), LibC::UInt.new(sample_rate))
      SFMLExt.sfml_soundstream_parent(@this, self.as(Void*))
    end
    # Request a new chunk of audio samples from the stream source
    #
    # This function must be overridden by derived classes to provide
    # the audio samples to play. It is called continuously by the
    # streaming loop, in a separate thread.
    # The source can choose to stop the streaming loop at any time, by
    # returning false to the caller.
    # If you return true (i.e. continue streaming) it is important that
    # the returned array of samples is not empty; this would stop the stream
    # due to an internal limitation.
    #
    # * *data* - Chunk of data to fill
    #
    # *Returns:* True to continue playback, false to stop
    abstract def on_get_data() : Slice(Int16)?
    # Change the current playing position in the stream source
    #
    # This function must be overridden by derived classes to
    # allow random seeking into the stream source.
    #
    # * *time_offset* - New playing position, relative to the beginning of the stream
    abstract def on_seek(time_offset : Time)
    # Change the current playing position in the stream source to the beginning of the loop
    #
    # This function can be overridden by derived classes to
    # allow implementation of custom loop points. Otherwise,
    # it just calls `on_seek(Time::Zero)` and returns 0.
    #
    # *Returns:* The seek position after looping (or -1 if there's no loop)
    def on_loop() : Int64
      SFMLExt.sfml_soundstream_onloop(to_unsafe, out result)
      return result
    end
    # :nodoc:
    def pitch=(pitch : Number)
      SFMLExt.sfml_soundstream_setpitch_Bw9(to_unsafe, LibC::Float.new(pitch))
    end
    # :nodoc:
    def volume=(volume : Number)
      SFMLExt.sfml_soundstream_setvolume_Bw9(to_unsafe, LibC::Float.new(volume))
    end
    # :nodoc:
    def set_position(x : Number, y : Number, z : Number)
      SFMLExt.sfml_soundstream_setposition_Bw9Bw9Bw9(to_unsafe, LibC::Float.new(x), LibC::Float.new(y), LibC::Float.new(z))
    end
    # :nodoc:
    def position=(position : Vector3f)
      SFMLExt.sfml_soundstream_setposition_NzM(to_unsafe, position)
    end
    # :nodoc:
    def relative_to_listener=(relative : Bool)
      SFMLExt.sfml_soundstream_setrelativetolistener_GZq(to_unsafe, relative)
    end
    # :nodoc:
    def min_distance=(distance : Number)
      SFMLExt.sfml_soundstream_setmindistance_Bw9(to_unsafe, LibC::Float.new(distance))
    end
    # :nodoc:
    def attenuation=(attenuation : Number)
      SFMLExt.sfml_soundstream_setattenuation_Bw9(to_unsafe, LibC::Float.new(attenuation))
    end
    # :nodoc:
    def pitch() : Float32
      SFMLExt.sfml_soundstream_getpitch(to_unsafe, out result)
      return result
    end
    # :nodoc:
    def volume() : Float32
      SFMLExt.sfml_soundstream_getvolume(to_unsafe, out result)
      return result
    end
    # :nodoc:
    def position() : Vector3f
      result = Vector3f.allocate
      SFMLExt.sfml_soundstream_getposition(to_unsafe, result)
      return result
    end
    # :nodoc:
    def relative_to_listener?() : Bool
      SFMLExt.sfml_soundstream_isrelativetolistener(to_unsafe, out result)
      return result
    end
    # :nodoc:
    def min_distance() : Float32
      SFMLExt.sfml_soundstream_getmindistance(to_unsafe, out result)
      return result
    end
    # :nodoc:
    def attenuation() : Float32
      SFMLExt.sfml_soundstream_getattenuation(to_unsafe, out result)
      return result
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
  end
  # Streamed music played from an audio file
  #
  # Musics are sounds that are streamed rather than completely
  # loaded in memory. This is especially useful for compressed
  # musics that usually take hundreds of MB when they are
  # uncompressed: by streaming it instead of loading it entirely,
  # you avoid saturating the memory and have almost no loading delay.
  # This implies that the underlying resource (file, stream or
  # memory buffer) must remain valid for the lifetime of the
  # `SF::Music` object.
  #
  # Apart from that, a `SF::Music` has almost the same features as
  # the `SF::SoundBuffer` / `SF::Sound` pair: you can play/pause/stop
  # it, request its parameters (channels, sample rate), change
  # the way it is played (pitch, volume, 3D position, ...), etc.
  #
  # As a sound stream, a music is played in its own thread in order
  # not to block the rest of the program. This means that you can
  # leave the music alone after calling `play()`, it will manage itself
  # very well.
  #
  # Usage example:
  # ```crystal
  # # Declare a new music
  # music = SF::Music.new
  #
  # # Open it from an audio file
  # if !music.open_from_file("music.ogg")
  #   # error...
  # end
  #
  # # Change some parameters
  # music.set_position(0, 1, 10) # change its 3D position
  # music.pitch = 2              # increase the pitch
  # music.volume = 50            # reduce the volume
  # music.loop = true            # make it loop
  #
  # # Play it
  # music.play
  # ```
  #
  # *See also:* `SF::Sound`, `SF::SoundStream`
  class Music < SoundStream
    @this : Void*
    # Default constructor
    def initialize()
      SFMLExt.sfml_music_allocate(out @this)
      SFMLExt.sfml_music_initialize(to_unsafe)
    end
    # Destructor
    def finalize()
      SFMLExt.sfml_music_finalize(to_unsafe)
      SFMLExt.sfml_music_free(@this)
    end
    # Open a music from an audio file
    #
    # This function doesn't start playing the music (call `play()`
    # to do so).
    # See the documentation of `SF::InputSoundFile` for the list
    # of supported formats.
    #
    # WARNING: Since the music is not loaded at once but rather
    # streamed continuously, the file must remain accessible until
    # the `SF::Music` object loads a new music or is destroyed.
    #
    # * *filename* - Path of the music file to open
    #
    # *Returns:* True if loading succeeded, false if it failed
    #
    # *See also:* `open_from_memory`, `open_from_stream`
    def open_from_file(filename : String) : Bool
      SFMLExt.sfml_music_openfromfile_zkC(to_unsafe, filename.bytesize, filename, out result)
      return result
    end
    # Shorthand for `music = Music.new; music.open_from_file(...); music`
    #
    # Raises `InitError` on failure
    def self.from_file(*args, **kwargs) : self
      obj = new
      if !obj.open_from_file(*args, **kwargs)
        raise InitError.new("Music.open_from_file failed")
      end
      obj
    end
    # Open a music from an audio file in memory
    #
    # This function doesn't start playing the music (call `play()`
    # to do so).
    # See the documentation of `SF::InputSoundFile` for the list
    # of supported formats.
    #
    # WARNING: Since the music is not loaded at once but rather streamed
    # continuously, the *data* buffer must remain accessible until
    # the `SF::Music` object loads a new music or is destroyed. That is,
    # you can't deallocate the buffer right after calling this function.
    #
    # * *data* - Slice containing the file data in memory
    #
    # *Returns:* True if loading succeeded, false if it failed
    #
    # *See also:* `open_from_file`, `open_from_stream`
    def open_from_memory(data : Slice) : Bool
      SFMLExt.sfml_music_openfrommemory_5h8vgv(to_unsafe, data, data.bytesize, out result)
      return result
    end
    # Shorthand for `music = Music.new; music.open_from_memory(...); music`
    #
    # Raises `InitError` on failure
    def self.from_memory(*args, **kwargs) : self
      obj = new
      if !obj.open_from_memory(*args, **kwargs)
        raise InitError.new("Music.open_from_memory failed")
      end
      obj
    end
    # Open a music from an audio file in a custom stream
    #
    # This function doesn't start playing the music (call `play()`
    # to do so).
    # See the documentation of `SF::InputSoundFile` for the list
    # of supported formats.
    #
    # WARNING: Since the music is not loaded at once but rather
    # streamed continuously, the *stream* must remain accessible
    # until the `SF::Music` object loads a new music or is destroyed.
    #
    # * *stream* - Source stream to read from
    #
    # *Returns:* True if loading succeeded, false if it failed
    #
    # *See also:* `open_from_file`, `open_from_memory`
    def open_from_stream(stream : InputStream) : Bool
      SFMLExt.sfml_music_openfromstream_PO0(to_unsafe, stream, out result)
      return result
    end
    # Shorthand for `music = Music.new; music.open_from_stream(...); music`
    #
    # Raises `InitError` on failure
    def self.from_stream(*args, **kwargs) : self
      obj = new
      if !obj.open_from_stream(*args, **kwargs)
        raise InitError.new("Music.open_from_stream failed")
      end
      obj
    end
    # Get the total duration of the music
    #
    # *Returns:* Music duration
    def duration() : Time
      result = Time.allocate
      SFMLExt.sfml_music_getduration(to_unsafe, result)
      return result
    end
    # Get the positions of the of the sound's looping sequence
    #
    # *Returns:* Loop Time position class.
    #
    # WARNING: Since `loop_points=()` performs some adjustments on the
    # provided values and rounds them to internal samples, a call to
    # `loop_points()` is not guaranteed to return the same times passed
    # into a previous call to `loop_points=()`. However, it is guaranteed
    # to return times that will map to the valid internal samples of
    # this Music if they are later passed to `loop_points=()`.
    #
    # *See also:* `loop_points=`
    def loop_points() : Music::TimeSpan
      result = Music::TimeSpan.allocate
      SFMLExt.sfml_music_getlooppoints(to_unsafe, result)
      return result
    end
    # Sets the beginning and end of the sound's looping sequence using `SF::Time`
    #
    # Loop points allow one to specify a pair of positions such that, when the music
    # is enabled for looping, it will seamlessly seek to the beginning whenever it
    # encounters the end. Valid ranges for time_points.offset and time_points.length are
    # [0, Dur) and (0, Dur-offset] respectively, where Dur is the value returned by `duration()`.
    # Note that the EOF "loop point" from the end to the beginning of the stream is still honored,
    # in case the caller seeks to a point after the end of the loop range. This function can be
    # safely called at any point after a stream is opened, and will be applied to a playing sound
    # without affecting the current playing offset.
    #
    # WARNING: Setting the loop points while the stream's status is `Paused`
    # will set its status to `Stopped`. The playing offset will be unaffected.
    #
    # * *time_points* - The definition of the loop. Can be any time points within the sound's length
    #
    # *See also:* `loop_points`
    def loop_points=(time_points : Music::TimeSpan)
      SFMLExt.sfml_music_setlooppoints_TU3(to_unsafe, time_points)
    end
    # Request a new chunk of audio samples from the stream source
    #
    # This function fills the chunk from the next samples
    # to read from the audio file.
    #
    # * *data* - Chunk of data to fill
    #
    # *Returns:* True to continue playback, false to stop
    def on_get_data() : Slice(Int16)?
      nil
    end
    # Change the current playing position in the stream source
    #
    # * *time_offset* - New playing position, from the beginning of the music
    def on_seek(time_offset : Time)
    end
    # Change the current playing position in the stream source to the loop offset
    #
    # This is called by the underlying SoundStream whenever it needs us to reset
    # the seek position for a loop. We then determine whether we are looping on a
    # loop point or the end-of-file, perform the seek, and return the new position.
    #
    # *Returns:* The seek position after looping (or -1 if there's no loop)
    def on_loop() : Int64
      Int64.zero
    end
    # :nodoc:
    def play()
      SFMLExt.sfml_music_play(to_unsafe)
    end
    # :nodoc:
    def pause()
      SFMLExt.sfml_music_pause(to_unsafe)
    end
    # :nodoc:
    def stop()
      SFMLExt.sfml_music_stop(to_unsafe)
    end
    # :nodoc:
    def channel_count() : Int32
      SFMLExt.sfml_music_getchannelcount(to_unsafe, out result)
      return result.to_i
    end
    # :nodoc:
    def sample_rate() : Int32
      SFMLExt.sfml_music_getsamplerate(to_unsafe, out result)
      return result.to_i
    end
    # :nodoc:
    def status() : SoundSource::Status
      SFMLExt.sfml_music_getstatus(to_unsafe, out result)
      return SoundSource::Status.new(result)
    end
    # :nodoc:
    def playing_offset=(time_offset : Time)
      SFMLExt.sfml_music_setplayingoffset_f4T(to_unsafe, time_offset)
    end
    # :nodoc:
    def playing_offset() : Time
      result = Time.allocate
      SFMLExt.sfml_music_getplayingoffset(to_unsafe, result)
      return result
    end
    # :nodoc:
    def loop=(loop : Bool)
      SFMLExt.sfml_music_setloop_GZq(to_unsafe, loop)
    end
    # :nodoc:
    def loop() : Bool
      SFMLExt.sfml_music_getloop(to_unsafe, out result)
      return result
    end
    # :nodoc:
    def initialize(channel_count : Int, sample_rate : Int)
      SFMLExt.sfml_music_allocate(out @this)
      SFMLExt.sfml_music_initialize(to_unsafe)
      SFMLExt.sfml_music_initialize_emSemS(to_unsafe, LibC::UInt.new(channel_count), LibC::UInt.new(sample_rate))
    end
    # :nodoc:
    def pitch=(pitch : Number)
      SFMLExt.sfml_music_setpitch_Bw9(to_unsafe, LibC::Float.new(pitch))
    end
    # :nodoc:
    def volume=(volume : Number)
      SFMLExt.sfml_music_setvolume_Bw9(to_unsafe, LibC::Float.new(volume))
    end
    # :nodoc:
    def set_position(x : Number, y : Number, z : Number)
      SFMLExt.sfml_music_setposition_Bw9Bw9Bw9(to_unsafe, LibC::Float.new(x), LibC::Float.new(y), LibC::Float.new(z))
    end
    # :nodoc:
    def position=(position : Vector3f)
      SFMLExt.sfml_music_setposition_NzM(to_unsafe, position)
    end
    # :nodoc:
    def relative_to_listener=(relative : Bool)
      SFMLExt.sfml_music_setrelativetolistener_GZq(to_unsafe, relative)
    end
    # :nodoc:
    def min_distance=(distance : Number)
      SFMLExt.sfml_music_setmindistance_Bw9(to_unsafe, LibC::Float.new(distance))
    end
    # :nodoc:
    def attenuation=(attenuation : Number)
      SFMLExt.sfml_music_setattenuation_Bw9(to_unsafe, LibC::Float.new(attenuation))
    end
    # :nodoc:
    def pitch() : Float32
      SFMLExt.sfml_music_getpitch(to_unsafe, out result)
      return result
    end
    # :nodoc:
    def volume() : Float32
      SFMLExt.sfml_music_getvolume(to_unsafe, out result)
      return result
    end
    # :nodoc:
    def position() : Vector3f
      result = Vector3f.allocate
      SFMLExt.sfml_music_getposition(to_unsafe, result)
      return result
    end
    # :nodoc:
    def relative_to_listener?() : Bool
      SFMLExt.sfml_music_isrelativetolistener(to_unsafe, out result)
      return result
    end
    # :nodoc:
    def min_distance() : Float32
      SFMLExt.sfml_music_getmindistance(to_unsafe, out result)
      return result
    end
    # :nodoc:
    def attenuation() : Float32
      SFMLExt.sfml_music_getattenuation(to_unsafe, out result)
      return result
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
  end
  # Regular sound that can be played in the audio environment
  #
  # `SF::Sound` is the class to use to play sounds.
  # It provides:
  #
  # * Control (play, pause, stop)
  # * Ability to modify output parameters in real-time (pitch, volume, ...)
  # * 3D spatial features (position, attenuation, ...).
  #
  # `SF::Sound` is perfect for playing short sounds that can
  # fit in memory and require no latency, like foot steps or
  # gun shots. For longer sounds, like background musics
  # or long speeches, rather see `SF::Music` (which is based
  # on streaming).
  #
  # In order to work, a sound must be given a buffer of audio
  # data to play. Audio data (samples) is stored in `SF::SoundBuffer`,
  # and attached to a sound with the `buffer=()` function.
  # The buffer object attached to a sound must remain alive
  # as long as the sound uses it. Note that multiple sounds
  # can use the same sound buffer at the same time.
  #
  # Usage example:
  # ```crystal
  # buffer = SF::SoundBuffer.from_file("sound.wav")
  #
  # sound = SF::Sound.new
  # sound.buffer = buffer
  # sound.play
  # ```
  #
  # *See also:* `SF::SoundBuffer`, `SF::Music`
  class Sound < SoundSource
    @this : Void*
    # Default constructor
    def initialize()
      SFMLExt.sfml_sound_allocate(out @this)
      SFMLExt.sfml_sound_initialize(to_unsafe)
    end
    # Construct the sound with a buffer
    #
    # * *buffer* - Sound buffer containing the audio data to play with the sound
    def initialize(buffer : SoundBuffer)
      SFMLExt.sfml_sound_allocate(out @this)
      @_sound_buffer = buffer
      SFMLExt.sfml_sound_initialize_mWu(to_unsafe, buffer)
    end
    # Destructor
    def finalize()
      SFMLExt.sfml_sound_finalize(to_unsafe)
      SFMLExt.sfml_sound_free(@this)
    end
    # Start or resume playing the sound
    #
    # This function starts the stream if it was stopped, resumes
    # it if it was paused, and restarts it from beginning if it
    # was it already playing.
    # This function uses its own thread so that it doesn't block
    # the rest of the program while the sound is played.
    #
    # *See also:* `pause`, `stop`
    def play()
      SFMLExt.sfml_sound_play(to_unsafe)
    end
    # Pause the sound
    #
    # This function pauses the sound if it was playing,
    # otherwise (sound already paused or stopped) it has no effect.
    #
    # *See also:* `play`, `stop`
    def pause()
      SFMLExt.sfml_sound_pause(to_unsafe)
    end
    # stop playing the sound
    #
    # This function stops the sound if it was playing or paused,
    # and does nothing if it was already stopped.
    # It also resets the playing position (unlike `pause()`).
    #
    # *See also:* `play`, `pause`
    def stop()
      SFMLExt.sfml_sound_stop(to_unsafe)
    end
    # Set the source buffer containing the audio data to play
    #
    # It is important to note that the sound buffer is not copied,
    # thus the `SF::SoundBuffer` instance must remain alive as long
    # as it is attached to the sound.
    #
    # * *buffer* - Sound buffer to attach to the sound
    #
    # *See also:* `buffer`
    def buffer=(buffer : SoundBuffer)
      @_sound_buffer = buffer
      SFMLExt.sfml_sound_setbuffer_mWu(to_unsafe, buffer)
    end
    @_sound_buffer : SoundBuffer? = nil
    # Set whether or not the sound should loop after reaching the end
    #
    # If set, the sound will restart from beginning after
    # reaching the end and so on, until it is stopped or
    # `loop=(false)` is called.
    # The default looping state for sound is false.
    #
    # * *loop* - True to play in loop, false to play once
    #
    # *See also:* `loop`
    def loop=(loop : Bool)
      SFMLExt.sfml_sound_setloop_GZq(to_unsafe, loop)
    end
    # Change the current playing position of the sound
    #
    # The playing position can be changed when the sound is
    # either paused or playing. Changing the playing position
    # when the sound is stopped has no effect, since playing
    # the sound will reset its position.
    #
    # * *time_offset* - New playing position, from the beginning of the sound
    #
    # *See also:* `playing_offset`
    def playing_offset=(time_offset : Time)
      SFMLExt.sfml_sound_setplayingoffset_f4T(to_unsafe, time_offset)
    end
    # Get the audio buffer attached to the sound
    #
    # *Returns:* Sound buffer attached to the sound (can be NULL)
    def buffer() : SoundBuffer?
      return @_sound_buffer
    end
    # Tell whether or not the sound is in loop mode
    #
    # *Returns:* True if the sound is looping, false otherwise
    #
    # *See also:* `loop=`
    def loop() : Bool
      SFMLExt.sfml_sound_getloop(to_unsafe, out result)
      return result
    end
    # Get the current playing position of the sound
    #
    # *Returns:* Current playing position, from the beginning of the sound
    #
    # *See also:* `playing_offset=`
    def playing_offset() : Time
      result = Time.allocate
      SFMLExt.sfml_sound_getplayingoffset(to_unsafe, result)
      return result
    end
    # Get the current status of the sound (stopped, paused, playing)
    #
    # *Returns:* Current status of the sound
    def status() : SoundSource::Status
      SFMLExt.sfml_sound_getstatus(to_unsafe, out result)
      return SoundSource::Status.new(result)
    end
    # Reset the internal buffer of the sound
    #
    # This function is for internal use only, you don't have
    # to use it. It is called by the `SF::SoundBuffer` that
    # this sound uses, when it is destroyed in order to prevent
    # the sound from using a dead buffer.
    def reset_buffer()
      SFMLExt.sfml_sound_resetbuffer(to_unsafe)
    end
    # :nodoc:
    def buffer() : SoundBuffer?
      return @_sound_buffer
    end
    # :nodoc:
    def pitch=(pitch : Number)
      SFMLExt.sfml_sound_setpitch_Bw9(to_unsafe, LibC::Float.new(pitch))
    end
    # :nodoc:
    def volume=(volume : Number)
      SFMLExt.sfml_sound_setvolume_Bw9(to_unsafe, LibC::Float.new(volume))
    end
    # :nodoc:
    def set_position(x : Number, y : Number, z : Number)
      SFMLExt.sfml_sound_setposition_Bw9Bw9Bw9(to_unsafe, LibC::Float.new(x), LibC::Float.new(y), LibC::Float.new(z))
    end
    # :nodoc:
    def position=(position : Vector3f)
      SFMLExt.sfml_sound_setposition_NzM(to_unsafe, position)
    end
    # :nodoc:
    def relative_to_listener=(relative : Bool)
      SFMLExt.sfml_sound_setrelativetolistener_GZq(to_unsafe, relative)
    end
    # :nodoc:
    def min_distance=(distance : Number)
      SFMLExt.sfml_sound_setmindistance_Bw9(to_unsafe, LibC::Float.new(distance))
    end
    # :nodoc:
    def attenuation=(attenuation : Number)
      SFMLExt.sfml_sound_setattenuation_Bw9(to_unsafe, LibC::Float.new(attenuation))
    end
    # :nodoc:
    def pitch() : Float32
      SFMLExt.sfml_sound_getpitch(to_unsafe, out result)
      return result
    end
    # :nodoc:
    def volume() : Float32
      SFMLExt.sfml_sound_getvolume(to_unsafe, out result)
      return result
    end
    # :nodoc:
    def position() : Vector3f
      result = Vector3f.allocate
      SFMLExt.sfml_sound_getposition(to_unsafe, result)
      return result
    end
    # :nodoc:
    def relative_to_listener?() : Bool
      SFMLExt.sfml_sound_isrelativetolistener(to_unsafe, out result)
      return result
    end
    # :nodoc:
    def min_distance() : Float32
      SFMLExt.sfml_sound_getmindistance(to_unsafe, out result)
      return result
    end
    # :nodoc:
    def attenuation() : Float32
      SFMLExt.sfml_sound_getattenuation(to_unsafe, out result)
      return result
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
  end
  # Storage for audio samples defining a sound
  #
  # A sound buffer holds the data of a sound, which is
  # an array of audio samples. A sample is a 16 bits signed integer
  # that defines the amplitude of the sound at a given time.
  # The sound is then reconstituted by playing these samples at
  # a high rate (for example, 44100 samples per second is the
  # standard rate used for playing CDs). In short, audio samples
  # are like texture pixels, and a `SF::SoundBuffer` is similar to
  # a `SF::Texture`.
  #
  # A sound buffer can be loaded from a file (see `load_from_file()`
  # for the complete list of supported formats), from memory, from
  # a custom stream (see `SF::InputStream`) or directly from an array
  # of samples. It can also be saved back to a file.
  #
  # Sound buffers alone are not very useful: they hold the audio data
  # but cannot be played. To do so, you need to use the `SF::Sound` class,
  # which provides functions to play/pause/stop the sound as well as
  # changing the way it is outputted (volume, pitch, 3D position, ...).
  # This separation allows more flexibility and better performances:
  # indeed a `SF::SoundBuffer` is a heavy resource, and any operation on it
  # is slow (often too slow for real-time applications). On the other
  # side, a `SF::Sound` is a lightweight object, which can use the audio data
  # of a sound buffer and change the way it is played without actually
  # modifying that data. Note that it is also possible to bind
  # several `SF::Sound` instances to the same `SF::SoundBuffer`.
  #
  # It is important to note that the `SF::Sound` instance doesn't
  # copy the buffer that it uses, it only keeps a reference to it.
  # Thus, a `SF::SoundBuffer` must not be destructed while it is
  # used by a `SF::Sound` (i.e. never write a function that
  # uses a local `SF::SoundBuffer` instance for loading a sound).
  #
  # Usage example:
  # ```crystal
  # # Load a new sound buffer from a file
  # buffer = SF::SoundBuffer.from_file("sound.wav")
  #
  # # Create a sound source and bind it to the buffer
  # sound1 = SF::Sound.new
  # sound1.buffer = buffer
  #
  # # Play the sound
  # sound1.play
  #
  # # Create another sound source bound to the same buffer
  # sound2 = SF::Sound.new
  # sound2.buffer = buffer
  #
  # # Play it with a higher pitch -- the first sound remains unchanged
  # sound2.pitch = 2
  # sound2.play
  # ```
  #
  # *See also:* `SF::Sound`, `SF::SoundBufferRecorder`
  class SoundBuffer
    @this : Void*
    # Default constructor
    def initialize()
      SFMLExt.sfml_soundbuffer_allocate(out @this)
      SFMLExt.sfml_soundbuffer_initialize(to_unsafe)
    end
    # Destructor
    def finalize()
      SFMLExt.sfml_soundbuffer_finalize(to_unsafe)
      SFMLExt.sfml_soundbuffer_free(@this)
    end
    # Load the sound buffer from a file
    #
    # See the documentation of `SF::InputSoundFile` for the list
    # of supported formats.
    #
    # * *filename* - Path of the sound file to load
    #
    # *Returns:* True if loading succeeded, false if it failed
    #
    # *See also:* `load_from_memory`, `load_from_stream`, `load_from_samples`, `save_to_file`
    def load_from_file(filename : String) : Bool
      SFMLExt.sfml_soundbuffer_loadfromfile_zkC(to_unsafe, filename.bytesize, filename, out result)
      return result
    end
    # Shorthand for `sound_buffer = SoundBuffer.new; sound_buffer.load_from_file(...); sound_buffer`
    #
    # Raises `InitError` on failure
    def self.from_file(*args, **kwargs) : self
      obj = new
      if !obj.load_from_file(*args, **kwargs)
        raise InitError.new("SoundBuffer.load_from_file failed")
      end
      obj
    end
    # Load the sound buffer from a file in memory
    #
    # See the documentation of `SF::InputSoundFile` for the list
    # of supported formats.
    #
    # * *data* - Slice containing the file data in memory
    #
    # *Returns:* True if loading succeeded, false if it failed
    #
    # *See also:* `load_from_file`, `load_from_stream`, `load_from_samples`
    def load_from_memory(data : Slice) : Bool
      SFMLExt.sfml_soundbuffer_loadfrommemory_5h8vgv(to_unsafe, data, data.bytesize, out result)
      return result
    end
    # Shorthand for `sound_buffer = SoundBuffer.new; sound_buffer.load_from_memory(...); sound_buffer`
    #
    # Raises `InitError` on failure
    def self.from_memory(*args, **kwargs) : self
      obj = new
      if !obj.load_from_memory(*args, **kwargs)
        raise InitError.new("SoundBuffer.load_from_memory failed")
      end
      obj
    end
    # Load the sound buffer from a custom stream
    #
    # See the documentation of `SF::InputSoundFile` for the list
    # of supported formats.
    #
    # * *stream* - Source stream to read from
    #
    # *Returns:* True if loading succeeded, false if it failed
    #
    # *See also:* `load_from_file`, `load_from_memory`, `load_from_samples`
    def load_from_stream(stream : InputStream) : Bool
      SFMLExt.sfml_soundbuffer_loadfromstream_PO0(to_unsafe, stream, out result)
      return result
    end
    # Shorthand for `sound_buffer = SoundBuffer.new; sound_buffer.load_from_stream(...); sound_buffer`
    #
    # Raises `InitError` on failure
    def self.from_stream(*args, **kwargs) : self
      obj = new
      if !obj.load_from_stream(*args, **kwargs)
        raise InitError.new("SoundBuffer.load_from_stream failed")
      end
      obj
    end
    # Load the sound buffer from an array of audio samples
    #
    # The assumed format of the audio samples is 16 bits signed integer
    # (`SF::Int16`).
    #
    # * *samples* - Pointer to the array of samples in memory
    # * *sample_count* - Number of samples in the array
    # * *channel_count* - Number of channels (1 = mono, 2 = stereo, ...)
    # * *sample_rate* - Sample rate (number of samples to play per second)
    #
    # *Returns:* True if loading succeeded, false if it failed
    #
    # *See also:* `load_from_file`, `load_from_memory`, `save_to_file`
    def load_from_samples(samples : Array(Int16) | Slice(Int16), channel_count : Int, sample_rate : Int) : Bool
      SFMLExt.sfml_soundbuffer_loadfromsamples_xzLJvtemSemS(to_unsafe, samples, samples.size, LibC::UInt.new(channel_count), LibC::UInt.new(sample_rate), out result)
      return result
    end
    # Shorthand for `sound_buffer = SoundBuffer.new; sound_buffer.load_from_samples(...); sound_buffer`
    #
    # Raises `InitError` on failure
    def self.from_samples(*args, **kwargs) : self
      obj = new
      if !obj.load_from_samples(*args, **kwargs)
        raise InitError.new("SoundBuffer.load_from_samples failed")
      end
      obj
    end
    # Save the sound buffer to an audio file
    #
    # See the documentation of `SF::OutputSoundFile` for the list
    # of supported formats.
    #
    # * *filename* - Path of the sound file to write
    #
    # *Returns:* True if saving succeeded, false if it failed
    #
    # *See also:* `load_from_file`, `load_from_memory`, `load_from_samples`
    def save_to_file(filename : String) : Bool
      SFMLExt.sfml_soundbuffer_savetofile_zkC(to_unsafe, filename.bytesize, filename, out result)
      return result
    end
    # Get the array of audio samples stored in the buffer
    #
    # The format of the returned samples is 16 bits signed integer
    # (`SF::Int16`). The total number of samples in this array
    # is given by the `sample_count()` function.
    #
    # *Returns:* Read-only pointer to the array of sound samples
    #
    # *See also:* `sample_count`
    def samples() : Int16*
      SFMLExt.sfml_soundbuffer_getsamples(to_unsafe, out result)
      return result
    end
    # Get the number of samples stored in the buffer
    #
    # The array of samples can be accessed with the `samples()`
    # function.
    #
    # *Returns:* Number of samples
    #
    # *See also:* `samples`
    def sample_count() : UInt64
      SFMLExt.sfml_soundbuffer_getsamplecount(to_unsafe, out result)
      return result
    end
    # Get the sample rate of the sound
    #
    # The sample rate is the number of samples played per second.
    # The higher, the better the quality (for example, 44100
    # samples/s is CD quality).
    #
    # *Returns:* Sample rate (number of samples per second)
    #
    # *See also:* `channel_count`, `duration`
    def sample_rate() : Int32
      SFMLExt.sfml_soundbuffer_getsamplerate(to_unsafe, out result)
      return result.to_i
    end
    # Get the number of channels used by the sound
    #
    # If the sound is mono then the number of channels will
    # be 1, 2 for stereo, etc.
    #
    # *Returns:* Number of channels
    #
    # *See also:* `sample_rate`, `duration`
    def channel_count() : Int32
      SFMLExt.sfml_soundbuffer_getchannelcount(to_unsafe, out result)
      return result.to_i
    end
    # Get the total duration of the sound
    #
    # *Returns:* Sound duration
    #
    # *See also:* `sample_rate`, `channel_count`
    def duration() : Time
      result = Time.allocate
      SFMLExt.sfml_soundbuffer_getduration(to_unsafe, result)
      return result
    end
    include AlResource
    # :nodoc:
    def to_unsafe()
      @this
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
  end
  SFMLExt.sfml_soundrecorder_onstart_callback(->(self : Void*, result : Bool*) {
    output = self.as(SoundRecorder).on_start()
    result.value = !!output
  })
  SFMLExt.sfml_soundrecorder_onprocesssamples_callback(->(self : Void*, samples : Int16*, sample_count : LibC::SizeT, result : Bool*) {
    output = self.as(SoundRecorder).on_process_samples(Slice(Int16).new(samples, sample_count))
    result.value = !!output
  })
  SFMLExt.sfml_soundrecorder_onstop_callback(->(self : Void*) {
    self.as(SoundRecorder).on_stop()
  })
  # Abstract base class for capturing sound data
  #
  # `SF::SoundBuffer` provides a simple interface to access
  # the audio recording capabilities of the computer
  # (the microphone). As an abstract base class, it only cares
  # about capturing sound samples, the task of making something
  # useful with them is left to the derived class. Note that
  # SFML provides a built-in specialization for saving the
  # captured data to a sound buffer (see `SF::SoundBufferRecorder`).
  #
  # A derived class has only one virtual function to override:
  #
  # * on_process_samples provides the new chunks of audio samples while the capture happens
  #
  # Moreover, two additional virtual functions can be overridden
  # as well if necessary:
  #
  # * `on_start` is called before the capture happens, to perform custom initializations
  # * `on_stop` is called after the capture ends, to perform custom cleanup
  #
  # A derived class can also control the frequency of the on_process_samples
  # calls, with the `processing_interval=` protected function. The default
  # interval is chosen so that recording thread doesn't consume too much
  # CPU, but it can be changed to a smaller value if you need to process
  # the recorded data in real time, for example.
  #
  # The audio capture feature may not be supported or activated
  # on every platform, thus it is recommended to check its
  # availability with the `available?()` function. If it returns
  # false, then any attempt to use an audio recorder will fail.
  #
  # If you have multiple sound input devices connected to your
  # computer (for example: microphone, external soundcard, webcam mic, ...)
  # you can get a list of all available devices through the
  # available_devices() function. You can then select a device
  # by calling `device=()` with the appropriate device. Otherwise
  # the default capturing device will be used.
  #
  # By default the recording is in 16-bit mono. Using the
  # channel_count= method you can change the number of channels
  # used by the audio capture device to record. Note that you
  # have to decide whether you want to record in mono or stereo
  # before starting the recording.
  #
  # It is important to note that the audio capture happens in a
  # separate thread, so that it doesn't block the rest of the
  # program. In particular, the on_process_samples virtual function
  # (but not on_start and not on_stop) will be called
  # from this separate thread. It is important to keep this in
  # mind, because you may have to take care of synchronization
  # issues if you share data between threads.
  # Another thing to bear in mind is that you must call `stop()`
  # in the destructor of your derived class, so that the recording
  # thread finishes before your object is destroyed.
  #
  # Usage example:
  # ```crystal
  # class CustomRecorder < SF::SoundRecorder
  #   def finalize
  #     # Make sure to stop the recording thread
  #     stop
  #   end
  #
  #   def on_start # optional
  #     # Initialize whatever has to be done before the capture starts
  #     # [...]
  #
  #     # Return true to start playing
  #     true
  #   end
  #
  #   def on_process_samples(samples)
  #     # Do something with the new chunk of samples (store them, send them, ...)
  #     # [...]
  #
  #     # Return true to continue playing
  #     true
  #   end
  #
  #   def on_stop # optional
  #     # Clean up whatever has to be done after the capture ends
  #     # [...]
  #   end
  # end
  #
  # # Usage
  # if CustomRecorder.available?
  #   recorder = CustomRecorder.new
  #
  #   if !recorder.start
  #     return -1
  #   end
  #
  #   # [...]
  #   recorder.stop
  # end
  # ```
  #
  # *See also:* `SF::SoundBufferRecorder`
  abstract class SoundRecorder
    @this : Void*
    # destructor
    def finalize()
      SFMLExt.sfml_soundrecorder_finalize(to_unsafe)
      SFMLExt.sfml_soundrecorder_free(@this)
    end
    # Start the capture
    #
    # The *sample_rate* parameter defines the number of audio samples
    # captured per second. The higher, the better the quality
    # (for example, 44100 samples/sec is CD quality).
    # This function uses its own thread so that it doesn't block
    # the rest of the program while the capture runs.
    # Please note that only one capture can happen at the same time.
    # You can select which capture device will be used, by passing
    # the name to the `device=()` method. If none was selected
    # before, the default capture device will be used. You can get a
    # list of the names of all available capture devices by calling
    # available_devices().
    #
    # * *sample_rate* - Desired capture rate, in number of samples per second
    #
    # *Returns:* True, if start of capture was successful
    #
    # *See also:* `stop`, `available_devices`
    def start(sample_rate : Int = 44100) : Bool
      SFMLExt.sfml_soundrecorder_start_emS(to_unsafe, LibC::UInt.new(sample_rate), out result)
      return result
    end
    # Stop the capture
    #
    # *See also:* `start`
    def stop()
      SFMLExt.sfml_soundrecorder_stop(to_unsafe)
    end
    # Get the sample rate
    #
    # The sample rate defines the number of audio samples
    # captured per second. The higher, the better the quality
    # (for example, 44100 samples/sec is CD quality).
    #
    # *Returns:* Sample rate, in samples per second
    def sample_rate() : Int32
      SFMLExt.sfml_soundrecorder_getsamplerate(to_unsafe, out result)
      return result.to_i
    end
    # Get a list of the names of all available audio capture devices
    #
    # This function returns a vector of strings, containing
    # the names of all available audio capture devices.
    #
    # *Returns:* A vector of strings containing the names
    def self.available_devices() : Array(String)
      SFMLExt.sfml_soundrecorder_getavailabledevices(out result, out result_size)
      return Array.new(result_size.to_i) { |i| String.new(result[i]) }
    end
    # Get the name of the default audio capture device
    #
    # This function returns the name of the default audio
    # capture device. If none is available, an empty string
    # is returned.
    #
    # *Returns:* The name of the default audio capture device
    def self.default_device() : String
      SFMLExt.sfml_soundrecorder_getdefaultdevice(out result)
      return String.new(result)
    end
    # Set the audio capture device
    #
    # This function sets the audio capture device to the device
    # with the given *name*. It can be called on the fly (i.e:
    # while recording). If you do so while recording and
    # opening the device fails, it stops the recording.
    #
    # * *name* - The name of the audio capture device
    #
    # *Returns:* True, if it was able to set the requested device
    #
    # *See also:* `available_devices`, `default_device`
    def device=(name : String) : Bool
      SFMLExt.sfml_soundrecorder_setdevice_zkC(to_unsafe, name.bytesize, name, out result)
      return result
    end
    # Get the name of the current audio capture device
    #
    # *Returns:* The name of the current audio capture device
    def device() : String
      SFMLExt.sfml_soundrecorder_getdevice(to_unsafe, out result)
      return String.new(result)
    end
    # Set the channel count of the audio capture device
    #
    # This method allows you to specify the number of channels
    # used for recording. Currently only 16-bit mono and
    # 16-bit stereo are supported.
    #
    # * *channel_count* - Number of channels. Currently only
    # mono (1) and stereo (2) are supported.
    #
    # *See also:* `channel_count`
    def channel_count=(channel_count : Int)
      SFMLExt.sfml_soundrecorder_setchannelcount_emS(to_unsafe, LibC::UInt.new(channel_count))
    end
    # Get the number of channels used by this recorder
    #
    # Currently only mono and stereo are supported, so the
    # value is either 1 (for mono) or 2 (for stereo).
    #
    # *Returns:* Number of channels
    #
    # *See also:* `channel_count=`
    def channel_count() : Int32
      SFMLExt.sfml_soundrecorder_getchannelcount(to_unsafe, out result)
      return result.to_i
    end
    # Check if the system supports audio capture
    #
    # This function should always be called before using
    # the audio capture features. If it returns false, then
    # any attempt to use `SF::SoundRecorder` or one of its derived
    # classes will fail.
    #
    # *Returns:* True if audio capture is supported, false otherwise
    def self.available?() : Bool
      SFMLExt.sfml_soundrecorder_isavailable(out result)
      return result
    end
    # Default constructor
    #
    # This constructor is only meant to be called by derived classes.
    protected def initialize()
      SFMLExt.sfml_soundrecorder_allocate(out @this)
      SFMLExt.sfml_soundrecorder_initialize(to_unsafe)
      SFMLExt.sfml_soundrecorder_parent(@this, self.as(Void*))
    end
    # Set the processing interval
    #
    # The processing interval controls the period
    # between calls to the on_process_samples function. You may
    # want to use a small interval if you want to process the
    # recorded data in real time, for example.
    #
    # Note: this is only a hint, the actual period may vary.
    # So don't rely on this parameter to implement precise timing.
    #
    # The default processing interval is 100 ms.
    #
    # * *interval* - Processing interval
    def processing_interval=(interval : Time)
      SFMLExt.sfml_soundrecorder_setprocessinginterval_f4T(to_unsafe, interval)
    end
    # Start capturing audio data
    #
    # This virtual function may be overridden by a derived class
    # if something has to be done every time a new capture
    # starts. If not, this function can be ignored; the default
    # implementation does nothing.
    #
    # *Returns:* True to start the capture, or false to abort it
    def on_start() : Bool
      SFMLExt.sfml_soundrecorder_onstart(to_unsafe, out result)
      return result
    end
    # Process a new chunk of recorded samples
    #
    # This virtual function is called every time a new chunk of
    # recorded data is available. The derived class can then do
    # whatever it wants with it (storing it, playing it, sending
    # it over the network, etc.).
    #
    # * *samples* - Pointer to the new chunk of recorded samples
    # * *sample_count* - Number of samples pointed by *samples*
    #
    # *Returns:* True to continue the capture, or false to stop it
    abstract def on_process_samples(samples : Array(Int16) | Slice(Int16)) : Bool
    # Stop capturing audio data
    #
    # This virtual function may be overridden by a derived class
    # if something has to be done every time the capture
    # ends. If not, this function can be ignored; the default
    # implementation does nothing.
    def on_stop()
      SFMLExt.sfml_soundrecorder_onstop(to_unsafe)
    end
    include AlResource
    # :nodoc:
    def to_unsafe()
      @this
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
  end
  # Specialized SoundRecorder which stores the captured
  # audio data into a sound buffer
  #
  # `SF::SoundBufferRecorder` allows to access a recorded sound
  # through a `SF::SoundBuffer`, so that it can be played, saved
  # to a file, etc.
  #
  # It has the same simple interface as its base class (`start()`, `stop()`)
  # and adds a function to retrieve the recorded sound buffer
  # (`buffer()`).
  #
  # As usual, don't forget to call the `available?()` function
  # before using this class (see `SF::SoundRecorder` for more details
  # about this).
  #
  # Usage example:
  # ```crystal
  # if SF::SoundBufferRecorder.available?
  #   # Record some audio data
  #   recorder = SF::SoundBufferRecorder.new
  #   recorder.start
  #   # [...]
  #   recorder.stop
  #
  #   # Get the buffer containing the captured audio data
  #   buffer = recorder.buffer
  #
  #   # Save it to a file (for example...)
  #   buffer.save_to_file("my_record.ogg")
  # end
  # ```
  #
  # *See also:* `SF::SoundRecorder`
  class SoundBufferRecorder < SoundRecorder
    @this : Void*
    def initialize()
      SFMLExt.sfml_soundbufferrecorder_allocate(out @this)
      SFMLExt.sfml_soundbufferrecorder_initialize(to_unsafe)
    end
    # destructor
    def finalize()
      SFMLExt.sfml_soundbufferrecorder_finalize(to_unsafe)
      SFMLExt.sfml_soundbufferrecorder_free(@this)
    end
    # Get the sound buffer containing the captured audio data
    #
    # The sound buffer is valid only after the capture has ended.
    # This function provides a read-only access to the internal
    # sound buffer, but it can be copied if you need to
    # make any modification to it.
    #
    # *Returns:* Read-only access to the sound buffer
    def buffer() : SoundBuffer
      SFMLExt.sfml_soundbufferrecorder_getbuffer(to_unsafe, out result)
      return SoundBuffer::Reference.new(result, self)
    end
    # Start capturing audio data
    #
    # *Returns:* True to start the capture, or false to abort it
    def on_start() : Bool
      false
    end
    # Process a new chunk of recorded samples
    #
    # * *samples* - Pointer to the new chunk of recorded samples
    # * *sample_count* - Number of samples pointed by *samples*
    #
    # *Returns:* True to continue the capture, or false to stop it
    def on_process_samples(samples : Array(Int16) | Slice(Int16)) : Bool
      false
    end
    # Stop capturing audio data
    def on_stop()
    end
    # :nodoc:
    def start(sample_rate : Int = 44100) : Bool
      SFMLExt.sfml_soundbufferrecorder_start_emS(to_unsafe, LibC::UInt.new(sample_rate), out result)
      return result
    end
    # :nodoc:
    def stop()
      SFMLExt.sfml_soundbufferrecorder_stop(to_unsafe)
    end
    # :nodoc:
    def sample_rate() : Int32
      SFMLExt.sfml_soundbufferrecorder_getsamplerate(to_unsafe, out result)
      return result.to_i
    end
    # :nodoc:
    def self.available_devices() : Array(String)
      SFMLExt.sfml_soundbufferrecorder_getavailabledevices(out result, out result_size)
      return Array.new(result_size.to_i) { |i| String.new(result[i]) }
    end
    # :nodoc:
    def self.default_device() : String
      SFMLExt.sfml_soundbufferrecorder_getdefaultdevice(out result)
      return String.new(result)
    end
    # :nodoc:
    def device=(name : String) : Bool
      SFMLExt.sfml_soundbufferrecorder_setdevice_zkC(to_unsafe, name.bytesize, name, out result)
      return result
    end
    # :nodoc:
    def device() : String
      SFMLExt.sfml_soundbufferrecorder_getdevice(to_unsafe, out result)
      return String.new(result)
    end
    # :nodoc:
    def channel_count=(channel_count : Int)
      SFMLExt.sfml_soundbufferrecorder_setchannelcount_emS(to_unsafe, LibC::UInt.new(channel_count))
    end
    # :nodoc:
    def channel_count() : Int32
      SFMLExt.sfml_soundbufferrecorder_getchannelcount(to_unsafe, out result)
      return result.to_i
    end
    # :nodoc:
    def self.available?() : Bool
      SFMLExt.sfml_soundbufferrecorder_isavailable(out result)
      return result
    end
    # :nodoc:
    def processing_interval=(interval : Time)
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
  end
  # :nodoc:
  class SoundBuffer::Reference < SoundBuffer
    def initialize(@this : Void*, @parent : SoundBufferRecorder)
    end
    def finalize()
    end
    def to_unsafe()
      @this
    end
  end
  SFMLExt.sfml_audio_version(out major, out minor, out patch)
  if SFML_VERSION != (ver = "#{major}.#{minor}.#{patch}")
    STDERR.puts "Warning: CrSFML was built for SFML #{SFML_VERSION}, found SFML #{ver}"
  end
end
