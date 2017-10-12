define :death do
  use_octave -1
  use_synth :mod_saw
  n = play :c6, mod_phase: 0.05, mod_range: 5, mod_wave: 0, mod_pulse_width: 0.15, attack: 0.01, release: 1.5
  i = 10
  i.times do
    control n, note: ring(:c7,:c6).tick, note_slide: 1.5/i
    sleep 1.5/i
  end
end

define :laser do
  use_octave -2
  use_synth :mod_saw
  n = play :c6, mod_phase: 0.05, mod_range: 12, mod_wave: 0, mod_pulse_width: 0.5, attack: 0.01, sustain: 2, release: 0.1
  i = 10
  i.times do
    control n, note: ring(:c7,:g6).tick, note_slide: 2/i
    sleep 2/i
  end
end

define :warp_up do
  use_synth :dsaw
  n = play :c2, attack: 6, detune: 0.67, release: 2
  control n, note: :f5, note_slide: 4
end

define :air_raid do
  use_synth :dsaw
  n = play :c2, attack: 6, detune: 3, release: 3
  control n, note: :c6, note_slide: 4
end

warp_up
sleep 9
air_raid
sleep 10
laser
sleep 3
death