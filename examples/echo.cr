require "crsfml"
require "crsfml/audio"

$mutex = SF::Mutex.new()

$samples = Slice(Int16).new(1024*1024, 0i16)
$count = 0


class MySoundRecorder < SF::SoundRecorder
  def on_start()
    true
  end
  def on_process_samples(samples)
    $mutex.lock
    samples.each do |x|
      $samples[$count] = x
      $count += 1
    end
    $mutex.unlock
    true
  end
  def on_stop()
  end
end

class MySoundStream < SF::SoundStream
  def on_get_data()
    while $count == 0
      SF.sleep(SF.seconds(0.05))
    end
    $mutex.lock
    result = $samples.to_unsafe.to_slice($count)
    $count = 0
    $mutex.unlock
    result
  end
  def on_seek(position)
  end
end


sr = MySoundRecorder.new()
sr.start(44100)
ss = MySoundStream.new(1, 44100)
ss.play()

puts "Recording... Press Enter to stop"
gets

sr.stop()
ss.stop()
