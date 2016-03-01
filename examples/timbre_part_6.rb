use_bpm 140

# Synths, Timbre and Filters Part 6
# By Adrian Cheater

# We've now seen how various wave forms can be rich in harmonics, and how the low, high,
# and band pass filters can affect them. Is there anything else we can do with filters?

# As a matter of fact, there is! We've seen how filters reduce the sound energy the
# farther you get from the cutoff or centre. However, we can also boost the sound energy
# at that cutoff. This boosting is what we call resonance, and it's affected by the res
# parameter of the resonating filters

# In this case, we're cranking the resonance to a very high level, and using a normalizing
# filter to help accentuate the resonated frequency. With this high level of resonance,
# you can actually hear the sweep of the filter's cutoff as a secondary frequency.
# You can still mostly hear the fundamental frequency we generated, but now there's a
# sine like whistle present as well. We call these extra frequencies which stand out
# "overtones"

# Again, even though the cutoff value is resonated into an overtone, the signal is
# still heavily reduced, so normalizing it will help to bring the sound out.
# However, it's also useful to note that when not normalizing the signal, the sweep
# overtone is more consistent with the c2 note, vs the c6 note, which fades in and out.
# Also, the lower tones fade in and out more times. What's going on there?

# Remember, the resonator can only amplify the amount of sound present at a given frequency
# In the case of saw waves, we get all the harmonics, but those harmonics are still multiples
# of the fundamental frequency. Inbetween those harmonics, there isn't any sound energy to
# multiply, so the overtone drops out, and you go back to hearing the fundamental frquency.

# So what would happen if we could play a sound that had every frequency?
# What would that sound like? We'll explore that next time.

define :sweep_filter do |n,f|
  puts "Playing #{n} with filter #{f}"
  use_synth :saw
  play n, sustain: 4
  sleep 6

  with_fx f, cutoff: :c1, res: 0.99, cutoff_slide: 16 do |fx|
    play n, sustain: 16
    control fx, cutoff: :c7
  end
  sleep 17
end

define :bpf_sweep do |n,f|
  puts "Playing #{n} with filter #{f}"
  use_synth :saw
  play n, sustain: 4
  sleep 6

  with_fx f, centre: :c1, res: 0.99, centre_slide: 16 do |fx|
    play n, sustain: 16
    control fx, centre: :c7
  end
  sleep 17
end

with_fx :normaliser do
  [:c4,:c6,:c2].each do |note|
    [:rlpf,:rhpf].each do |filter|
      sweep_filter note,filter
    end
    bpf_sweep note, :rbpf
  end
end