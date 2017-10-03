use_synth_defaults attack: 0.2, sustain: 2.8, release: 0.2
with_fx :ixi_techno, res: 0, cutoff_min: 30, cutoff_max: 120, phase: 32 do |fx|
  live_loop :c do
    at [16,0], [0,1] do |a,b|
      puts "set control to #{b}"
      control fx, mix: b, mix_slide: 0.2
    end
    sleep 32
  end
  live_loop :d do
    sample :loop_amen, beat_stretch: 2
    sleep 2
  end
end