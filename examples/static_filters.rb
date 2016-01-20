use_bpm 140

# Filters and Timbre Part 1
# By Adrian Cheater
#
# This series of code snippets are meant to demonstrate the effect of filters on different synths
# in order to help better understand how different kinds of sound are produced.
#
# The program simply loops through the same 3 octave c-major apegio with each of the fundamental
# wave forms (sine, saw, square, and triangle), and using the low, high, and band pass filters.
# Give the program a listen a few times, and then continue reading
#
# Sine waves
# The documentation for Sonic Pi talks about sine synths as being 'pure' notes.
# But what does that mean? It means that the wave form doesn't have any harmonics built into it.
#
# What is a harmonic? A harmonic is a multiple of the note you're trying to play.
# That note is the value you pass to the play commands, and is also known as the 'fundamental frequency'
# Harmonics are always higher frequency (higher pitched) versions of wave.
# So when you play a note with a sine synth, you are only hearing that fundamental frequency, nothing else.
#
# When you combine the harmonics of a sine wave, different shapes start to take form.
# While sonic pi isn't making those waveforms by adding sine waves together, the fact that
# these waves can be made by combining harmonics means that to our ears, all those different
# frequencies are present.
#
# It's addition of harmonics of various strenghts which give an instrument its characteristic sound,
# also known as its 'timbre'
#
# Filters
# Filters can help us change the timbre of a sound by reducing or removing frequencies from a wave form
# Commonly these filters either allow frequencies above, below, or around a certain frequency of our
# choosing. They allow those frequencies to pass, while the others are reduced or eliminated (also
# called 'attenuation'). So those filters are usually named "High pass", "Low pass", or "Band pass".
# That last one because a range of frequencies (for example, from :c to :e) is called a 'band'.
#
# Filtering pure sine waves aren't that interesting, because there's just the one frequency present
# (again, that's what we meant when we said they were 'pure'). So all that means is the more the filter
# is filtering, the quieter the sound will get.
# When you listen to the sine wave with the high, low, and band pass filters, you'll notice that
# the loudness of the note goes up as the note we're playing approaches the high pass filter's cutoff,
# goes down as the note moves away from the low pass cutoff, and goes up and down as it approaches
# and then passes the centre of the band pass filter.
#
# So what happens with other waves?
#
# Saw waves
# Saw waves are fun to play with, because they contain all the harmonics of their fundamental frequency.
# So when you play a note like :c1 with a saw, you also get all the multiples of :c1 included in a way
# that you can't simply by asking sonic pi to play all of them at once. Listen to saw_vs_sine and
# you can see that they're close, but not quite.
#
# But now we have all these extra frequencies present in our sound, which means the filters have a
# lot more to work with. Whereas you heard the volume of the sine synth change as it moves, the
# saw synth is also has its timbre change along with the volume.
#
# Square waves
# Square waves are like saw waves, but only include the odd multiples of the fundamental frequency
#
# Triangle waves
# Triangle waves use a much more complicated combination of sine waves. They use only odd harmonics,
# like square waves, but also invert the wave periodically.
#
# The important thing to remember is that most synths except pure :sine synths contain harmonics
# which means they can be shaped by the use of filters.

do_it = { sine: true, saw: true, square: true, tri: true, hpf: true, lpf: true, bpf: true }
define :do_scale do
  play_pattern_timed chord( :c3, :major, num_octaves: 3 ), 1
end

define :saw_vs_sine do
  use_synth :saw
  play :c1, sustain: 1.0
  sleep 2.0
  use_synth :sine
  note = midi_to_hz(:c1)
  (1..100).each do |i|
    play hz_to_midi(note*i), sustain: 1.0, amp: 1.0/i.to_f
  end
  sleep 2.0
end

define :do_filters do
  puts "Scale"
  do_scale
  if do_it[:hpf]
    puts "Scale with high pass filter"
    with_fx :hpf, cutoff: :c6 do
      do_scale
    end
  end
  if do_it[:lpf]
    puts "Scale with low pass filter"
    with_fx :lpf, cutoff: :c3 do
      do_scale
    end
  end
  if do_it[:bpf]
    puts "Scale with band pass filter"
    with_fx :bpf, centre: :c4 do
      do_scale
    end
  end
end

#saw_vs_sine
%i(sine saw square tri).each do |synth|
  next unless do_it[synth]
  puts "Using synth #{synth}"
  use_synth synth
  do_filters
end