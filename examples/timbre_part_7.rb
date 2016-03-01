use_bpm 140
use_synth :noise

# Synths, Timbre and Filters Part 7
# By Adrian Cheater

# When you generate sound that contains energy at every frequency, not just a fundamenal and it's harmonics
# you get what we call noise. There is no pitch for your ears to pick out, there're all present.
# The downside is that you can't control pitch, every note with a noise generator sounds the same
# The upside is that you have a very rich environment for subtractive synthasis. Liberal use of
# resonance in this case can provide your fundamental frequency for you.

# We start by playing three notes in rapid succession, so that you can hear they don't sound any different.
# Then we do our filter sweep, and now you don't get that pusling effect you had with the saw waves.
# However, this is also a place where the nature of low, high, and band pass filters really become apparent.
# The rlpf filter keeps most of the noise out until the frequency climbs
# Similarly, the rhpf keeps most of the noise initially and reduces it as it sweeps.
# The rbpf has a fairly constant amount of noise present as it sweeps through the frequencies.

# This does mean that you can "play" noise using a resonant filter, as demonstrated in 'noisy_jaques'

define :sweep_filter do |n,f|
  puts "Playing #{n} with filter #{f}"
  with_fx f, cutoff: :c1, res: 0.99, cutoff_slide: 16 do |fx|
    play n, sustain: 16
    control fx, cutoff: :c7
  end
  sleep 17
end

define :bpf_sweep do |n,f|
  puts "Playing #{n} with filter #{f}"
  with_fx f, centre: :c1, res: 0.99, centre_slide: 16 do |fx|
    play n, sustain: 16
    control fx, centre: :c7
  end
  sleep 17
end

define :do_sweeps do
  [:c4,:c6,:c2].each do |note|
    puts "playing #{note}"
    play note, sustain: 2
    sleep 2.0
  end
  sweep_filter :c6,:rlpf
  sweep_filter :c6,:rhpf
  bpf_sweep :c6,:rbpf
end

define :noisy_jaques do
  notes = [:c,:d,:e,:c]*2
  with_fx :rbpf do |fx|
    notes.each do |n|
      control fx, centre: n, res: 0.95
      play :c1
      sleep 1.0
    end
  end
end

with_fx :normaliser do
  do_sweeps
  noisy_jaques
end