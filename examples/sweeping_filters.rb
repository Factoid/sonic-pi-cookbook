use_synth :saw

define :lpf_sweep do |p|
  with_fx :lpf, cutoff: 0 do |fx|
    play 60, amp: 1, pan: p, attack: 0, release: 0, sustain: 10
    sleep 2
    control fx, cutoff: 130.999, cutoff_slide: 5
  end
end

define :hpf_sweep do |p|
  with_fx :hpf, cutoff: 0 do |fx|
    play 60, amp: 1, pan: p, attack: 0, release: 0, sustain: 10
    sleep 2
    control fx, cutoff: 130.999, cutoff_slide: 5
  end
end

define :bpf_sweep do |p|
  with_fx :bpf, centre: 0 do |fx|
    play 60, amp: 1, pan: p, attack: 0, release: 0, sustain: 10
    sleep 2
    control fx, centre: 130.999, centre_slide: 5
  end
end

#play 60, amp: 1, pan: -1, attack: 0, release: 0, sustain: 10
in_thread do
  lpf_sweep(-1)
end
#sleep 10
in_thread do
  #hpf_sweep(-1)
end
#sleep 10
in_thread do
  bpf_sweep(1)
end