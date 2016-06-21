define :hat do
  with_bpm 60 do
    with_fx :rlpf, cutoff: [110,90,120].choose, res: [0.7,0.9].choose do |lfx|
      with_fx :rhpf, cutoff: [60,70,80].choose, res: 0.9, mix: 0.2 do |hfx|
        control lfx, res: 0.7, res_slide: 0.1
        control hfx, res: 0.4, res_slide: 0.1
        synth :noise, release: 0.1
      end
    end
  end
end

define :snare do |n=:c4|
  with_bpm 60 do
    with_fx :lpf, cutoff: 90 do |lpf|
      with_fx :hpf, cutoff: 70 do |hpf|
        s = synth :tri, note: n, release: 0.15
        control s, note: n-12, note_slide: 0.1
        synth :noise, amp: 3, release: 0.15
        control hpf, cutoff: 30, cutoff_slide: 0.05
        control lpf, cutoff: 40, cutoff_slide: 0.15
      end
    end
  end
end

live_loop :drum do
  use_bpm 200
  use_random_seed 90
  at [1,3,4,5,7.5,8] do
    snare :c4+rrand(-3,3)
  end
  at range(1,8,step:0.5) do
    hat
  end
  sleep 8
end

