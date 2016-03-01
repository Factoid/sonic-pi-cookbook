live_loop :foo do
  sample :loop_breakbeat, beat_stretch: 2, amp: 3
  sleep 2
end

live_loop :chords, sync: :foo do
  sync :foo
  with_fx :distortion do
    4.times do
      sample :ambi_choir, beat_stretch: 8, amp: 0.5
      sleep 2
    end
  end
end

live_loop :bar, sync: :foo do
  sync :foo
  sample :ambi_soft_buzz, beat_stretch: 2, rate: 1, amp: 4
  sleep 8
end

live_loop :baz do
  sync :foo
  sample :ambi_glass_hum, beat_stretch: 16, cutoff: 80
  sleep 4
end

live_loop :phrase do
  sync :foo
  sleep 4
end

live_loop :notes do
  sync :phrase
  use_synth :dsaw
  use_synth_defaults detune: 4, attack: 0.01, release: 0.1
  sleep 0.45
  use_octave 1
  with_fx :ixi_techno, res: 0.5, phase: 4.5*0.125 do
    with_fx :echo, phase: 0.25, decay: 0.75 do
      play_pattern_timed [:a4,:r,:a4,:a4,:a4,:r,:g4,:r,:d4], 0.125
    end
  end
end