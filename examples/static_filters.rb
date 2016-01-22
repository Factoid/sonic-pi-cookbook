use_bpm 140

# Synths, Timbre and Filters Part 1
# By Adrian Cheater
#
# This series of code snippets are meant to demonstrate the effect of filters on different synths
# in order to help better understand how different kinds of sound are produced.
#
# What is Timbre?
# Timbre is the name we give to the way a sound 'sounds'. Different instruments, even when playing
# the same note, sound different. This is why we can tell a trumpet from a piano or guitar.
#
# But how is Timbre produced?
# Timbre is made when different amounts of harmonics are played along with the main note.
# The main note, or 'fundamental frequency' is what we pass to the play function, like :c4
# Harmonics are multiples of that fundamental frequency. So for example, the note :a3 is 110 Hertz (Hz)
# That means that the wave shape we're using gets repeated 110 times per second. The harmonics
# of :a3 are then found at 220, 330, 440, 550, 660, 770... Hz.
# It is the use of some or all those harmonics that change how we perceive the timbre of the sound.
#
# In sonic pi, the building blocks of most sounds or synths are the sine, square, saw, and triangle waves.
# Each of them have a different timbre which you can hear when the same note is played switching between the
# different synths in 'compare_synths'

define :compare_synths do
  3.times do
    %i(sine saw square tri).each do |synth|
      use_synth synth
      play :c2
      sleep 1.0
    end
  end
end
compare_synths

# If the different synths have different Timbre, then this means they must involve different kinds
# of harmonics. In the next example, we'll look more closely at those different synths and how it
# is that they get their Timbre.



# Synths, Timbre and Filters Part 2
# By Adrian Cheater
#
# From the last example, we saw there are 4 kinds of waveforms that are used in almost all synths.
# They are the sine, sawtooth, square, and triangular wave, each with their own sound.
# But there's something special about the sine wave, and its relationship with the others.
#
# Sine waves
# The documentation for Sonic Pi talks about sine synths as being 'pure' notes.
# But what does that mean? It means that the wave form doesn't have any harmonics built into it.
#
#
#
#
#
#
# The program simply loops through the same 3 octave c-major apegio with each of the fundamental
# wave forms (sine, saw, square, and triangle), and using the low, high, and band pass filters.
# Give the program a listen a few times, and then continue reading
#
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
# So when you play a note like :c1 with a saw, you also get all the multiples of :c1 included, which takes
# a lot of harmonics before the two start to sound the same.
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
  use_synth_defaults attack: 0.01, release: 0.01, sustain: 0.9
  (10..200).step(10) do |t|
    use_synth :saw
    play :c2
    sleep 1.0
    use_synth :sine
    note = midi_to_hz(:c2)
    (1..t).each do |i|
      play hz_to_midi(note*i), amp: 1.0/i.to_f
    end
    sleep 1.0
  end
end

define :square_vs_sine do
  use_synth_defaults attack: 0.01, release: 0.01, sustain: 0.9
  (10..200).step(10) do |t|
    use_synth :square
    play :c2
    sleep 1.0
    use_synth :sine
    note = midi_to_hz(:c2)
    (1..t).step(2) do |i|
      play hz_to_midi(note*i), amp: 1.0/i.to_f
    end
    sleep 1.0
  end
end

define :tri_vs_sine do
  use_synth_defaults attack: 0.01, release: 0.01, sustain: 0.9
  (10..200).step(10) do |t|
    use_synth :tri
    play :c2
    sleep 1.0
    use_synth :sine
    note = midi_to_hz(:c2)
    (1..t).step(2) do |i|
      #sign = i%4 == 0 ? 1.0 : -1.0
      unless i % 4 == 0
        play hz_to_midi(note*i), amp: 1.0/(i*i).to_f
      else
        in_thread do
          sleep (note*i/2)
          play hz_to_midi(note*i), amp: 1.0/(i*i).to_f
        end
      end
    end
    sleep 1.0
  end
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

#square_vs_sine
#saw_vs_sine
#tri_vs_sine

#%i(sine saw square tri).each do |synth|
#  next unless do_it[synth]
#  puts "Using synth #{synth}"
#  use_synth synth
#  do_filters
#end