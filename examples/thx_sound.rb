#THX Sound
use_synth :saw

define :rtone do
  hz_to_midi(rrand(200,400))
end

define :thx_voice do |end_pitch|
  in_thread do
    n = play rtone, attack: 8, sustain: 12, release: 4, amp: 0.01
    at [0,6] do
      control n, note: rtone, note_slide: 6
    end
    at [8] do
      control n, note: end_pitch, note_slide: 6, amp: 0.25, amp_slide: 12
    end
  end
end

[:a2,:d3,:a3,:d,:a,:d5,:a5,:d6,:f6].each do |final|
  thx_voice final + 0.1
  thx_voice final - 0.1
  thx_voice final
end

[:d1,:d2].each do |final|
  thx_voice final
  thx_voice final
end
