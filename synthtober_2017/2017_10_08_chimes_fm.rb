notes = scale(:ds6,:minor_pentatonic)
pan_v = ring(-0.5,-0.25,0,0.25,0.5)
ni = 3
use_random_seed 18
vol = 0.8
use_synth_defaults attack: 0.00, decay: 0.6,  sustain_level: 0.3, release: 0.6
use_synth :fm
live_loop :chimes do
  vol = 0.8 if vol > 0.8
  with_fx :reverb, mix: 0.6, room: 0.4 do
    with_fx :lpf, cutoff: 90, mix: 1.0 do |fx|
      with_fx :hpf, cutoff: 90, mix: 1 do
        nc = play notes[ni], divisor: 0.6, depth: 0, pan: pan_v[ni], amp: vol
        control nc, depth: 6, depth_slide: 0.5
      end
    end
    slp = [0.4,0.5,0.9,1.0,1.1,1.2,1.5,1.4,1.6,1.65,2.0].choose
    if slp <= 0.5
      ni += [-1,2].choose
    else
      ni += [3,3,2,-3,-3,-2].choose
    end
    vol -= 0.6
    vol = 0 if vol < 0
    vol += (slp * 0.3)
    sleep slp
  end
end
