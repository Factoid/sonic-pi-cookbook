last_note = nil
define :foo do |n|
  in_thread do
    return if rest? n
    last_note ||= n
    with_fx :rlpf, cutoff: 90, res: 0.7 do |lpf|
      control lpf, cutoff: 10, cutoff_slide: 0.5
      with_synth_defaults attack: 0.05, release: 0.05, sustain: 0.25 do
        with_cent_tuning 10 do
          s1 = synth :saw, note: n, amp: 0.8
          control s1, note: n-12, note_slide: 0.1
        end
        #last_note = n
        s2 = synth :fm, note: last_note, amp: 1, divisor: 2, depth: 10
        control s2, note: n, note_slide: 0.15
        last_note = n
        #control s2, note: n-12, note_slide: 0.2
        synth :pnoise, amp: 0.8, attack: 0.1, release: 0.1, sustain: 0.0
      end
    end
  end
end

live_loop :bass do
  with_octave -2 do
    with_fx :reverb, room: 0.6, damp: 1 do
      #foo %i[e r c5 r b a r d e f f e r a g d].ring.tick
      foo %i[e e e e e e f f e e e e e e d d].ring.tick
      sleep 0.25
    end
  end
end