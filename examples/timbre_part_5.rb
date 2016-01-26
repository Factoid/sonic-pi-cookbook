use_bpm 140

# Synths, Timbre and Filters Part 5
# By Adrian Cheater

# As we've seen in previous examples, the saw, triangle, and square waves are rich
# with harmonics. And we've also seen that filters reduce the strength of frequencies
# which are too far above, below, or outside the selected frequency of the
# low, high, and band pass filters. So let's take a moment to listen to how
# the timbre of a saw wave changes when we sweep these filters.

# We can hear that the timbre changes as the filter sweeps, and that they all sound
# a little different from the raw saw wave. One noticable problem however, is that the
# notes which are very far from the cutoff or centre are barely audible.

# If we wanted to hear those timbres a little more clearly, we could normalize
# the signal, so that after it's been filtered, it gets amplified as much as needed
# to bring the relative volume up to fill the 'normal' range of dynamics.

# Try changing the :lpf to :nlpf, :hpf to :nhpf, and :bpf to :nbpf and hear how that
# sounds. (NOTE: :nbpf seems to not work)

define :sweep_filter do |n,f|
  puts "Playing #{n} with filter #{f}"
  use_synth :saw
  play n, sustain: 4
  sleep 6

  with_fx f, cutoff: :c1, cutoff_slide: 16 do |fx|
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

  with_fx f, centre: :c1, centre_slide: 16 do |fx|
    play n, sustain: 16
    control fx, centre: :c7
  end
  sleep 17
end

[:c4,:c6,:c2].each do |note|
  [:lpf,:hpf].each do |filter|
    sweep_filter note,filter
  end
  bpf_sweep note, :bpf
end