# Copyright (C) 2015 Oleh Prypin <blaxpirit@gmail.com>
# 
# This file is part of CrSFML.
# 
# This software is provided 'as-is', without any express or implied
# warranty. In no event will the authors be held liable for any damages
# arising from the use of this software.
# 
# Permission is granted to anyone to use this software for any purpose,
# including commercial applications, and to alter it and redistribute it
# freely, subject to the following restrictions:
# 
# 1. The origin of this software must not be misrepresented; you must not
#    claim that you wrote the original software. If you use this software
#    in a product, an acknowledgement in the product documentation would be
#    appreciated but is not required.
# 2. Altered source versions must be plainly marked as such, and must not be
#    misrepresented as being the original software.
# 3. This notice may not be removed or altered from any source distribution.


require "./csfml_system_lib"

@[Link("csfml-audio")]

lib CSFML
  fun listener_set_global_volume = sfListener_setGlobalVolume(volume: Float32): Void
    # Change the global volume of all the sounds and musics
    # 
    # The volume is a number between 0 and 100; it is combined with
    # the individual volume of each sound / music.
    # The default value for the volume is 100 (maximum).
    # 
    # Arguments:
    # - volume:  New global volume, in the range [0, 100]
  
  fun listener_get_global_volume = sfListener_getGlobalVolume(): Float32
    # Get the current value of the global volume
    # 
    # Returns: Current global volume, in the range [0, 100]
  
  fun listener_set_position = sfListener_setPosition(position: Vector3f): Void
    # Set the position of the listener in the scene
    # 
    # The default listener's position is (0, 0, 0).
    # 
    # Arguments:
    # - position:  New position of the listener
  
  fun listener_get_position = sfListener_getPosition(): Vector3f
    # Get the current position of the listener in the scene
    # 
    # Returns: The listener's position
  
  fun listener_set_direction = sfListener_setDirection(direction: Vector3f): Void
    # Set the orientation of the forward vector in the scene
    # 
    # The direction (also called "at vector") is the vector
    # pointing forward from the listener's perspective. Together
    # with the up vector, it defines the 3D orientation of the
    # listener in the scene. The direction vector doesn't
    # have to be normalized.
    # The default listener's direction is (0, 0, -1).
    # 
    # Arguments:
    # - direction:  New listener's direction
  
  fun listener_get_direction = sfListener_getDirection(): Vector3f
    # Get the current forward vector of the listener in the scene
    # 
    # Returns: Listener's forward vector (not normalized)
  
  fun listener_set_up_vector = sfListener_setUpVector(up_vector: Vector3f): Void
    # Set the upward vector of the listener in the scene
    # 
    # The up vector is the vector that points upward from the
    # listener's perspective. Together with the direction, it
    # defines the 3D orientation of the listener in the scene.
    # The up vector doesn't have to be normalized.
    # The default listener's up vector is (0, 1, 0). It is usually
    # not necessary to change it, especially in 2D scenarios.
    # 
    # Arguments:
    # - up_vector:  New listener's up vector
  
  fun listener_get_up_vector = sfListener_getUpVector(): Vector3f
    # Get the current upward vector of the listener in the scene
    # 
    # Returns: Listener's upward vector (not normalized)
  
  enum SoundStatus
    # Enumeration of statuses for sounds and musics
    Stopped, Paused, Playing
  end
  
  type Music = Void*
  
  type Sound = Void*
  
  type SoundBuffer = Void*
  
  type SoundBufferRecorder = Void*
  
  type SoundRecorder = Void*
  
  type SoundStream = Void*
  
  fun music_create_from_file = sfMusic_createFromFile(filename: UInt8*): Music
    # Create a new music and load it from a file
    # 
    # This function doesn't start playing the music (call
    # Music_play to do so).
    # Here is a complete list of all the supported audio formats:
    # ogg, wav, flac, aiff, au, raw, paf, svx, nist, voc, ircam,
    # w64, mat4, mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k, rf64.
    # 
    # Arguments:
    # - filename:  Path of the music file to open
    # 
    # Returns: A new Music object (NULL if failed)
  
  fun music_create_from_memory = sfMusic_createFromMemory(data: Void*, size_in_bytes: Size_t): Music
    # Create a new music and load it from a file in memory
    # 
    # This function doesn't start playing the music (call
    # Music_play to do so).
    # Here is a complete list of all the supported audio formats:
    # ogg, wav, flac, aiff, au, raw, paf, svx, nist, voc, ircam,
    # w64, mat4, mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k, rf64.
    # 
    # Arguments:
    # - data:         Pointer to the file data in memory
    # - size_in_bytes:  Size of the data to load, in bytes
    # 
    # Returns: A new Music object (NULL if failed)
  
  fun music_create_from_stream = sfMusic_createFromStream(stream: InputStream*): Music
    # Create a new music and load it from a custom stream
    # 
    # This function doesn't start playing the music (call
    # Music_play to do so).
    # Here is a complete list of all the supported audio formats:
    # ogg, wav, flac, aiff, au, raw, paf, svx, nist, voc, ircam,
    # w64, mat4, mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k, rf64.
    # 
    # Arguments:
    # - stream:  Source stream to read from
    # 
    # Returns: A new Music object (NULL if failed)
  
  fun music_destroy = sfMusic_destroy(music: Music): Void
    # Destroy a music
    # 
    # Arguments:
    # - music:  Music to destroy
  
  fun music_set_loop = sfMusic_setLoop(music: Music, loop: Int32): Void
    # Set whether or not a music should loop after reaching the end
    # 
    # If set, the music will restart from beginning after
    # reaching the end and so on, until it is stopped or
    # Music_setLoop(music, False) is called.
    # The default looping state for musics is false.
    # 
    # Arguments:
    # - music:  Music object
    # - loop:   True to play in loop, False to play once
  
  fun music_get_loop = sfMusic_getLoop(music: Music): Int32
    # Tell whether or not a music is in loop mode
    # 
    # Arguments:
    # - music:  Music object
    # 
    # Returns: True if the music is looping, False otherwise
  
  fun music_get_duration = sfMusic_getDuration(music: Music): Time
    # Get the total duration of a music
    # 
    # Arguments:
    # - music:  Music object
    # 
    # Returns: Music duration
  
  fun music_play = sfMusic_play(music: Music): Void
    # Start or resume playing a music
    # 
    # This function starts the music if it was stopped, resumes
    # it if it was paused, and restarts it from beginning if it
    # was it already playing.
    # This function uses its own thread so that it doesn't block
    # the rest of the program while the music is played.
    # 
    # Arguments:
    # - music:  Music object
  
  fun music_pause = sfMusic_pause(music: Music): Void
    # Pause a music
    # 
    # This function pauses the music if it was playing,
    # otherwise (music already paused or stopped) it has no effect.
    # 
    # Arguments:
    # - music:  Music object
  
  fun music_stop = sfMusic_stop(music: Music): Void
    # Stop playing a music
    # 
    # This function stops the music if it was playing or paused,
    # and does nothing if it was already stopped.
    # It also resets the playing position (unlike Music_pause).
    # 
    # Arguments:
    # - music:  Music object
  
  fun music_get_channel_count = sfMusic_getChannelCount(music: Music): Int32
    # Return the number of channels of a music
    # 
    # 1 channel means a mono sound, 2 means stereo, etc.
    # 
    # Arguments:
    # - music:  Music object
    # 
    # Returns: Number of channels
  
  fun music_get_sample_rate = sfMusic_getSampleRate(music: Music): Int32
    # Get the sample rate of a music
    # 
    # The sample rate is the number of audio samples played per
    # second. The higher, the better the quality.
    # 
    # Arguments:
    # - music:  Music object
    # 
    # Returns: Sample rate, in number of samples per second
  
  fun music_get_status = sfMusic_getStatus(music: Music): SoundStatus
    # Get the current status of a music (stopped, paused, playing)
    # 
    # Arguments:
    # - music:  Music object
    # 
    # Returns: Current status
  
  fun music_get_playing_offset = sfMusic_getPlayingOffset(music: Music): Time
    # Get the current playing position of a music
    # 
    # Arguments:
    # - music:  Music object
    # 
    # Returns: Current playing position
  
  fun music_set_pitch = sfMusic_setPitch(music: Music, pitch: Float32): Void
    # Set the pitch of a music
    # 
    # The pitch represents the perceived fundamental frequency
    # of a sound; thus you can make a music more acute or grave
    # by changing its pitch. A side effect of changing the pitch
    # is to modify the playing speed of the music as well.
    # The default value for the pitch is 1.
    # 
    # Arguments:
    # - music:  Music object
    # - pitch:  New pitch to apply to the music
  
  fun music_set_volume = sfMusic_setVolume(music: Music, volume: Float32): Void
    # Set the volume of a music
    # 
    # The volume is a value between 0 (mute) and 100 (full volume).
    # The default value for the volume is 100.
    # 
    # Arguments:
    # - music:   Music object
    # - volume:  Volume of the music
  
  fun music_set_position = sfMusic_setPosition(music: Music, position: Vector3f): Void
    # Set the 3D position of a music in the audio scene
    # 
    # Only musics with one channel (mono musics) can be
    # spatialized.
    # The default position of a music is (0, 0, 0).
    # 
    # Arguments:
    # - music:     Music object
    # - position:  Position of the music in the scene
  
  fun music_set_relative_to_listener = sfMusic_setRelativeToListener(music: Music, relative: Int32): Void
    # Make a musics's position relative to the listener or absolute
    # 
    # Making a music relative to the listener will ensure that it will always
    # be played the same way regardless the position of the listener.
    # This can be useful for non-spatialized musics, musics that are
    # produced by the listener, or musics attached to it.
    # The default value is false (position is absolute).
    # 
    # Arguments:
    # - music:     Music object
    # - relative:  True to set the position relative, False to set it absolute
  
  fun music_set_min_distance = sfMusic_setMinDistance(music: Music, distance: Float32): Void
    # Set the minimum distance of a music
    # 
    # The "minimum distance" of a music is the maximum
    # distance at which it is heard at its maximum volume. Further
    # than the minimum distance, it will start to fade out according
    # to its attenuation factor. A value of 0 ("inside the head
    # of the listener") is an invalid value and is forbidden.
    # The default value of the minimum distance is 1.
    # 
    # Arguments:
    # - music:     Music object
    # - distance:  New minimum distance of the music
  
  fun music_set_attenuation = sfMusic_setAttenuation(music: Music, attenuation: Float32): Void
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
    # Arguments:
    # - music:        Music object
    # - attenuation:  New attenuation factor of the music
  
  fun music_set_playing_offset = sfMusic_setPlayingOffset(music: Music, time_offset: Time): Void
    # Change the current playing position of a music
    # 
    # The playing position can be changed when the music is
    # either paused or playing.
    # 
    # Arguments:
    # - music:       Music object
    # - time_offset:  New playing position
  
  fun music_get_pitch = sfMusic_getPitch(music: Music): Float32
    # Get the pitch of a music
    # 
    # Arguments:
    # - music:  Music object
    # 
    # Returns: Pitch of the music
  
  fun music_get_volume = sfMusic_getVolume(music: Music): Float32
    # Get the volume of a music
    # 
    # Arguments:
    # - music:  Music object
    # 
    # Returns: Volume of the music, in the range [0, 100]
  
  fun music_get_position = sfMusic_getPosition(music: Music): Vector3f
    # Get the 3D position of a music in the audio scene
    # 
    # Arguments:
    # - music:  Music object
    # 
    # Returns: Position of the music in the world
  
  fun music_is_relative_to_listener = sfMusic_isRelativeToListener(music: Music): Int32
    # Tell whether a music's position is relative to the
    # listener or is absolute
    # 
    # Arguments:
    # - music:  Music object
    # 
    # Returns: True if the position is relative, False if it's absolute
  
  fun music_get_min_distance = sfMusic_getMinDistance(music: Music): Float32
    # Get the minimum distance of a music
    # 
    # Arguments:
    # - music:  Music object
    # 
    # Returns: Minimum distance of the music
  
  fun music_get_attenuation = sfMusic_getAttenuation(music: Music): Float32
    # Get the attenuation factor of a music
    # 
    # Arguments:
    # - music:  Music object
    # 
    # Returns: Attenuation factor of the music
  
  fun sound_create = sfSound_create(): Sound
    # Create a new sound
    # 
    # Returns: A new Sound object
  
  fun sound_copy = sfSound_copy(sound: Sound): Sound
    # Create a new sound by copying an existing one
    # 
    # Arguments:
    # - sound:  Sound to copy
    # 
    # Returns: A new Sound object which is a copy of `sound`
  
  fun sound_destroy = sfSound_destroy(sound: Sound): Void
    # Destroy a sound
    # 
    # Arguments:
    # - sound:  Sound to destroy
  
  fun sound_play = sfSound_play(sound: Sound): Void
    # Start or resume playing a sound
    # 
    # This function starts the sound if it was stopped, resumes
    # it if it was paused, and restarts it from beginning if it
    # was it already playing.
    # This function uses its own thread so that it doesn't block
    # the rest of the program while the sound is played.
    # 
    # Arguments:
    # - sound:  Sound object
  
  fun sound_pause = sfSound_pause(sound: Sound): Void
    # Pause a sound
    # 
    # This function pauses the sound if it was playing,
    # otherwise (sound already paused or stopped) it has no effect.
    # 
    # Arguments:
    # - sound:  Sound object
  
  fun sound_stop = sfSound_stop(sound: Sound): Void
    # Stop playing a sound
    # 
    # This function stops the sound if it was playing or paused,
    # and does nothing if it was already stopped.
    # It also resets the playing position (unlike Sound_pause).
    # 
    # Arguments:
    # - sound:  Sound object
  
  fun sound_set_buffer = sfSound_setBuffer(sound: Sound, buffer: SoundBuffer): Void
    # Set the source buffer containing the audio data to play
    # 
    # It is important to note that the sound buffer is not copied,
    # thus the SoundBuffer object must remain alive as long
    # as it is attached to the sound.
    # 
    # Arguments:
    # - sound:   Sound object
    # - buffer:  Sound buffer to attach to the sound
  
  fun sound_get_buffer = sfSound_getBuffer(sound: Sound): SoundBuffer
    # Get the audio buffer attached to a sound
    # 
    # Arguments:
    # - sound:  Sound object
    # 
    # Returns: Sound buffer attached to the sound (can be NULL)
  
  fun sound_set_loop = sfSound_setLoop(sound: Sound, loop: Int32): Void
    # Set whether or not a sound should loop after reaching the end
    # 
    # If set, the sound will restart from beginning after
    # reaching the end and so on, until it is stopped or
    # Sound_setLoop(sound, False) is called.
    # The default looping state for sounds is false.
    # 
    # Arguments:
    # - sound:  Sound object
    # - loop:   True to play in loop, False to play once
  
  fun sound_get_loop = sfSound_getLoop(sound: Sound): Int32
    # Tell whether or not a sound is in loop mode
    # 
    # Arguments:
    # - sound:  Sound object
    # 
    # Returns: True if the sound is looping, False otherwise
  
  fun sound_get_status = sfSound_getStatus(sound: Sound): SoundStatus
    # Get the current status of a sound (stopped, paused, playing)
    # 
    # Arguments:
    # - sound:  Sound object
    # 
    # Returns: Current status
  
  fun sound_set_pitch = sfSound_setPitch(sound: Sound, pitch: Float32): Void
    # Set the pitch of a sound
    # 
    # The pitch represents the perceived fundamental frequency
    # of a sound; thus you can make a sound more acute or grave
    # by changing its pitch. A side effect of changing the pitch
    # is to modify the playing speed of the sound as well.
    # The default value for the pitch is 1.
    # 
    # Arguments:
    # - sound:  Sound object
    # - pitch:  New pitch to apply to the sound
  
  fun sound_set_volume = sfSound_setVolume(sound: Sound, volume: Float32): Void
    # Set the volume of a sound
    # 
    # The volume is a value between 0 (mute) and 100 (full volume).
    # The default value for the volume is 100.
    # 
    # Arguments:
    # - sound:   Sound object
    # - volume:  Volume of the sound
  
  fun sound_set_position = sfSound_setPosition(sound: Sound, position: Vector3f): Void
    # Set the 3D position of a sound in the audio scene
    # 
    # Only sounds with one channel (mono sounds) can be
    # spatialized.
    # The default position of a sound is (0, 0, 0).
    # 
    # Arguments:
    # - sound:     Sound object
    # - position:  Position of the sound in the scene
  
  fun sound_set_relative_to_listener = sfSound_setRelativeToListener(sound: Sound, relative: Int32): Void
    # Make the sound's position relative to the listener or absolute
    # 
    # Making a sound relative to the listener will ensure that it will always
    # be played the same way regardless the position of the listener.
    # This can be useful for non-spatialized sounds, sounds that are
    # produced by the listener, or sounds attached to it.
    # The default value is false (position is absolute).
    # 
    # Arguments:
    # - sound:     Sound object
    # - relative:  True to set the position relative, False to set it absolute
  
  fun sound_set_min_distance = sfSound_setMinDistance(sound: Sound, distance: Float32): Void
    # Set the minimum distance of a sound
    # 
    # The "minimum distance" of a sound is the maximum
    # distance at which it is heard at its maximum volume. Further
    # than the minimum distance, it will start to fade out according
    # to its attenuation factor. A value of 0 ("inside the head
    # of the listener") is an invalid value and is forbidden.
    # The default value of the minimum distance is 1.
    # 
    # Arguments:
    # - sound:     Sound object
    # - distance:  New minimum distance of the sound
  
  fun sound_set_attenuation = sfSound_setAttenuation(sound: Sound, attenuation: Float32): Void
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
    # Arguments:
    # - sound:        Sound object
    # - attenuation:  New attenuation factor of the sound
  
  fun sound_set_playing_offset = sfSound_setPlayingOffset(sound: Sound, time_offset: Time): Void
    # Change the current playing position of a sound
    # 
    # The playing position can be changed when the sound is
    # either paused or playing.
    # 
    # Arguments:
    # - sound:       Sound object
    # - time_offset:  New playing position
  
  fun sound_get_pitch = sfSound_getPitch(sound: Sound): Float32
    # Get the pitch of a sound
    # 
    # Arguments:
    # - sound:  Sound object
    # 
    # Returns: Pitch of the sound
  
  fun sound_get_volume = sfSound_getVolume(sound: Sound): Float32
    # Get the volume of a sound
    # 
    # Arguments:
    # - sound:  Sound object
    # 
    # Returns: Volume of the sound, in the range [0, 100]
  
  fun sound_get_position = sfSound_getPosition(sound: Sound): Vector3f
    # Get the 3D position of a sound in the audio scene
    # 
    # Arguments:
    # - sound:  Sound object
    # 
    # Returns: Position of the sound in the world
  
  fun sound_is_relative_to_listener = sfSound_isRelativeToListener(sound: Sound): Int32
    # Tell whether a sound's position is relative to the
    # listener or is absolute
    # 
    # Arguments:
    # - sound:  Sound object
    # 
    # Returns: True if the position is relative, False if it's absolute
  
  fun sound_get_min_distance = sfSound_getMinDistance(sound: Sound): Float32
    # Get the minimum distance of a sound
    # 
    # Arguments:
    # - sound:  Sound object
    # 
    # Returns: Minimum distance of the sound
  
  fun sound_get_attenuation = sfSound_getAttenuation(sound: Sound): Float32
    # Get the attenuation factor of a sound
    # 
    # Arguments:
    # - sound:  Sound object
    # 
    # Returns: Attenuation factor of the sound
  
  fun sound_get_playing_offset = sfSound_getPlayingOffset(sound: Sound): Time
    # Get the current playing position of a sound
    # 
    # Arguments:
    # - sound:  Sound object
    # 
    # Returns: Current playing position
  
  fun sound_buffer_create_from_file = sfSoundBuffer_createFromFile(filename: UInt8*): SoundBuffer
    # Create a new sound buffer and load it from a file
    # 
    # Here is a complete list of all the supported audio formats:
    # ogg, wav, flac, aiff, au, raw, paf, svx, nist, voc, ircam,
    # w64, mat4, mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k, rf64.
    # 
    # Arguments:
    # - filename:  Path of the sound file to load
    # 
    # Returns: A new SoundBuffer object (NULL if failed)
  
  fun sound_buffer_create_from_memory = sfSoundBuffer_createFromMemory(data: Void*, size_in_bytes: Size_t): SoundBuffer
    # Create a new sound buffer and load it from a file in memory
    # 
    # Here is a complete list of all the supported audio formats:
    # ogg, wav, flac, aiff, au, raw, paf, svx, nist, voc, ircam,
    # w64, mat4, mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k, rf64.
    # 
    # Arguments:
    # - data:         Pointer to the file data in memory
    # - size_in_bytes:  Size of the data to load, in bytes
    # 
    # Returns: A new SoundBuffer object (NULL if failed)
  
  fun sound_buffer_create_from_stream = sfSoundBuffer_createFromStream(stream: InputStream*): SoundBuffer
    # Create a new sound buffer and load it from a custom stream
    # 
    # Here is a complete list of all the supported audio formats:
    # ogg, wav, flac, aiff, au, raw, paf, svx, nist, voc, ircam,
    # w64, mat4, mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k, rf64.
    # 
    # Arguments:
    # - stream:  Source stream to read from
    # 
    # Returns: A new SoundBuffer object (NULL if failed)
  
  fun sound_buffer_create_from_samples = sfSoundBuffer_createFromSamples(samples: Int16*, sample_count: Size_t, channel_count: Int32, sample_rate: Int32): SoundBuffer
    # Create a new sound buffer and load it from an array of samples in memory
    # 
    # The assumed format of the audio samples is 16 bits signed integer
    # (Int16).
    # 
    # Arguments:
    # - samples:       Pointer to the array of samples in memory
    # - sample_count:   Number of samples in the array
    # - channel_count:  Number of channels (1 = mono, 2 = stereo, ...)
    # - sample_rate:    Sample rate (number of samples to play per second)
    # 
    # Returns: A new SoundBuffer object (NULL if failed)
  
  fun sound_buffer_copy = sfSoundBuffer_copy(sound_buffer: SoundBuffer): SoundBuffer
    # Create a new sound buffer by copying an existing one
    # 
    # Arguments:
    # - sound_buffer:  Sound buffer to copy
    # 
    # Returns: A new SoundBuffer object which is a copy of `sound_buffer`
  
  fun sound_buffer_destroy = sfSoundBuffer_destroy(sound_buffer: SoundBuffer): Void
    # Destroy a sound buffer
    # 
    # Arguments:
    # - sound_buffer:  Sound buffer to destroy
  
  fun sound_buffer_save_to_file = sfSoundBuffer_saveToFile(sound_buffer: SoundBuffer, filename: UInt8*): Int32
    # Save a sound buffer to an audio file
    # 
    # Here is a complete list of all the supported audio formats:
    # ogg, wav, flac, aiff, au, raw, paf, svx, nist, voc, ircam,
    # w64, mat4, mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k, rf64.
    # 
    # Arguments:
    # - sound_buffer:  Sound buffer object
    # - filename:     Path of the sound file to write
    # 
    # Returns: True if saving succeeded, False if it failed
  
  fun sound_buffer_get_samples = sfSoundBuffer_getSamples(sound_buffer: SoundBuffer): Int16*
    # Get the array of audio samples stored in a sound buffer
    # 
    # The format of the returned samples is 16 bits signed integer
    # (Int16). The total number of samples in this array
    # is given by the SoundBuffer_getSampleCount function.
    # 
    # Arguments:
    # - sound_buffer:  Sound buffer object
    # 
    # Returns: Read-only pointer to the array of sound samples
  
  fun sound_buffer_get_sample_count = sfSoundBuffer_getSampleCount(sound_buffer: SoundBuffer): Size_t
    # Get the number of samples stored in a sound buffer
    # 
    # The array of samples can be accessed with the
    # SoundBuffer_getSamples function.
    # 
    # Arguments:
    # - sound_buffer:  Sound buffer object
    # 
    # Returns: Number of samples
  
  fun sound_buffer_get_sample_rate = sfSoundBuffer_getSampleRate(sound_buffer: SoundBuffer): Int32
    # Get the sample rate of a sound buffer
    # 
    # The sample rate is the number of samples played per second.
    # The higher, the better the quality (for example, 44100
    # samples/s is CD quality).
    # 
    # Arguments:
    # - sound_buffer:  Sound buffer object
    # 
    # Returns: Sample rate (number of samples per second)
  
  fun sound_buffer_get_channel_count = sfSoundBuffer_getChannelCount(sound_buffer: SoundBuffer): Int32
    # Get the number of channels used by a sound buffer
    # 
    # If the sound is mono then the number of channels will
    # be 1, 2 for stereo, etc.
    # 
    # Arguments:
    # - sound_buffer:  Sound buffer object
    # 
    # Returns: Number of channels
  
  fun sound_buffer_get_duration = sfSoundBuffer_getDuration(sound_buffer: SoundBuffer): Time
    # Get the total duration of a sound buffer
    # 
    # Arguments:
    # - sound_buffer:  Sound buffer object
    # 
    # Returns: Sound duration
  
  fun sound_buffer_recorder_create = sfSoundBufferRecorder_create(): SoundBufferRecorder
    # Create a new sound buffer recorder
    # 
    # Returns: A new SoundBufferRecorder object (NULL if failed)
  
  fun sound_buffer_recorder_destroy = sfSoundBufferRecorder_destroy(sound_buffer_recorder: SoundBufferRecorder): Void
    # Destroy a sound buffer recorder
    # 
    # Arguments:
    # - sound_buffer_recorder:  Sound buffer recorder to destroy
  
  fun sound_buffer_recorder_start = sfSoundBufferRecorder_start(sound_buffer_recorder: SoundBufferRecorder, sample_rate: Int32): Void
    # Start the capture of a sound recorder recorder
    # 
    # The `sample_rate` parameter defines the number of audio samples
    # captured per second. The higher, the better the quality
    # (for example, 44100 samples/sec is CD quality).
    # This function uses its own thread so that it doesn't block
    # the rest of the program while the capture runs.
    # Please note that only one capture can happen at the same time.
    # 
    # Arguments:
    # - sound_buffer_recorder:  Sound buffer recorder object
    # - sample_rate:           Desired capture rate, in number of samples per second
  
  fun sound_buffer_recorder_stop = sfSoundBufferRecorder_stop(sound_buffer_recorder: SoundBufferRecorder): Void
    # Stop the capture of a sound recorder
    # 
    # Arguments:
    # - sound_buffer_recorder:  Sound buffer recorder object
  
  fun sound_buffer_recorder_get_sample_rate = sfSoundBufferRecorder_getSampleRate(sound_buffer_recorder: SoundBufferRecorder): Int32
    # Get the sample rate of a sound buffer recorder
    # 
    # The sample rate defines the number of audio samples
    # captured per second. The higher, the better the quality
    # (for example, 44100 samples/sec is CD quality).
    # 
    # Arguments:
    # - sound_buffer_recorder:  Sound buffer recorder object
    # 
    # Returns: Sample rate, in samples per second
  
  fun sound_buffer_recorder_get_buffer = sfSoundBufferRecorder_getBuffer(sound_buffer_recorder: SoundBufferRecorder): SoundBuffer
    # Get the sound buffer containing the captured audio data
    # 
    # The sound buffer is valid only after the capture has ended.
    # This function provides a read-only access to the internal
    # sound buffer, but it can be copied if you need to
    # make any modification to it.
    # 
    # Arguments:
    # - sound_buffer_recorder:  Sound buffer recorder object
    # 
    # Returns: Read-only access to the sound buffer
  
  alias SoundRecorderStartCallback = (Void*) -> Int32
  alias SoundRecorderProcessCallback = (Int16*, Size_t, Void*) -> Int32
  alias SoundRecorderStopCallback = (Void*) -> Void
  fun sound_recorder_create = sfSoundRecorder_create(on_start: SoundRecorderStartCallback, on_process: SoundRecorderProcessCallback, on_stop: SoundRecorderStopCallback, user_data: Void*): SoundRecorder
    # Construct a new sound recorder from callback functions
    # 
    # Arguments:
    # - on_start:    Callback function which will be called when a new capture starts (can be NULL)
    # - on_process:  Callback function which will be called each time there's audio data to process
    # - on_stop:     Callback function which will be called when the current capture stops (can be NULL)
    # - user_data:   Data to pass to the callback function (can be NULL)
    # 
    # Returns: A new SoundRecorder object (NULL if failed)
  
  fun sound_recorder_destroy = sfSoundRecorder_destroy(sound_recorder: SoundRecorder): Void
    # Destroy a sound recorder
    # 
    # Arguments:
    # - sound_recorder:  Sound recorder to destroy
  
  fun sound_recorder_start = sfSoundRecorder_start(sound_recorder: SoundRecorder, sample_rate: Int32): Int32
    # Start the capture of a sound recorder
    # 
    # The `sample_rate` parameter defines the number of audio samples
    # captured per second. The higher, the better the quality
    # (for example, 44100 samples/sec is CD quality).
    # This function uses its own thread so that it doesn't block
    # the rest of the program while the capture runs.
    # Please note that only one capture can happen at the same time.
    # 
    # Arguments:
    # - sound_recorder:  Sound recorder object
    # - sample_rate:     Desired capture rate, in number of samples per second
    # 
    # Returns: True, if start of capture was successful
  
  fun sound_recorder_stop = sfSoundRecorder_stop(sound_recorder: SoundRecorder): Void
    # Stop the capture of a sound recorder
    # 
    # Arguments:
    # - sound_recorder:  Sound recorder object
  
  fun sound_recorder_get_sample_rate = sfSoundRecorder_getSampleRate(sound_recorder: SoundRecorder): Int32
    # Get the sample rate of a sound recorder
    # 
    # The sample rate defines the number of audio samples
    # captured per second. The higher, the better the quality
    # (for example, 44100 samples/sec is CD quality).
    # 
    # Arguments:
    # - sound_recorder:  Sound recorder object
    # 
    # Returns: Sample rate, in samples per second
  
  fun sound_recorder_is_available = sfSoundRecorder_isAvailable(): Int32
    # Check if the system supports audio capture
    # 
    # This function should always be called before using
    # the audio capture features. If it returns false, then
    # any attempt to use SoundRecorder will fail.
    # 
    # Returns: True if audio capture is supported, False otherwise
  
  fun sound_recorder_set_processing_interval = sfSoundRecorder_setProcessingInterval(sound_recorder: SoundRecorder, interval: Time): Void
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
    # Arguments:
    # - sound_recorder:  Sound recorder object
    # - interval:  Processing interval
  
  fun sound_recorder_get_available_devices = sfSoundRecorder_getAvailableDevices(count: Size_t*): UInt8**
    # Get a list of the names of all availabe audio capture devices
    # 
    # This function returns an array of strings (null terminated),
    # containing the names of all availabe audio capture devices.
    # If no devices are available then NULL is returned.
    # 
    # Arguments:
    # - count:  Pointer to a variable that will be filled with the number of modes in the array
    # 
    # Returns: An array of strings containing the names
  
  fun sound_recorder_get_default_device = sfSoundRecorder_getDefaultDevice(): UInt8*
    # Get the name of the default audio capture device
    # 
    # This function returns the name of the default audio
    # capture device. If none is available, NULL is returned.
    # 
    # Returns: The name of the default audio capture device (null terminated)
  
  fun sound_recorder_set_device = sfSoundRecorder_setDevice(sound_recorder: SoundRecorder, name: UInt8*): Int32
    # Set the audio capture device
    # 
    # This function sets the audio capture device to the device
    # with the given name. It can be called on the fly (i.e:
    # while recording). If you do so while recording and
    # opening the device fails, it stops the recording.
    # 
    # Arguments:
    # - sound_recorder:  Sound recorder object
    # - The:  name of the audio capture device
    # 
    # Returns: True, if it was able to set the requested device
  
  fun sound_recorder_get_device = sfSoundRecorder_getDevice(sound_recorder: SoundRecorder): UInt8*
    # Get the name of the current audio capture device
    # 
    # Arguments:
    # - sound_recorder:  Sound recorder object
    # 
    # Returns: The name of the current audio capture device
  
end