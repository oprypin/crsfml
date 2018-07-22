# Adapted from SFML Sound Capture example
# https://github.com/SFML/SFML/blob/master/examples/sound_capture/SoundCapture.cpp

require "crsfml/system"
require "crsfml/audio"


unless SF::SoundRecorder.available?
  puts "Sorry, audio capture is not supported by your system"
  exit
end

sample_rate = input("Choose the sample rate for sound capture (44100 is CD quality):", 44100).to_i

recorder = SF::SoundBufferRecorder.new

recorder.start(sample_rate)
input("Recording... press Enter to stop")
recorder.stop

buffer = recorder.buffer

puts "Sound information:"
puts " #{buffer.duration.as_seconds} seconds"
puts " #{buffer.sample_rate} samples/second"
puts " #{buffer.channel_count} channels"

case input("What do you want to do with the captured sound (p = play, s = save)?", "p")
when .starts_with? "s"
  filename = input("Choose the file to create (capture.wav):", "capture.wav")
  buffer.save_to_file filename
else
  sound = SF::Sound.new(buffer)
  sound.play

  while sound.status.playing?
    puts "Playing... #{sound.playing_offset.as_seconds} sec"
    SF.sleep SF.milliseconds(100)
  end
end

puts "Done!"


def input(prompt, default = nil)
  print "#{prompt} "
  s = read_line
  return default if s.empty?
  s
end
