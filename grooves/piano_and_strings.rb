use_synth :piano
use_bpm 120
live_loop :chords do
  [1, 3, 6, 4].each { |d| range(-3,3).each { |i| play_chord chord_degree d, :c, :major, 3, invert: i; sleep 0.5 } }
end

live_loop :strings do
  sync :chords
  use_synth :mod_saw
  with_fx :hpf, cutoff: 60 do |bpf|
    use_synth_defaults cutoff: 80, mod_range: 0.4, sustain: 2, mod_phase: 0.025, mod_wave: 3
    nd = [4,1.5,0.5,6]*2 + [4,1.5,0.5,5.5] + [0.5,1.5,0.5,1.5,1.5,0.5,0.5,6]
    np = [:g5,:e5,:d5,:c5, :g5,:e5,:g5,:a5, :g5,:e5,:d5,:c5, :d5,:e5,:f5,:e5,:d5,:c5,:b4,:c5,:d5]
    np.zip(nd).each do |p,d|
      #control bpf, cutoff: p
      play p, cutoff: 70, decay: d/2, sustain: d/2, attack: 0.25, sustain_level: 0.25, decay_level: 0.25, release: 0.1
      sleep d
    end
  end
end