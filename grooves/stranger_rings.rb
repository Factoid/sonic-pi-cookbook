use_bpm 160

live_loop :arp do
  use_synth_defaults attack: 0.05, pulse_width: 0.3, dpulse_width: 0.4, release: 0.4, detune: -12.1, amp: 1
  notes = chord(:c2,:major7,num_octaves: 2).take(5).reflect.butlast
  with_fx :reverb do
    use_synth :dpulse
    with_fx :ixi_techno, res: 0.7, cutoff_min: :c5, cutoff_max: :c7, phase: 32 do
      8.times { play_pattern_timed notes, 0.5 }
    end
  end
end

live_loop :heart do
  2.times do
    sample :bd_808, amp: 10
    sleep 0.5
  end
  sleep 1
end

live_loop :pad do
  use_synth :dsaw
  use_synth_defaults attack: 0.25, decay: 0.1, sustain_level: 0.5, detune: 0.05, amp: 2, cutoff: 120
  steps = chord(:c2,:add2).take(3).reflect.butlast
  time = [14,2,14,2]
  
  steps.zip(time).each do |s,t|
    c = play s, release: t + 1
    control c, cutoff: 80, cutoff_slide: 14
    sleep t
  end
end