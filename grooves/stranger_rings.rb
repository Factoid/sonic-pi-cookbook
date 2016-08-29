use_bpm 150

live_loop :arp do
  with_fx :reverb do
    use_synth :dpulse
    use_synth_defaults attack: 0.1, pulse_width: 0.2, dpulse_width: 0.3, release: 0.2, detune: 0.35, cutoff: 75
    steps = [0,2,3,7,8].ring.reflect.butlast
    play_pattern_timed steps.map { |x| x + 50 }, 0.5
  end
end

live_loop :pad do
  stop
  use_synth :blade
  steps = [0,0,-2,-4,-2,0]
  time = [8,6,2,6,2,8]
  
  steps.zip(time).each do |s,t|
    play 50-12+s, release: t
    sleep t
  end
end