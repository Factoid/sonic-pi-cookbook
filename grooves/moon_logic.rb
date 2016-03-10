use_bpm 80

use_synth :chipbass
use_synth_defaults attack: 0.01, release: 0.01, sustain: 0.23
[:fs,:f,:ds,:cs,:b3,:c,:cs,:cs].each do |n|
  puts vt
  8.times do
    play n
    sleep 0.25
  end
end

[:fs,:e,:ds,:d,:cs].each do |n|
  8.times do
    play n
    sleep 0.25
  end
end
[:c,:cs].each do |n|
  4.times do
    play n
    sleep 0.25
  end
end
play_pattern_timed [:d,:e,:fs], [0.75,0.75,0.5], sustain: 0.48
c = play :fs3, note_slide: 2.0, sustain: 2.0
control c, note: :fs
sleep 2