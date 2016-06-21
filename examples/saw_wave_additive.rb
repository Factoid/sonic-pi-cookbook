use_synth :saw
play 60, amp: 1, pan: -1, attack: 0, release: 0, sustain: 1
play 60, amp: 1, pan: 1, attack: 0, release: 0, sustain: 1

sleep 1
20.times do |j|
  use_synth :saw
  play 60, amp: 1, pan: -1, attack: 0, release: 0, sustain: 0.25
  use_synth :beep
  (j+1).times do |i|
    hz = midi_to_hz(60)*(i+1.0)
    puts hz
    play hz_to_midi(hz), amp: 0.5/(i+1), pan: 1, attack: 0, release: 0, sustain: 0.25
  end
  sleep 0.25
end

sleep 1

use_synth :saw
play 60, amp: 1, pan: -1, attack: 0, release: 0, sustain: 2
use_synth :beep
20.times do |i|
  hz = midi_to_hz(60)*(i+1.0)
  puts hz
  play hz_to_midi(hz), amp: 0.5/(i+1), pan: 1, attack: 0, release: 0, sustain: 2
end