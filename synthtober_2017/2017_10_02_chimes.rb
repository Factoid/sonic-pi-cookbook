c1 = [244,663,1272,2050]
c2 = [278,753,1441,2314]
c3 = [312,850,1625,2600]
c4 = [330,890,1700,2712]
c5 = [371,1000,3031,4351]
notes = ring(c1,c2,c3,c4,c5)
ni = 3
use_random_seed 18
vol = 1.0
live_loop :chimes do
  with_fx :reverb, mix: 0.8, room: 0.6, damp: 1 do
    with_fx :lpf, cutoff: 30 do |fx|
      at [0, 0.05], [[110,0.005],[70,1]] do |c|
        control fx, cutoff: c[0], cutoff_slide: c[1]
      end
      use_octave 2.7
      use_synth :sine
      use_synth_defaults attack: 0.0, decay: 0.4,  sustain_level: 0.7, release: 2
      notes[ni].each do |v|
        play hz_to_midi(v), amp: vol * 0.7
      end
    end
    slp = [0.2,0.3,0.9,1.0,1.5,2.0].choose
    if slp < 0.5
      ni += [-1,2].choose
    else
      ni += [3,3,2,-3,-3,-2].choose
    end
    vol /= 4
    vol += slp * 0.6
    vol = 0 if vol < 0
    vol = 1.0 if vol > 1
    sleep slp
  end
end
