c1 = [244,663,1272,2050]
c2 = [278,753,1441,2314]
c3 = [312,850,1625,2600]
c4 = [330,890,1700,2712]
c5 = [371,1000,3031,4351]
notes = [c1,c2,c3,c4,c5]
use_random_seed 14
live_loop :chimes do
  with_fx :lpf, cutoff: 60 do |fx|
    at [0, 0.05], [[110,0.001],[60,1]] do |c|
      control fx, cutoff: c[0], cutoff_slide: c[1]
    end
    use_octave 2
    use_synth :sine
    use_synth_defaults attack: 0.0, decay: 0.4, sustain_level: 0.7, release: 2
    notes.choose.each do |v|
      play hz_to_midi(v)
    end
  end
  sleep [0.2,0.3,0.7,0.6,0.8,1.0].choose
end
