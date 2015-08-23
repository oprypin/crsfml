require "./audio_lib"
require "./common_obj"

module SF
  extend self

  class Listener
    # Change the global volume of all the sounds and musics
    # 
    # The volume is a number between 0 and 100; it is combined with
    # the individual volume of each sound / music.
    # The default value for the volume is 100 (maximum).
    # 
    # *Arguments*:
    # 
    # * `volume`: New global volume, in the range [0, 100]
    def self.global_volume=(volume: Number)
      volume = volume.to_f32
      CSFML.listener_set_global_volume(volume)
    end
    
    # Deprecated alias to `global_volume=`
    def self.set_global_volume(number: Volume)
      CSFML.listener_set_global_volume(number)
    end
    
    # Get the current value of the global volume
    # 
    # *Returns*: Current global volume, in the range [0, 100]
    def self.global_volume
      CSFML.listener_get_global_volume()
    end
    
    # Deprecated alias to `global_volume`
    def self.get_global_volume()
      CSFML.listener_get_global_volume()
    end
    
    # Set the position of the listener in the scene
    # 
    # The default listener's position is (0, 0, 0).
    # 
    # *Arguments*:
    # 
    # * `position`: New position of the listener
    def self.position=(position: Vector3f)
      CSFML.listener_set_position(position)
    end
    
    # Deprecated alias to `position=`
    def self.set_position(vector3f: Position)
      CSFML.listener_set_position(vector3f)
    end
    
    # Get the current position of the listener in the scene
    # 
    # *Returns*: The listener's position
    def self.position
      CSFML.listener_get_position()
    end
    
    # Deprecated alias to `position`
    def self.get_position()
      CSFML.listener_get_position()
    end
    
    # Set the orientation of the forward vector in the scene
    # 
    # The direction (also called "at vector") is the vector
    # pointing forward from the listener's perspective. Together
    # with the up vector, it defines the 3D orientation of the
    # listener in the scene. The direction vector doesn't
    # have to be normalized.
    # The default listener's direction is (0, 0, -1).
    # 
    # *Arguments*:
    # 
    # * `direction`: New listener's direction
    def self.direction=(direction: Vector3f)
      CSFML.listener_set_direction(direction)
    end
    
    # Deprecated alias to `direction=`
    def self.set_direction(vector3f: Direction)
      CSFML.listener_set_direction(vector3f)
    end
    
    # Get the current forward vector of the listener in the scene
    # 
    # *Returns*: Listener's forward vector (not normalized)
    def self.direction
      CSFML.listener_get_direction()
    end
    
    # Deprecated alias to `direction`
    def self.get_direction()
      CSFML.listener_get_direction()
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
    # *Arguments*:
    # 
    # * `up_vector`: New listener's up vector
    def self.up_vector=(up_vector: Vector3f)
      CSFML.listener_set_up_vector(up_vector)
    end
    
    # Deprecated alias to `up_vector=`
    def self.set_up_vector(vector3f: Up_vector)
      CSFML.listener_set_up_vector(vector3f)
    end
    
    # Get the current upward vector of the listener in the scene
    # 
    # *Returns*: Listener's upward vector (not normalized)
    def self.up_vector
      CSFML.listener_get_up_vector()
    end
    
    # Deprecated alias to `up_vector`
    def self.get_up_vector()
      CSFML.listener_get_up_vector()
    end
    
  end

  # Enumeration of statuses for sounds and musics
  #
  # * SoundSource::Stopped
  # * SoundSource::Paused
  # * SoundSource::Playing
  alias SoundStatus = CSFML::SoundStatus

  class SoundSource
    Stopped = CSFML::SoundStatus::Stopped
    Paused = CSFML::SoundStatus::Paused
    Playing = CSFML::SoundStatus::Playing
  end

  class Music
    include Wrapper(CSFML::Music)
    
    # Create a new music and load it from a file
    # 
    # This function doesn't start playing the music (call
    # Music_play to do so).
    # Here is a complete list of all the supported audio formats:
    # ogg, wav, flac, aiff, au, raw, paf, svx, nist, voc, ircam,
    # w64, mat4, mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k, rf64.
    # 
    # *Arguments*:
    # 
    # * `filename`: Path of the music file to open
    # 
    # *Returns*: A new Music object (raises `NullResult` if failed)
    def self.from_file(filename: String)
      Music.transfer_ptr(CSFML.music_create_from_file(filename))
    end
    
    # Create a new music and load it from a file in memory
    # 
    # This function doesn't start playing the music (call
    # Music_play to do so).
    # Here is a complete list of all the supported audio formats:
    # ogg, wav, flac, aiff, au, raw, paf, svx, nist, voc, ircam,
    # w64, mat4, mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k, rf64.
    # 
    # *Arguments*:
    # 
    # * `data`: Pointer to the file data in memory
    # * `size_in_bytes`: Size of the data to load, in bytes
    # 
    # *Returns*: A new Music object (raises `NullResult` if failed)
    def self.from_memory(data: Void*, size_in_bytes: Int)
      size_in_bytes = LibC::SizeT.cast(size_in_bytes)
      Music.transfer_ptr(CSFML.music_create_from_memory(data, size_in_bytes))
    end
    
    # Create a new music and load it from a custom stream
    # 
    # This function doesn't start playing the music (call
    # Music_play to do so).
    # Here is a complete list of all the supported audio formats:
    # ogg, wav, flac, aiff, au, raw, paf, svx, nist, voc, ircam,
    # w64, mat4, mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k, rf64.
    # 
    # *Arguments*:
    # 
    # * `stream`: Source stream to read from
    # 
    # *Returns*: A new Music object (raises `NullResult` if failed)
    def self.from_stream(stream: InputStream*)
      Music.transfer_ptr(CSFML.music_create_from_stream(stream))
    end
    
    # Destroy a music
    # 
    # *Arguments*:
    # 
    # * `music`: Music to destroy
    def finalize()
      CSFML.music_destroy(@this) if @owned
    end
    
    # Set whether or not a music should loop after reaching the end
    # 
    # If set, the music will restart from beginning after
    # reaching the end and so on, until it is stopped or
    # Music_setLoop(music, False) is called.
    # The default looping state for musics is false.
    # 
    # *Arguments*:
    # 
    # * `music`: Music object
    # * `loop`: True to play in loop, False to play once
    def loop=(loop: Bool)
      loop = loop ? 1 : 0
      CSFML.music_set_loop(@this, loop)
    end
    
    # Tell whether or not a music is in loop mode
    # 
    # *Arguments*:
    # 
    # * `music`: Music object
    # 
    # *Returns*: True if the music is looping, False otherwise
    def loop
      CSFML.music_get_loop(@this) != 0
    end
    
    # Get the total duration of a music
    # 
    # *Arguments*:
    # 
    # * `music`: Music object
    # 
    # *Returns*: Music duration
    def duration
      CSFML.music_get_duration(@this)
    end
    
    # Start or resume playing a music
    # 
    # This function starts the music if it was stopped, resumes
    # it if it was paused, and restarts it from beginning if it
    # was it already playing.
    # This function uses its own thread so that it doesn't block
    # the rest of the program while the music is played.
    # 
    # *Arguments*:
    # 
    # * `music`: Music object
    def play()
      CSFML.music_play(@this)
    end
    
    # Pause a music
    # 
    # This function pauses the music if it was playing,
    # otherwise (music already paused or stopped) it has no effect.
    # 
    # *Arguments*:
    # 
    # * `music`: Music object
    def pause()
      CSFML.music_pause(@this)
    end
    
    # Stop playing a music
    # 
    # This function stops the music if it was playing or paused,
    # and does nothing if it was already stopped.
    # It also resets the playing position (unlike Music_pause).
    # 
    # *Arguments*:
    # 
    # * `music`: Music object
    def stop()
      CSFML.music_stop(@this)
    end
    
    # Return the number of channels of a music
    # 
    # 1 channel means a mono sound, 2 means stereo, etc.
    # 
    # *Arguments*:
    # 
    # * `music`: Music object
    # 
    # *Returns*: Number of channels
    def channel_count
      CSFML.music_get_channel_count(@this)
    end
    
    # Get the sample rate of a music
    # 
    # The sample rate is the number of audio samples played per
    # second. The higher, the better the quality.
    # 
    # *Arguments*:
    # 
    # * `music`: Music object
    # 
    # *Returns*: Sample rate, in number of samples per second
    def sample_rate
      CSFML.music_get_sample_rate(@this)
    end
    
    # Get the current status of a music (stopped, paused, playing)
    # 
    # *Arguments*:
    # 
    # * `music`: Music object
    # 
    # *Returns*: Current status
    def status
      CSFML.music_get_status(@this)
    end
    
    # Get the current playing position of a music
    # 
    # *Arguments*:
    # 
    # * `music`: Music object
    # 
    # *Returns*: Current playing position
    def playing_offset
      CSFML.music_get_playing_offset(@this)
    end
    
    # Set the pitch of a music
    # 
    # The pitch represents the perceived fundamental frequency
    # of a sound; thus you can make a music more acute or grave
    # by changing its pitch. A side effect of changing the pitch
    # is to modify the playing speed of the music as well.
    # The default value for the pitch is 1.
    # 
    # *Arguments*:
    # 
    # * `music`: Music object
    # * `pitch`: New pitch to apply to the music
    def pitch=(pitch: Number)
      pitch = pitch.to_f32
      CSFML.music_set_pitch(@this, pitch)
    end
    
    # Set the volume of a music
    # 
    # The volume is a value between 0 (mute) and 100 (full volume).
    # The default value for the volume is 100.
    # 
    # *Arguments*:
    # 
    # * `music`: Music object
    # * `volume`: Volume of the music
    def volume=(volume: Number)
      volume = volume.to_f32
      CSFML.music_set_volume(@this, volume)
    end
    
    # Set the 3D position of a music in the audio scene
    # 
    # Only musics with one channel (mono musics) can be
    # spatialized.
    # The default position of a music is (0, 0, 0).
    # 
    # *Arguments*:
    # 
    # * `music`: Music object
    # * `position`: Position of the music in the scene
    def position=(position: Vector3f)
      CSFML.music_set_position(@this, position)
    end
    
    # Make a musics's position relative to the listener or absolute
    # 
    # Making a music relative to the listener will ensure that it will always
    # be played the same way regardless the position of the listener.
    # This can be useful for non-spatialized musics, musics that are
    # produced by the listener, or musics attached to it.
    # The default value is false (position is absolute).
    # 
    # *Arguments*:
    # 
    # * `music`: Music object
    # * `relative`: True to set the position relative, False to set it absolute
    def relative_to_listener=(relative: Bool)
      relative = relative ? 1 : 0
      CSFML.music_set_relative_to_listener(@this, relative)
    end
    
    # Set the minimum distance of a music
    # 
    # The "minimum distance" of a music is the maximum
    # distance at which it is heard at its maximum volume. Further
    # than the minimum distance, it will start to fade out according
    # to its attenuation factor. A value of 0 ("inside the head
    # of the listener") is an invalid value and is forbidden.
    # The default value of the minimum distance is 1.
    # 
    # *Arguments*:
    # 
    # * `music`: Music object
    # * `distance`: New minimum distance of the music
    def min_distance=(distance: Number)
      distance = distance.to_f32
      CSFML.music_set_min_distance(@this, distance)
    end
    
    # Set the attenuation factor of a music
    # 
    # The attenuation is a multiplicative factor which makes
    # the music more or less loud according to its distance
    # from the listener. An attenuation of 0 will produce a
    # non-attenuated music, i.e. its volume will always be the same
    # whether it is heard from near or from far. On the other hand,
    # an attenuation value such as 100 will make the music fade out
    # very quickly as it gets further from the listener.
    # The default value of the attenuation is 1.
    # 
    # *Arguments*:
    # 
    # * `music`: Music object
    # * `attenuation`: New attenuation factor of the music
    def attenuation=(attenuation: Number)
      attenuation = attenuation.to_f32
      CSFML.music_set_attenuation(@this, attenuation)
    end
    
    # Change the current playing position of a music
    # 
    # The playing position can be changed when the music is
    # either paused or playing.
    # 
    # *Arguments*:
    # 
    # * `music`: Music object
    # * `time_offset`: New playing position
    def playing_offset=(time_offset: Time)
      CSFML.music_set_playing_offset(@this, time_offset)
    end
    
    # Get the pitch of a music
    # 
    # *Arguments*:
    # 
    # * `music`: Music object
    # 
    # *Returns*: Pitch of the music
    def pitch
      CSFML.music_get_pitch(@this)
    end
    
    # Get the volume of a music
    # 
    # *Arguments*:
    # 
    # * `music`: Music object
    # 
    # *Returns*: Volume of the music, in the range [0, 100]
    def volume
      CSFML.music_get_volume(@this)
    end
    
    # Get the 3D position of a music in the audio scene
    # 
    # *Arguments*:
    # 
    # * `music`: Music object
    # 
    # *Returns*: Position of the music in the world
    def position
      CSFML.music_get_position(@this)
    end
    
    # Tell whether a music's position is relative to the
    # listener or is absolute
    # 
    # *Arguments*:
    # 
    # * `music`: Music object
    # 
    # *Returns*: True if the position is relative, False if it's absolute
    def relative_to_listener?
      CSFML.music_is_relative_to_listener(@this) != 0
    end
    
    # Get the minimum distance of a music
    # 
    # *Arguments*:
    # 
    # * `music`: Music object
    # 
    # *Returns*: Minimum distance of the music
    def min_distance
      CSFML.music_get_min_distance(@this)
    end
    
    # Get the attenuation factor of a music
    # 
    # *Arguments*:
    # 
    # * `music`: Music object
    # 
    # *Returns*: Attenuation factor of the music
    def attenuation
      CSFML.music_get_attenuation(@this)
    end
    
  end

  class Sound
    include Wrapper(CSFML::Sound)
    
    # Create a new sound
    # 
    # *Returns*: A new Sound object
    def initialize()
      @owned = true
      @this = CSFML.sound_create()
    end
    
    # Create a new sound by copying an existing one
    # 
    # *Arguments*:
    # 
    # * `sound`: Sound to copy
    # 
    # *Returns*: A new Sound object which is a copy of `sound`
    def dup()
      Sound.transfer_ptr(CSFML.sound_copy(@this))
    end
    
    # Destroy a sound
    # 
    # *Arguments*:
    # 
    # * `sound`: Sound to destroy
    def finalize()
      CSFML.sound_destroy(@this) if @owned
    end
    
    # Start or resume playing a sound
    # 
    # This function starts the sound if it was stopped, resumes
    # it if it was paused, and restarts it from beginning if it
    # was it already playing.
    # This function uses its own thread so that it doesn't block
    # the rest of the program while the sound is played.
    # 
    # *Arguments*:
    # 
    # * `sound`: Sound object
    def play()
      CSFML.sound_play(@this)
    end
    
    # Pause a sound
    # 
    # This function pauses the sound if it was playing,
    # otherwise (sound already paused or stopped) it has no effect.
    # 
    # *Arguments*:
    # 
    # * `sound`: Sound object
    def pause()
      CSFML.sound_pause(@this)
    end
    
    # Stop playing a sound
    # 
    # This function stops the sound if it was playing or paused,
    # and does nothing if it was already stopped.
    # It also resets the playing position (unlike Sound_pause).
    # 
    # *Arguments*:
    # 
    # * `sound`: Sound object
    def stop()
      CSFML.sound_stop(@this)
    end
    
    # Set the source buffer containing the audio data to play
    # 
    # It is important to note that the sound buffer is not copied,
    # thus the SoundBuffer object must remain alive as long
    # as it is attached to the sound.
    # 
    # *Arguments*:
    # 
    # * `sound`: Sound object
    # * `buffer`: Sound buffer to attach to the sound
    def buffer=(buffer: SoundBuffer)
      CSFML.sound_set_buffer(@this, buffer)
    end
    
    # Get the audio buffer attached to a sound
    # 
    # *Arguments*:
    # 
    # * `sound`: Sound object
    # 
    # *Returns*: Sound buffer attached to the sound (can be NULL)
    def buffer
      SoundBuffer.wrap_ptr?(CSFML.sound_get_buffer(@this))
    end
    
    # Set whether or not a sound should loop after reaching the end
    # 
    # If set, the sound will restart from beginning after
    # reaching the end and so on, until it is stopped or
    # Sound_setLoop(sound, False) is called.
    # The default looping state for sounds is false.
    # 
    # *Arguments*:
    # 
    # * `sound`: Sound object
    # * `loop`: True to play in loop, False to play once
    def loop=(loop: Bool)
      loop = loop ? 1 : 0
      CSFML.sound_set_loop(@this, loop)
    end
    
    # Tell whether or not a sound is in loop mode
    # 
    # *Arguments*:
    # 
    # * `sound`: Sound object
    # 
    # *Returns*: True if the sound is looping, False otherwise
    def loop
      CSFML.sound_get_loop(@this) != 0
    end
    
    # Get the current status of a sound (stopped, paused, playing)
    # 
    # *Arguments*:
    # 
    # * `sound`: Sound object
    # 
    # *Returns*: Current status
    def status
      CSFML.sound_get_status(@this)
    end
    
    # Set the pitch of a sound
    # 
    # The pitch represents the perceived fundamental frequency
    # of a sound; thus you can make a sound more acute or grave
    # by changing its pitch. A side effect of changing the pitch
    # is to modify the playing speed of the sound as well.
    # The default value for the pitch is 1.
    # 
    # *Arguments*:
    # 
    # * `sound`: Sound object
    # * `pitch`: New pitch to apply to the sound
    def pitch=(pitch: Number)
      pitch = pitch.to_f32
      CSFML.sound_set_pitch(@this, pitch)
    end
    
    # Set the volume of a sound
    # 
    # The volume is a value between 0 (mute) and 100 (full volume).
    # The default value for the volume is 100.
    # 
    # *Arguments*:
    # 
    # * `sound`: Sound object
    # * `volume`: Volume of the sound
    def volume=(volume: Number)
      volume = volume.to_f32
      CSFML.sound_set_volume(@this, volume)
    end
    
    # Set the 3D position of a sound in the audio scene
    # 
    # Only sounds with one channel (mono sounds) can be
    # spatialized.
    # The default position of a sound is (0, 0, 0).
    # 
    # *Arguments*:
    # 
    # * `sound`: Sound object
    # * `position`: Position of the sound in the scene
    def position=(position: Vector3f)
      CSFML.sound_set_position(@this, position)
    end
    
    # Make the sound's position relative to the listener or absolute
    # 
    # Making a sound relative to the listener will ensure that it will always
    # be played the same way regardless the position of the listener.
    # This can be useful for non-spatialized sounds, sounds that are
    # produced by the listener, or sounds attached to it.
    # The default value is false (position is absolute).
    # 
    # *Arguments*:
    # 
    # * `sound`: Sound object
    # * `relative`: True to set the position relative, False to set it absolute
    def relative_to_listener=(relative: Bool)
      relative = relative ? 1 : 0
      CSFML.sound_set_relative_to_listener(@this, relative)
    end
    
    # Set the minimum distance of a sound
    # 
    # The "minimum distance" of a sound is the maximum
    # distance at which it is heard at its maximum volume. Further
    # than the minimum distance, it will start to fade out according
    # to its attenuation factor. A value of 0 ("inside the head
    # of the listener") is an invalid value and is forbidden.
    # The default value of the minimum distance is 1.
    # 
    # *Arguments*:
    # 
    # * `sound`: Sound object
    # * `distance`: New minimum distance of the sound
    def min_distance=(distance: Number)
      distance = distance.to_f32
      CSFML.sound_set_min_distance(@this, distance)
    end
    
    # Set the attenuation factor of a sound
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
    # *Arguments*:
    # 
    # * `sound`: Sound object
    # * `attenuation`: New attenuation factor of the sound
    def attenuation=(attenuation: Number)
      attenuation = attenuation.to_f32
      CSFML.sound_set_attenuation(@this, attenuation)
    end
    
    # Change the current playing position of a sound
    # 
    # The playing position can be changed when the sound is
    # either paused or playing.
    # 
    # *Arguments*:
    # 
    # * `sound`: Sound object
    # * `time_offset`: New playing position
    def playing_offset=(time_offset: Time)
      CSFML.sound_set_playing_offset(@this, time_offset)
    end
    
    # Get the pitch of a sound
    # 
    # *Arguments*:
    # 
    # * `sound`: Sound object
    # 
    # *Returns*: Pitch of the sound
    def pitch
      CSFML.sound_get_pitch(@this)
    end
    
    # Get the volume of a sound
    # 
    # *Arguments*:
    # 
    # * `sound`: Sound object
    # 
    # *Returns*: Volume of the sound, in the range [0, 100]
    def volume
      CSFML.sound_get_volume(@this)
    end
    
    # Get the 3D position of a sound in the audio scene
    # 
    # *Arguments*:
    # 
    # * `sound`: Sound object
    # 
    # *Returns*: Position of the sound in the world
    def position
      CSFML.sound_get_position(@this)
    end
    
    # Tell whether a sound's position is relative to the
    # listener or is absolute
    # 
    # *Arguments*:
    # 
    # * `sound`: Sound object
    # 
    # *Returns*: True if the position is relative, False if it's absolute
    def relative_to_listener?
      CSFML.sound_is_relative_to_listener(@this) != 0
    end
    
    # Get the minimum distance of a sound
    # 
    # *Arguments*:
    # 
    # * `sound`: Sound object
    # 
    # *Returns*: Minimum distance of the sound
    def min_distance
      CSFML.sound_get_min_distance(@this)
    end
    
    # Get the attenuation factor of a sound
    # 
    # *Arguments*:
    # 
    # * `sound`: Sound object
    # 
    # *Returns*: Attenuation factor of the sound
    def attenuation
      CSFML.sound_get_attenuation(@this)
    end
    
    # Get the current playing position of a sound
    # 
    # *Arguments*:
    # 
    # * `sound`: Sound object
    # 
    # *Returns*: Current playing position
    def playing_offset
      CSFML.sound_get_playing_offset(@this)
    end
    
  end

  class SoundBuffer
    include Wrapper(CSFML::SoundBuffer)
    
    # Create a new sound buffer and load it from a file
    # 
    # Here is a complete list of all the supported audio formats:
    # ogg, wav, flac, aiff, au, raw, paf, svx, nist, voc, ircam,
    # w64, mat4, mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k, rf64.
    # 
    # *Arguments*:
    # 
    # * `filename`: Path of the sound file to load
    # 
    # *Returns*: A new SoundBuffer object (raises `NullResult` if failed)
    def self.from_file(filename: String)
      SoundBuffer.transfer_ptr(CSFML.sound_buffer_create_from_file(filename))
    end
    
    # Create a new sound buffer and load it from a file in memory
    # 
    # Here is a complete list of all the supported audio formats:
    # ogg, wav, flac, aiff, au, raw, paf, svx, nist, voc, ircam,
    # w64, mat4, mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k, rf64.
    # 
    # *Arguments*:
    # 
    # * `data`: Pointer to the file data in memory
    # * `size_in_bytes`: Size of the data to load, in bytes
    # 
    # *Returns*: A new SoundBuffer object (raises `NullResult` if failed)
    def self.from_memory(data: Void*, size_in_bytes: Int)
      size_in_bytes = LibC::SizeT.cast(size_in_bytes)
      SoundBuffer.transfer_ptr(CSFML.sound_buffer_create_from_memory(data, size_in_bytes))
    end
    
    # Create a new sound buffer and load it from a custom stream
    # 
    # Here is a complete list of all the supported audio formats:
    # ogg, wav, flac, aiff, au, raw, paf, svx, nist, voc, ircam,
    # w64, mat4, mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k, rf64.
    # 
    # *Arguments*:
    # 
    # * `stream`: Source stream to read from
    # 
    # *Returns*: A new SoundBuffer object (raises `NullResult` if failed)
    def self.from_stream(stream: InputStream*)
      SoundBuffer.transfer_ptr(CSFML.sound_buffer_create_from_stream(stream))
    end
    
    # Create a new sound buffer and load it from an array of samples in memory
    # 
    # The assumed format of the audio samples is 16 bits signed integer
    # (Int16).
    # 
    # *Arguments*:
    # 
    # * `samples`: Pointer to the array of samples in memory
    # * `sample_count`: Number of samples in the array
    # * `channel_count`: Number of channels (1 = mono, 2 = stereo, ...)
    # * `sample_rate`: Sample rate (number of samples to play per second)
    # 
    # *Returns*: A new SoundBuffer object (raises `NullResult` if failed)
    def self.from_samples(samples, sample_count: Int, channel_count: Int, sample_rate: Int)
      if samples.responds_to?(:to_unsafe); psamples = samples.to_unsafe
      elsif samples; csamples = samples; psamples = pointerof(csamples)
      else; psamples = nil; end
      sample_count = sample_count.to_u64
      channel_count = channel_count.to_i32
      sample_rate = sample_rate.to_i32
      SoundBuffer.transfer_ptr(CSFML.sound_buffer_create_from_samples(psamples, sample_count, channel_count, sample_rate))
    end
    
    # Create a new sound buffer by copying an existing one
    # 
    # *Arguments*:
    # 
    # * `sound_buffer`: Sound buffer to copy
    # 
    # *Returns*: A new SoundBuffer object which is a copy of `sound_buffer`
    def dup()
      SoundBuffer.transfer_ptr(CSFML.sound_buffer_copy(@this))
    end
    
    # Destroy a sound buffer
    # 
    # *Arguments*:
    # 
    # * `sound_buffer`: Sound buffer to destroy
    def finalize()
      CSFML.sound_buffer_destroy(@this) if @owned
    end
    
    # Save a sound buffer to an audio file
    # 
    # Here is a complete list of all the supported audio formats:
    # ogg, wav, flac, aiff, au, raw, paf, svx, nist, voc, ircam,
    # w64, mat4, mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k, rf64.
    # 
    # *Arguments*:
    # 
    # * `sound_buffer`: Sound buffer object
    # * `filename`: Path of the sound file to write
    # 
    # *Returns*: True if saving succeeded, False if it failed
    def save_to_file(filename: String)
      CSFML.sound_buffer_save_to_file(@this, filename) != 0
    end
    
    # Get the array of audio samples stored in a sound buffer
    # 
    # The format of the returned samples is 16 bits signed integer
    # (Int16). The total number of samples in this array
    # is given by the SoundBuffer_getSampleCount function.
    # 
    # *Arguments*:
    # 
    # * `sound_buffer`: Sound buffer object
    # 
    # *Returns*: Read-only pointer to the array of sound samples
    def samples
      CSFML.sound_buffer_get_samples(@this)
    end
    
    # Get the number of samples stored in a sound buffer
    # 
    # The array of samples can be accessed with the
    # SoundBuffer_getSamples function.
    # 
    # *Arguments*:
    # 
    # * `sound_buffer`: Sound buffer object
    # 
    # *Returns*: Number of samples
    def sample_count
      CSFML.sound_buffer_get_sample_count(@this)
    end
    
    # Get the sample rate of a sound buffer
    # 
    # The sample rate is the number of samples played per second.
    # The higher, the better the quality (for example, 44100
    # samples/s is CD quality).
    # 
    # *Arguments*:
    # 
    # * `sound_buffer`: Sound buffer object
    # 
    # *Returns*: Sample rate (number of samples per second)
    def sample_rate
      CSFML.sound_buffer_get_sample_rate(@this)
    end
    
    # Get the number of channels used by a sound buffer
    # 
    # If the sound is mono then the number of channels will
    # be 1, 2 for stereo, etc.
    # 
    # *Arguments*:
    # 
    # * `sound_buffer`: Sound buffer object
    # 
    # *Returns*: Number of channels
    def channel_count
      CSFML.sound_buffer_get_channel_count(@this)
    end
    
    # Get the total duration of a sound buffer
    # 
    # *Arguments*:
    # 
    # * `sound_buffer`: Sound buffer object
    # 
    # *Returns*: Sound duration
    def duration
      CSFML.sound_buffer_get_duration(@this)
    end
    
  end

  class SoundBufferRecorder
    include Wrapper(CSFML::SoundBufferRecorder)
    
    # Create a new sound buffer recorder
    # 
    # *Returns*: A new SoundBufferRecorder object (raises `NullResult` if failed)
    def initialize()
      @owned = true
      @this = CSFML.sound_buffer_recorder_create()
    end
    
    # Destroy a sound buffer recorder
    # 
    # *Arguments*:
    # 
    # * `sound_buffer_recorder`: Sound buffer recorder to destroy
    def finalize()
      CSFML.sound_buffer_recorder_destroy(@this) if @owned
    end
    
    # Start the capture of a sound recorder recorder
    # 
    # The `sample_rate` parameter defines the number of audio samples
    # captured per second. The higher, the better the quality
    # (for example, 44100 samples/sec is CD quality).
    # This function uses its own thread so that it doesn't block
    # the rest of the program while the capture runs.
    # Please note that only one capture can happen at the same time.
    # 
    # *Arguments*:
    # 
    # * `sound_buffer_recorder`: Sound buffer recorder object
    # * `sample_rate`: Desired capture rate, in number of samples per second
    def start(sample_rate: Int)
      sample_rate = sample_rate.to_i32
      CSFML.sound_buffer_recorder_start(@this, sample_rate)
    end
    
    # Stop the capture of a sound recorder
    # 
    # *Arguments*:
    # 
    # * `sound_buffer_recorder`: Sound buffer recorder object
    def stop()
      CSFML.sound_buffer_recorder_stop(@this)
    end
    
    # Get the sample rate of a sound buffer recorder
    # 
    # The sample rate defines the number of audio samples
    # captured per second. The higher, the better the quality
    # (for example, 44100 samples/sec is CD quality).
    # 
    # *Arguments*:
    # 
    # * `sound_buffer_recorder`: Sound buffer recorder object
    # 
    # *Returns*: Sample rate, in samples per second
    def sample_rate
      CSFML.sound_buffer_recorder_get_sample_rate(@this)
    end
    
    # Get the sound buffer containing the captured audio data
    # 
    # The sound buffer is valid only after the capture has ended.
    # This function provides a read-only access to the internal
    # sound buffer, but it can be copied if you need to
    # make any modification to it.
    # 
    # *Arguments*:
    # 
    # * `sound_buffer_recorder`: Sound buffer recorder object
    # 
    # *Returns*: Read-only access to the sound buffer
    def buffer
      SoundBuffer.wrap_ptr(CSFML.sound_buffer_recorder_get_buffer(@this))
    end
    
  end

  class SoundRecorder
    include Wrapper(CSFML::SoundRecorder)
    
    # Construct a new sound recorder from callback functions
    # 
    # *Arguments*:
    # 
    # * `on_start`: Callback function which will be called when a new capture starts (can be NULL)
    # * `on_process`: Callback function which will be called each time there's audio data to process
    # * `on_stop`: Callback function which will be called when the current capture stops (can be NULL)
    # * `user_data`: Data to pass to the callback function (can be NULL)
    # 
    # *Returns*: A new SoundRecorder object (raises `NullResult` if failed)
    def initialize(on_start: SoundRecorderStartCallback, on_process: SoundRecorderProcessCallback, on_stop: SoundRecorderStopCallback, user_data: Void*)
      @owned = true
      @this = CSFML.sound_recorder_create(on_start, on_process, on_stop, user_data)
    end
    
    # Destroy a sound recorder
    # 
    # *Arguments*:
    # 
    # * `sound_recorder`: Sound recorder to destroy
    def finalize()
      CSFML.sound_recorder_destroy(@this) if @owned
    end
    
    # Start the capture of a sound recorder
    # 
    # The `sample_rate` parameter defines the number of audio samples
    # captured per second. The higher, the better the quality
    # (for example, 44100 samples/sec is CD quality).
    # This function uses its own thread so that it doesn't block
    # the rest of the program while the capture runs.
    # Please note that only one capture can happen at the same time.
    # 
    # *Arguments*:
    # 
    # * `sound_recorder`: Sound recorder object
    # * `sample_rate`: Desired capture rate, in number of samples per second
    # 
    # *Returns*: True, if start of capture was successful
    def start(sample_rate: Int)
      sample_rate = sample_rate.to_i32
      CSFML.sound_recorder_start(@this, sample_rate) != 0
    end
    
    # Stop the capture of a sound recorder
    # 
    # *Arguments*:
    # 
    # * `sound_recorder`: Sound recorder object
    def stop()
      CSFML.sound_recorder_stop(@this)
    end
    
    # Get the sample rate of a sound recorder
    # 
    # The sample rate defines the number of audio samples
    # captured per second. The higher, the better the quality
    # (for example, 44100 samples/sec is CD quality).
    # 
    # *Arguments*:
    # 
    # * `sound_recorder`: Sound recorder object
    # 
    # *Returns*: Sample rate, in samples per second
    def sample_rate
      CSFML.sound_recorder_get_sample_rate(@this)
    end
    
    # Check if the system supports audio capture
    # 
    # This function should always be called before using
    # the audio capture features. If it returns false, then
    # any attempt to use SoundRecorder will fail.
    # 
    # *Returns*: True if audio capture is supported, False otherwise
    def self.available?
      CSFML.sound_recorder_is_available() != 0
    end
    
    # Deprecated alias to `available?`
    def self.is_available()
      CSFML.sound_recorder_is_available() != 0
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
    # *Arguments*:
    # 
    # * `sound_recorder`: Sound recorder object
    # * `interval`: Processing interval
    def processing_interval=(interval: Time)
      CSFML.sound_recorder_set_processing_interval(@this, interval)
    end
    
    # Get a list of the names of all availabe audio capture devices
    # 
    # This function returns an array of strings (null terminated),
    # containing the names of all availabe audio capture devices.
    # If no devices are available then NULL is returned.
    # 
    # *Arguments*:
    # 
    # * `count`: Pointer to a variable that will be filled with the number of modes in the array
    # 
    # *Returns*: An array of strings containing the names
    def self.get_available_devices(count: LibC::SizeT*)
      CSFML.sound_recorder_get_available_devices(count)
    end
    
    # Get the name of the default audio capture device
    # 
    # This function returns the name of the default audio
    # capture device. If none is available, NULL is returned.
    # 
    # *Returns*: The name of the default audio capture device (null terminated)
    def self.default_device
      ptr = CSFML.sound_recorder_get_default_device()
      ptr ? String.new(ptr) : ""
    end
    
    # Deprecated alias to `default_device`
    def self.get_default_device()
      ptr = CSFML.sound_recorder_get_default_device()
      ptr ? String.new(ptr) : ""
    end
    
    # Set the audio capture device
    # 
    # This function sets the audio capture device to the device
    # with the given name. It can be called on the fly (i.e:
    # while recording). If you do so while recording and
    # opening the device fails, it stops the recording.
    # 
    # *Arguments*:
    # 
    # * `sound_recorder`: Sound recorder object
    # * `The`: name of the audio capture device
    # 
    # *Returns*: True, if it was able to set the requested device
    def device=(name: String)
      CSFML.sound_recorder_set_device(@this, name) != 0
    end
    
    # Get the name of the current audio capture device
    # 
    # *Arguments*:
    # 
    # * `sound_recorder`: Sound recorder object
    # 
    # *Returns*: The name of the current audio capture device
    def device
      ptr = CSFML.sound_recorder_get_device(@this)
      ptr ? String.new(ptr) : ""
    end
    
  end

  class SoundStream
    include Wrapper(CSFML::SoundStream)
    
    # Create a new sound stream
    # 
    # *Arguments*:
    # 
    # * `on_get_data`: Function called when the stream needs more data (can't be NULL)
    # * `on_seek`: Function called when the stream seeks (can't be NULL)
    # * `channel_count`: Number of channels to use (1 = mono, 2 = stereo)
    # * `sample_rate`: Sample rate of the sound (44100 = CD quality)
    # * `user_data`: Data to pass to the callback functions
    # 
    # *Returns*: A new SoundStream object
    def initialize(on_get_data: SoundStreamGetDataCallback, on_seek: SoundStreamSeekCallback, channel_count: Int, sample_rate: Int, user_data: Void*)
      channel_count = channel_count.to_i32
      sample_rate = sample_rate.to_i32
      @owned = true
      @this = CSFML.sound_stream_create(on_get_data, on_seek, channel_count, sample_rate, user_data)
    end
    
    # Destroy a sound stream
    # 
    # *Arguments*:
    # 
    # * `sound_stream`: Sound stream to destroy
    def finalize()
      CSFML.sound_stream_destroy(@this) if @owned
    end
    
    # Start or resume playing a sound stream
    # 
    # This function starts the stream if it was stopped, resumes
    # it if it was paused, and restarts it from beginning if it
    # was it already playing.
    # This function uses its own thread so that it doesn't block
    # the rest of the program while the music is played.
    # 
    # *Arguments*:
    # 
    # * `sound_stream`: Sound stream object
    def play()
      CSFML.sound_stream_play(@this)
    end
    
    # Pause a sound stream
    # 
    # This function pauses the stream if it was playing,
    # otherwise (stream already paused or stopped) it has no effect.
    # 
    # *Arguments*:
    # 
    # * `sound_stream`: Sound stream object
    def pause()
      CSFML.sound_stream_pause(@this)
    end
    
    # Stop playing a sound stream
    # 
    # This function stops the stream if it was playing or paused,
    # and does nothing if it was already stopped.
    # It also resets the playing position (unlike SoundStream_pause).
    # 
    # *Arguments*:
    # 
    # * `sound_stream`: Sound stream object
    def stop()
      CSFML.sound_stream_stop(@this)
    end
    
    # Get the current status of a sound stream (stopped, paused, playing)
    # 
    # *Arguments*:
    # 
    # * `sound_stream`: Sound stream object
    # 
    # *Returns*: Current status
    def status
      CSFML.sound_stream_get_status(@this)
    end
    
    # Return the number of channels of a sound stream
    # 
    # 1 channel means a mono sound, 2 means stereo, etc.
    # 
    # *Arguments*:
    # 
    # * `sound_stream`: Sound stream object
    # 
    # *Returns*: Number of channels
    def channel_count
      CSFML.sound_stream_get_channel_count(@this)
    end
    
    # Get the sample rate of a sound stream
    # 
    # The sample rate is the number of audio samples played per
    # second. The higher, the better the quality.
    # 
    # *Arguments*:
    # 
    # * `sound_stream`: Sound stream object
    # 
    # *Returns*: Sample rate, in number of samples per second
    def sample_rate
      CSFML.sound_stream_get_sample_rate(@this)
    end
    
    # Set the pitch of a sound stream
    # 
    # The pitch represents the perceived fundamental frequency
    # of a sound; thus you can make a stream more acute or grave
    # by changing its pitch. A side effect of changing the pitch
    # is to modify the playing speed of the stream as well.
    # The default value for the pitch is 1.
    # 
    # *Arguments*:
    # 
    # * `sound_stream`: Sound stream object
    # * `pitch`: New pitch to apply to the stream
    def pitch=(pitch: Number)
      pitch = pitch.to_f32
      CSFML.sound_stream_set_pitch(@this, pitch)
    end
    
    # Set the volume of a sound stream
    # 
    # The volume is a value between 0 (mute) and 100 (full volume).
    # The default value for the volume is 100.
    # 
    # *Arguments*:
    # 
    # * `sound_stream`: Sound stream object
    # * `volume`: Volume of the stream
    def volume=(volume: Number)
      volume = volume.to_f32
      CSFML.sound_stream_set_volume(@this, volume)
    end
    
    # Set the 3D position of a sound stream in the audio scene
    # 
    # Only streams with one channel (mono streams) can be
    # spatialized.
    # The default position of a stream is (0, 0, 0).
    # 
    # *Arguments*:
    # 
    # * `sound_stream`: Sound stream object
    # * `position`: Position of the stream in the scene
    def position=(position: Vector3f)
      CSFML.sound_stream_set_position(@this, position)
    end
    
    # Make a sound stream's position relative to the listener or absolute
    # 
    # Making a stream relative to the listener will ensure that it will always
    # be played the same way regardless the position of the listener.
    # This can be useful for non-spatialized streams, streams that are
    # produced by the listener, or streams attached to it.
    # The default value is false (position is absolute).
    # 
    # *Arguments*:
    # 
    # * `sound_stream`: Sound stream object
    # * `relative`: True to set the position relative, False to set it absolute
    def relative_to_listener=(relative: Bool)
      relative = relative ? 1 : 0
      CSFML.sound_stream_set_relative_to_listener(@this, relative)
    end
    
    # Set the minimum distance of a sound stream
    # 
    # The "minimum distance" of a stream is the maximum
    # distance at which it is heard at its maximum volume. Further
    # than the minimum distance, it will start to fade out according
    # to its attenuation factor. A value of 0 ("inside the head
    # of the listener") is an invalid value and is forbidden.
    # The default value of the minimum distance is 1.
    # 
    # *Arguments*:
    # 
    # * `sound_stream`: Sound stream object
    # * `distance`: New minimum distance of the stream
    def min_distance=(distance: Number)
      distance = distance.to_f32
      CSFML.sound_stream_set_min_distance(@this, distance)
    end
    
    # Set the attenuation factor of a sound stream
    # 
    # The attenuation is a multiplicative factor which makes
    # the stream more or less loud according to its distance
    # from the listener. An attenuation of 0 will produce a
    # non-attenuated stream, i.e. its volume will always be the same
    # whether it is heard from near or from far. On the other hand,
    # an attenuation value such as 100 will make the stream fade out
    # very quickly as it gets further from the listener.
    # The default value of the attenuation is 1.
    # 
    # *Arguments*:
    # 
    # * `sound_stream`: Sound stream object
    # * `attenuation`: New attenuation factor of the stream
    def attenuation=(attenuation: Number)
      attenuation = attenuation.to_f32
      CSFML.sound_stream_set_attenuation(@this, attenuation)
    end
    
    # Change the current playing position of a sound stream
    # 
    # The playing position can be changed when the stream is
    # either paused or playing.
    # 
    # *Arguments*:
    # 
    # * `sound_stream`: Sound stream object
    # * `time_offset`: New playing position
    def playing_offset=(time_offset: Time)
      CSFML.sound_stream_set_playing_offset(@this, time_offset)
    end
    
    # Set whether or not a sound stream should loop after reaching the end
    # 
    # If set, the stream will restart from beginning after
    # reaching the end and so on, until it is stopped or
    # SoundStream_setLoop(stream, False) is called.
    # The default looping state for sound streams is false.
    # 
    # *Arguments*:
    # 
    # * `sound_stream`: Sound stream object
    # * `loop`: True to play in loop, False to play once
    def loop=(loop: Bool)
      loop = loop ? 1 : 0
      CSFML.sound_stream_set_loop(@this, loop)
    end
    
    # Get the pitch of a sound stream
    # 
    # *Arguments*:
    # 
    # * `sound_stream`: Sound stream object
    # 
    # *Returns*: Pitch of the stream
    def pitch
      CSFML.sound_stream_get_pitch(@this)
    end
    
    # Get the volume of a sound stream
    # 
    # *Arguments*:
    # 
    # * `sound_stream`: Sound stream object
    # 
    # *Returns*: Volume of the stream, in the range [0, 100]
    def volume
      CSFML.sound_stream_get_volume(@this)
    end
    
    # Get the 3D position of a sound stream in the audio scene
    # 
    # *Arguments*:
    # 
    # * `sound_stream`: Sound stream object
    # 
    # *Returns*: Position of the stream in the world
    def position
      CSFML.sound_stream_get_position(@this)
    end
    
    # Tell whether a sound stream's position is relative to the
    # listener or is absolute
    # 
    # *Arguments*:
    # 
    # * `sound_stream`: Sound stream object
    # 
    # *Returns*: True if the position is relative, False if it's absolute
    def relative_to_listener?
      CSFML.sound_stream_is_relative_to_listener(@this) != 0
    end
    
    # Get the minimum distance of a sound stream
    # 
    # *Arguments*:
    # 
    # * `sound_stream`: Sound stream object
    # 
    # *Returns*: Minimum distance of the stream
    def min_distance
      CSFML.sound_stream_get_min_distance(@this)
    end
    
    # Get the attenuation factor of a sound stream
    # 
    # *Arguments*:
    # 
    # * `sound_stream`: Sound stream object
    # 
    # *Returns*: Attenuation factor of the stream
    def attenuation
      CSFML.sound_stream_get_attenuation(@this)
    end
    
    # Tell whether or not a sound stream is in loop mode
    # 
    # *Arguments*:
    # 
    # * `sound_stream`: Sound stream object
    # 
    # *Returns*: True if the music is looping, False otherwise
    def loop
      CSFML.sound_stream_get_loop(@this) != 0
    end
    
    # Get the current playing position of a sound stream
    # 
    # *Arguments*:
    # 
    # * `sound_stream`: Sound stream object
    # 
    # *Returns*: Current playing position
    def playing_offset
      CSFML.sound_stream_get_playing_offset(@this)
    end
    
  end

  # defines the data to fill by the OnGetData callback
  alias SoundStreamChunk = CSFML::SoundStreamChunk


end
