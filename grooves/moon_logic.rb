use_bpm 80

define :bass_part_a do
  [:fs,:f,:ds,:cs,:b3,:c,:cs,:cs].each do |n|
    puts vt
    8.times do
      play n
      sleep 0.25
    end
  end
end

define :bass_part_b do
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
end

define :bassline do
  use_synth :chipbass
  use_synth_defaults attack: 0.01, release: 0.01, sustain: 0.23
  use_octave -1
  
  bass_part_a
  bass_part_b
end

define :lead_loop do
  use_synth :chiplead
  use_synth_defaults sustain: 0.2, attack: 0.01, release: 0.02
  n = %i(fs cs fs gs cs gs b cs b cs b as gs fs r r r r)
  d = [0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25]
  play_pattern_timed n, d
end

define :main_part_a do
  n = %i(r     e     f     g     g    r    c5   b    c5  d5    e5    c5     r    c5     b    c5    g5    c5    c5  r    c5    d5    c5    c5    d5    c5     b    r)
  d =   [1, 0.25, 0.25, 0.25, 0.25, 0.5, 0.5, 0.5, 0.5, 0.5, 0.25, 0.25, 2.25, 0.25, 0.25, 0.25, 0.75, 0.25, 0.25, 2, 0.25, 0.25, 0.25, 1.25, 0.25, 0.25, 0.25, 2.0]
  play_pattern_timed n, d
end

define :main_part_b do
  n =  %i(r     e     d     c     g    r   c5   d5    f5    e5    e5     r   g5   f5    e5    f5    e5   c5    g    r    d5    c5     b     a     b     r     c5    c5    c5     r)
  d =    [1, 0.25, 0.25, 0.25, 0.25, 1.0, 0.5, 0.5, 0.75, 0.25, 0.25, 1.75, 0.5, 0.5, 0.25, 0.25, 0.25, 0.5, 0.5, 0.5, 0.25, 0.25, 0.25, 0.25, 0.25,  0.5,  0.75, 0.75, 0.75, 1.75]
  play_pattern_timed n, d
end

define :main do
  use_synth :chiplead
  use_transpose 6
  main_part_a
  main_part_b
end

live_loop :main do
  main
end
live_loop :bass do
  bassline
end

live_loop :drums do
  stop
  use_synth :chipnoise
  with_fx :bpf, centre: :c2 do
    play :c, attack: 0.01, release: 0.01, sustain: 0.05
    sleep 0.5
  end
  with_fx :lpf, centre: 60 do
    play :e, attack: 0.0, release: 0.0, sustain: 0.01
    sleep 0.5
  end
end