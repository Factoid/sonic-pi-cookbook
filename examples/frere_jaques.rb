use_bpm 140
use_octave -1

define :jaques do
  2.times do
    play_pattern [:c,:d,:e,:c]
  end
  2.times do
    play_pattern [:e,:f,:g,:r]
  end
  2.times do
    play_pattern_timed [:g,:a,:g,:f,:e,:r,:c,:r], 0.5
  end
  2.times do
    play_pattern [:c,:g3,:c,:r]
  end
end

3.times do |i|
  in_thread do
    use_synth [:beep,:saw,:square][i]
    jaques
  end
  sleep 8
end