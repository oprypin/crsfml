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

  class Sound
    def initialize(buffer: SoundBuffer)
      initialize()
      self.buffer = buffer
    end
  end

  class SoundBuffer
    def to_slice
      samples.to_slice(sample_count.to_i)
    end
  end

  class SoundRecorder
    def self.available_devices
      ptr = CSFML.sound_recorder_get_available_devices(out count)
      ptr.to_slice(count.to_i).map { |p| p ? String.new(p) : "" }
    end

    def start()
      start(44100)
    end
  end

  class SoundBufferRecorder
    def self.available?
      SoundRecorder.available?
    end
    def self.default_device
      SoundRecorder.default_device
    end
    def self.available_devices
      SoundRecorder.available_devices
    end

    def start()
      start(44100)
    end
  end

  class SoundStream
    abstract def on_get_data(): Slice(Int16)
    abstract def on_seek(position: Time): Void

    # :nodoc:
    alias FuncBox = Box({(CSFML::SoundStreamChunk* -> CSFML::Bool), (Time -> Nil)})

    def initialize(channel_count: Int, sample_rate: Int)
      @owned = true
      @funcs = FuncBox.box({
        ->(data: CSFML::SoundStreamChunk*) {
          slice = on_get_data()
          data.value.samples = slice.to_unsafe
          data.value.sample_count = slice.length
          slice.length > 0 ? 1 : 0
        },
        ->(time_offset: Time) { on_seek(time_offset); nil }
      })
      @this = CSFML.sound_stream_create(
        ->(data, ud) { FuncBox.unbox(ud)[0].call(data) },
        ->(time_offset, ud) { FuncBox.unbox(ud)[1].call(time_offset) if ud },
        channel_count.to_i, sample_rate.to_i,
        @funcs
      )
    end
  end

  class SoundRecorder
    abstract def on_start(): Bool
    abstract def on_process_samples(samples: Slice(Int16)): Bool
    abstract def on_stop(): Void

    # :nodoc:
    alias FuncBox = Box({(-> CSFML::Bool), ((Int16*, LibC::SizeT) -> CSFML::Bool), (-> Nil)})

    def initialize()
      @owned = true
      @funcs = FuncBox.box({
        ->() { on_start() ? 1 : 0 },
        ->(samples: Int16*, sample_count: LibC::SizeT) {
          slice = samples.to_slice(sample_count.to_i)
          on_process_samples(slice) ? 1 : 0
        },
        ->() { on_stop(); nil }
      })
      @this = CSFML.sound_recorder_create(
        ->(ud) { FuncBox.unbox(ud)[0].call() },
        ->(samples, sample_count, ud) { FuncBox.unbox(ud)[1].call(samples, sample_count) },
        ->(ud) { FuncBox.unbox(ud)[2].call() },
        @funcs
      )
    end
  end
end

require "./audio_obj"
