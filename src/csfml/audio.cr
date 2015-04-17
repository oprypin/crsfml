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


require "./audio_lib"

module SF
  extend self

  alias SoundStatus = CSFML::SoundStatus
     
  class Music
    def self.wrap_ptr(p)
      result = self.allocate()
      result.this = p
      result
    end
    def to_unsafe
      @this
    end
    def initialize(filename: String)
      @owned = true
      @this = CSFML.music_create_from_file(filename)
    end
    def initialize(data: Void*, size_in_bytes: Size_t)
      @owned = true
      @this = CSFML.music_create_from_memory(data, size_in_bytes)
    end
    def initialize(stream: InputStream*)
      @owned = true
      @this = CSFML.music_create_from_stream(stream)
    end
    def finalize()
      CSFML.music_destroy(@this) if @owned
    end
    def loop=(loop: Bool)
      loop = loop ? 1 : 0
      CSFML.music_set_loop(@this, loop)
    end
    def loop
      CSFML.music_get_loop(@this) != 0
    end
    def duration
      CSFML.music_get_duration(@this)
    end
    def play()
      CSFML.music_play(@this)
    end
    def pause()
      CSFML.music_pause(@this)
    end
    def stop()
      CSFML.music_stop(@this)
    end
    def channel_count
      CSFML.music_get_channel_count(@this)
    end
    def sample_rate
      CSFML.music_get_sample_rate(@this)
    end
    def status
      CSFML.music_get_status(@this)
    end
    def playing_offset
      CSFML.music_get_playing_offset(@this)
    end
    def pitch=(pitch)
      pitch = pitch.to_f32
      CSFML.music_set_pitch(@this, pitch)
    end
    def volume=(volume)
      volume = volume.to_f32
      CSFML.music_set_volume(@this, volume)
    end
    def position=(position: Vector3f)
      CSFML.music_set_position(@this, position)
    end
    def relative_to_listener=(relative: Bool)
      relative = relative ? 1 : 0
      CSFML.music_set_relative_to_listener(@this, relative)
    end
    def min_distance=(distance)
      distance = distance.to_f32
      CSFML.music_set_min_distance(@this, distance)
    end
    def attenuation=(attenuation)
      attenuation = attenuation.to_f32
      CSFML.music_set_attenuation(@this, attenuation)
    end
    def playing_offset=(time_offset: Time)
      CSFML.music_set_playing_offset(@this, time_offset)
    end
    def pitch
      CSFML.music_get_pitch(@this)
    end
    def volume
      CSFML.music_get_volume(@this)
    end
    def position
      CSFML.music_get_position(@this)
    end
    def relative_to_listener
      CSFML.music_is_relative_to_listener(@this) != 0
    end
    def min_distance
      CSFML.music_get_min_distance(@this)
    end
    def attenuation
      CSFML.music_get_attenuation(@this)
    end
  end

  class Sound
    def self.wrap_ptr(p)
      result = self.allocate()
      result.this = p
      result
    end
    def to_unsafe
      @this
    end
    def initialize()
      @owned = true
      @this = CSFML.sound_create()
    end
    def copy()
      self.wrap_ptr(CSFML.sound_copy(@this))
    end
    def finalize()
      CSFML.sound_destroy(@this) if @owned
    end
    def play()
      CSFML.sound_play(@this)
    end
    def pause()
      CSFML.sound_pause(@this)
    end
    def stop()
      CSFML.sound_stop(@this)
    end
    def buffer=(buffer: SoundBuffer)
      CSFML.sound_set_buffer(@this, buffer)
    end
    def buffer
      self.wrap_ptr(CSFML.sound_get_buffer(@this))
    end
    def loop=(loop: Bool)
      loop = loop ? 1 : 0
      CSFML.sound_set_loop(@this, loop)
    end
    def loop
      CSFML.sound_get_loop(@this) != 0
    end
    def status
      CSFML.sound_get_status(@this)
    end
    def pitch=(pitch)
      pitch = pitch.to_f32
      CSFML.sound_set_pitch(@this, pitch)
    end
    def volume=(volume)
      volume = volume.to_f32
      CSFML.sound_set_volume(@this, volume)
    end
    def position=(position: Vector3f)
      CSFML.sound_set_position(@this, position)
    end
    def relative_to_listener=(relative: Bool)
      relative = relative ? 1 : 0
      CSFML.sound_set_relative_to_listener(@this, relative)
    end
    def min_distance=(distance)
      distance = distance.to_f32
      CSFML.sound_set_min_distance(@this, distance)
    end
    def attenuation=(attenuation)
      attenuation = attenuation.to_f32
      CSFML.sound_set_attenuation(@this, attenuation)
    end
    def playing_offset=(time_offset: Time)
      CSFML.sound_set_playing_offset(@this, time_offset)
    end
    def pitch
      CSFML.sound_get_pitch(@this)
    end
    def volume
      CSFML.sound_get_volume(@this)
    end
    def position
      CSFML.sound_get_position(@this)
    end
    def relative_to_listener
      CSFML.sound_is_relative_to_listener(@this) != 0
    end
    def min_distance
      CSFML.sound_get_min_distance(@this)
    end
    def attenuation
      CSFML.sound_get_attenuation(@this)
    end
    def playing_offset
      CSFML.sound_get_playing_offset(@this)
    end
  end

  class SoundBuffer
    def self.wrap_ptr(p)
      result = self.allocate()
      result.this = p
      result
    end
    def to_unsafe
      @this
    end
    def initialize(filename: String)
      @owned = true
      @this = CSFML.sound_buffer_create_from_file(filename)
    end
    def initialize(data: Void*, size_in_bytes: Size_t)
      @owned = true
      @this = CSFML.sound_buffer_create_from_memory(data, size_in_bytes)
    end
    def initialize(stream: InputStream*)
      @owned = true
      @this = CSFML.sound_buffer_create_from_stream(stream)
    end
    def initialize(samples, sample_count: Size_t, channel_count: Int32, sample_rate: Int32)
      if samples
        csamples = samples; psamples = pointerof(csamples)
      else
        psamples = nil
      end
      @owned = true
      @this = CSFML.sound_buffer_create_from_samples(psamples, sample_count, channel_count, sample_rate)
    end
    def copy()
      self.wrap_ptr(CSFML.sound_buffer_copy(@this))
    end
    def finalize()
      CSFML.sound_buffer_destroy(@this) if @owned
    end
    def save_to_file(filename: String)
      CSFML.sound_buffer_save_to_file(@this, filename) != 0
    end
    def samples
      CSFML.sound_buffer_get_samples(@this)
    end
    def sample_count
      CSFML.sound_buffer_get_sample_count(@this)
    end
    def sample_rate
      CSFML.sound_buffer_get_sample_rate(@this)
    end
    def channel_count
      CSFML.sound_buffer_get_channel_count(@this)
    end
    def duration
      CSFML.sound_buffer_get_duration(@this)
    end
  end

  class SoundBufferRecorder
    def self.wrap_ptr(p)
      result = self.allocate()
      result.this = p
      result
    end
    def to_unsafe
      @this
    end
    def initialize()
      @owned = true
      @this = CSFML.sound_buffer_recorder_create()
    end
    def finalize()
      CSFML.sound_buffer_recorder_destroy(@this) if @owned
    end
    def start(sample_rate: Int32)
      CSFML.sound_buffer_recorder_start(@this, sample_rate)
    end
    def stop()
      CSFML.sound_buffer_recorder_stop(@this)
    end
    def sample_rate
      CSFML.sound_buffer_recorder_get_sample_rate(@this)
    end
    def buffer
      self.wrap_ptr(CSFML.sound_buffer_recorder_get_buffer(@this))
    end
  end

  class SoundRecorder
    def self.wrap_ptr(p)
      result = self.allocate()
      result.this = p
      result
    end
    def to_unsafe
      @this
    end
    def initialize(on_start: SoundRecorderStartCallback, on_process: SoundRecorderProcessCallback, on_stop: SoundRecorderStopCallback, user_data: Void*)
      @owned = true
      @this = CSFML.sound_recorder_create(on_start, on_process, on_stop, user_data)
    end
    def finalize()
      CSFML.sound_recorder_destroy(@this) if @owned
    end
    def start(sample_rate: Int32)
      CSFML.sound_recorder_start(@this, sample_rate) != 0
    end
    def stop()
      CSFML.sound_recorder_stop(@this)
    end
    def sample_rate
      CSFML.sound_recorder_get_sample_rate(@this)
    end
    def processing_interval=(interval: Time)
      CSFML.sound_recorder_set_processing_interval(@this, interval)
    end
    def device=(name: String)
      CSFML.sound_recorder_set_device(@this, name) != 0
    end
    def device
      CSFML.sound_recorder_get_device(@this)
    end
  end

  class SoundStream
    def self.wrap_ptr(p)
      result = self.allocate()
      result.this = p
      result
    end
    def to_unsafe
      @this
    end
  end

  def listener_set_global_volume(volume)
    volume = volume.to_f32
    CSFML.listener_set_global_volume(volume)
  end
  def listener_get_global_volume()
    CSFML.listener_get_global_volume()
  end
  def listener_set_position(position: Vector3f)
    CSFML.listener_set_position(position)
  end
  def listener_get_position()
    CSFML.listener_get_position()
  end
  def listener_set_direction(direction: Vector3f)
    CSFML.listener_set_direction(direction)
  end
  def listener_get_direction()
    CSFML.listener_get_direction()
  end
  def listener_set_up_vector(up_vector: Vector3f)
    CSFML.listener_set_up_vector(up_vector)
  end
  def listener_get_up_vector()
    CSFML.listener_get_up_vector()
  end
  def sound_recorder_is_available()
    CSFML.sound_recorder_is_available() != 0
  end
  def sound_recorder_get_available_devices(count: Size_t*)
    CSFML.sound_recorder_get_available_devices(count)
  end
  def sound_recorder_get_default_device()
    CSFML.sound_recorder_get_default_device()
  end
end