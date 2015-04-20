# Adapted from SFML Sound Capture example
# https://github.com/LaurentGomila/SFML/blob/master/examples/sound_capture/SoundCapture.cpp

require "csfml/system"
require "csfml/audio"


unless SF::SoundRecorder.is_available
  puts "Sorry, audio capture is not supported by your system"
  exit
end

puts "Please choose the sample rate for sound capture (44100 is CD quality):"
sample_rate = gets().to_i

recorder = SF::SoundBufferRecorder.new()

recorder.start(sample_rate)
puts "Recording... press Enter to stop"
gets()
recorder.stop()

buffer = recorder.buffer

puts "Sound information:"
puts " #{buffer.duration.as_seconds} seconds"
puts " #{buffer.sample_rate} samples/seconds"
puts " #{buffer.channel_count} channels"

puts "What do you want to do with captured sound (p = play, s = save)?"
choice = gets()

if choice == "s\n"
  puts "Choose the file to create:"
  filename = gets().to_s.chomp
  buffer.save_to_file filename
else
  sound = SF::Sound.new(buffer)
  sound.play()

  while sound.status == SF::SoundSource_Playing
    puts "Playing... #{sound.playing_offset.as_seconds} sec"
    SF.sleep SF.milliseconds(100)
  end
end

puts "Done!"
