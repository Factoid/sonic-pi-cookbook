use_bpm 140

define :do_scale do
  play_pattern_timed chord( :c1, :major, num_octaves: 8 ), 0.5
end

define :do_filters do
  puts "Scale"
  do_scale
  puts "Scale with high pass filter"
  with_fx :hpf, cutoff: :c7 do
    do_scale
  end
  puts "Scale with low pass filter"
  with_fx :lpf, cutoff: :c2 do
    do_scale
  end
  puts "Scale with band pass filter"
  with_fx :bpf, centre: :c4 do
    do_scale
  end
end

%i(sine saw square tri).each do |synth|
  puts "Using synth #{synth}"
  use_synth synth
  do_filters
end