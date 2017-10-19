use_bpm 130
live_loop :pads do
  use_synth :fm
  use_synth_defaults mod_range: 0.25, divisor: 4.0/2.0, attack: 0.1, sustain: 6, release: 2, amp: 0.5
  with_fx :distortion, distort: 0.9, mix: 0.1 do
    with_fx :ixi_techno, phase: 1, cutoff_min: 20, cutoff_max: 120, res: 0.3, mix: 0.5 do
      with_fx :flanger, phase: 8, mix: 1 do
        with_fx :reverb, mix: 1, room: 0.8 do
          with_fx :echo, mix: 1, phase: 2, decay: 16, max_phase: 16 do
            use_random_seed 10
            4.times do
              c = chord_invert(chord_degree(ring(1,5,6,4).tick,:d,:minor,3),ring(1,-1,-1,0).look)
              play_chord c
              sleep 8
            end
          end
        end
      end
    end
  end
end

sleep 0.25
live_loop :kick do
  use_sample_defaults amp: 7.0, beat_stretch: 0.75
  sample :bd_808
  sleep 3.5
  sample :bd_808
  sleep 0.5
  sample :bd_808
  sleep 1
  sample :bd_808
  sleep 3
end

live_loop :snare do
  sleep 3.0
  with_random_seed 2 do
    8.times do
      sample :sn_zome, beat_stretch: 0.1 if one_in(2)
      sleep 0.125
    end
  end
end