live_loop :amb1 do
  sample :ambi_drone, beat_stretch: 8, lpf: 60
  sleep 8
end

live_loop :amb2 do
  sample :ambi_haunted_hum, beat_strech: 16
  sleep 16
end

live_loop :kick do
  sample :bd_sone
  sleep 1
end

live_loop :chords do
  sample :bass_voxy_c, beat_stretch: 4, lpf: 60
  sleep 2
end

live_loop :snare, sync: :kick do
  sleep 3.5
  sample :drum_snare_soft
  sleep 0.5
end

live_loop :notes do
  use_random_seed 500
  use_synth :fm
  use_synth_defaults attack: 0.01, release: 0.5, sustain: 0.1, divisor: 3
  notes = chord( :a2, 'm7', num_octaves: 2 )
  2.times do
    play_pattern_timed notes.shuffle, [0.25,0.25,0.25,1.5,1.0], depth: 0.2
  end
end

