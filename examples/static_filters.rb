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
  4.times do
    %i(sine saw square tri).each do |synth|
      use_synth synth
      play :c2
      sleep 1.0
    end
  end
end
#compare_synths

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
# But what does that mean? It means that the wave form doesn't have any harmonics included.
# What is a harmonic? A harmonic is a multiple of the frequency of the note you're trying to play.
# That note is the value you pass to the play commands, and is also known as the 'fundamental frequency'
# Harmonics are always higher frequency (higher pitched) versions of wave.
#
# So when you play a note with a sine synth, you are only hearing that fundamental frequency, nothing else.
# All other waves can be made by mixing together several sine waves at different frequencies and strengths,
# and each new sine wave added into the mix will change the note's timbre.
# When you're trying to create a new sound by playing several sine waves at the same time, that's called
# "Additive Synthisys", and is one way to make things sound new. Here's an example.

define :add_sine do
  use_synth :sine

  10.times do |i|
    use_random_seed 37
    base_freq = midi_to_hz(:c2)
    notes = range(2,11).shuffle

    play hz_to_midi(base_freq), sustain: 1.0, amp: 1.0
    i.times do |j|
      play hz_to_midi(base_freq*notes[j]), amp: 1.0/(j+2), sustain: 1.0, release: 0.1
    end
    sleep 1.5
  end
end
#add_sine

# When you listen to it, it's adding random harmonics at diminishing strengths
# Even though the fundamental :c2 is the loudest single waveform, you can hear
# how the timbre and sometimes even the perceived pitch changes as more waves
# are introduced. Next time we'll look at some other waves that aren't produced
# with additive synthisys, but who's shape contains many harmonics within them.


# Synths, Timbre and Filters Part 3
# By Adrian Cheater
#
# Saw, Square, and Triangle waves
# We've listened to the sound of single sine wave, and how adding multiple harmonics
# together can change the timbre of a sound. But what about these other basic
# synths? They are named for the shapes of their wave forms, and compared to the
# smooth curvy shape of a sine wave, they look like they're much easier to generate.
# But there's something very cool going on with those waveforms.
#
# While they're not actually made up of a bunch of sine waves, we can get very close to
# re-creating their shape if we add up sine waves in certain patterns. Have a listen.

define :saw_vs_sine do
  use_synth_defaults attack: 0.01, release: 0.01, sustain: 0.7
  (10..120).step(5) do |t|
    puts "With #{t} sine waves"
    use_synth :saw
    play :c2
    sleep 0.7
    use_synth :sine
    note = midi_to_hz(:c2)
    (1..t).each do |i|
      play hz_to_midi(note*i), amp: 1.0/i.to_f
    end
    sleep 0.7
  end
end
#saw_vs_sine

# You might notice that around 100 or so sine waves in, the two wave forms might start to sound nearly or
# entirely identical. We can keep playing more and more sine waves until they are inperceptively different
# to the average person. But what does it mean if they sound the same?
#
# It means that the saw wave, while simple, sounds to our ears as if it is made up of hundreads of harmonics.
# It is full of them, following a very specific pattern. A saw wave can be though of containing every
# harmonic (multiple) of the fundamental (starting) frequency, with the volume decreasing as the harmonic
# increases. So if you're playing a 220 Hz tone (:a3), at full volume, you also get 440 Hz at half volume,
# 660 Hz at 1/3 volume, 880 Hz at 1/4, 1100 Hz at 1/5, etc... all for free, it's very easy for sonic pi
# to give you a lot of harmonics without a lot of work this way.

# Square waves are similar, have a listen

define :square_vs_sine do
  use_synth_defaults attack: 0.01, release: 0.01, sustain: 0.7
  (10..120).step(5) do |t|
    puts "Using #{t} sine waves"
    use_synth :square
    play :c2
    sleep 0.7
    use_synth :sine
    note = midi_to_hz(:c2)
    (1..t).step(2) do |i|
      play hz_to_midi(note*i), amp: 1.0/i.to_f
    end
    sleep 0.7
  end
end
#square_vs_sine

# Same system as the saw wave, but a different pattern, this time we're only using every other harmonic. 220 Hz,
# 660 Hz, 1100 Hz, etc..

# And for triangle waves

define :tri_vs_sine do
  use_synth_defaults attack: 0.01, release: 0.01, sustain: 0.7
  (10..80).step(5) do |t|
    puts "With #{t} sine waves"
    use_synth :tri
    play :c2
    sleep 0.7
    use_synth :sine
    note = midi_to_hz(:c2)
    (1..t).step(2) do |i|
      unless i % 4 == 0
        play hz_to_midi(note*i), amp: 1.0/(i*i).to_f
      else
        in_thread do
          sleep 2.0/(note*i)
          play hz_to_midi(note*i), amp: 1.0/(i*i).to_f
        end
      end
    end
    sleep 0.7
  end
end
#tri_vs_sine

# With triangle waves we don't need as many sine waves to get close to the same sound. The reason
# for this is because the volume of each harmonic drops by the square of its value, so by the time
# you're 10 harmonics in, you're already at 100th of the volume. Like square waves, we only use the
# odd harmonics, but we also do something else, each 4th harmonic we have to play half way out
# of phase, we do this by waiting half the wavelength (2.0/frequency) which causes the wave to move
# in the opposite direction, we could also use a "cosine" waveform, if it existed, without needing to
# sleep.

# So sonic pi gives us 4 basic wave forms to work with, sine, saw, square, and triangle, and we can see
# that the next three contain a great number of harmonics. So is there a way that we can create new
# timbres from the saw, square, and triangle waves? As a matter of fact, there is. We use filters to
# remove some of the harmonics to change the sound, rather than adding more sine waves.
# Since we're taking harmonics away from the harmonically rich sounds of these synths, we call this
# kind of synthesis, "Subtractive Synthesis"




# Synths, Timbre and Filters Part 4
# By Adrian Cheater

# So now we've seen how sine waves are the building blocks of sound. That we can create new timbres
# by adding multiple sine waves together at the same time, and that the other basic wave forms
# (Saw, Square, and Triangle) are effectively full of harmonics.
#
# If we want to remove harmonics, then we need to filter them out. In sonic pi, there are three
# kinds of filters we can use, one filters out frequencies below a chosen point,
# one filters out frequencies above a chosen point, and the 3rd filters out frequencies that are
# too far above or below a chosen point.

# In the case of the one that cuts out the frequencies below a chosen point, it can also be
# said to allow frequencies above a certain point to pass through without adjustment. You can
# therefore call it a low-cut, or a high-pass filter (sonic pi uses the latter)

# So our other two filters are called a low-pass (high-cut) filter, and a band-pass filter.
# That last one might sound a bit funny. When talking about frequencies, a "band" is just a range of
# frequencies between two points, so from (:c3 to :c4) is a one octave band.

# To see what exactly a filter does, let's try it out on our sine wave, there are no harmonics, so
# it will help us to really hear what's going on.

define :lpf_sine do
  use_synth :sine
  n = play :a3, note_slide: 8, sustain: 10
  control n, note: :a4
  sleep 10.5
  with_fx :lpf, cutoff: :a3 do
    n = play :a3, note_slide: 8, sustain: 10
    control n, note: :a4
  end
  sleep 10.5
end
#lpf_sine

# Did you notice how the volume got quieter as the note swept up, away from the low pass filter's cutoff of :a3?
# That's because a low-pass filter is also a high-cut filter. So the higher the frequency is from the cutoff, the
# quieter it gets. High-pass filters do the same thing.

define :hpf_sine do
  use_synth :sine
  n = play :a3, note_slide: 8, sustain: 10
  control n, note: :a4
  sleep 10.5
  with_fx :hpf, cutoff: :a4 do
    n = play :a3, note_slide: 8, sustain: 10
    control n, note: :a4
  end
  sleep 10.5
end
#hpf_sine

# This time the filtered note started quieter and got louder as it approached the cutoff. After that point it
# continues at full volume. And of course, band pass filters will make the sound quieter the farther it gets from
# it's centre point (above or below). It's important to point out that whereas the lpf and hpf filters have a 'cutoff'
# that controls the filter, the band pass filter has a 'centre' frequency that is loudest.

define :bpf_sine do
  use_synth :sine
  n = play :c1, note_slide: 8, sustain: 10
  control n, note: :c5
  sleep 10.5
  with_fx :bpf, centre: :c3 do
    n = play :c1, note_slide: 8, sustain: 10
    control n, note: :c5
  end
  sleep 10.5
end
#bpf_sine

# So now that we understand how filters can be used to remove frequencies, let's see what happens when we use them
# with our harmonically rich synths.

# Synths, Timbre and Filters Part 5
# By Adrian Cheater

define :lpf_saw do
  use_synth :saw
  play :c4, sustain: 5
  sleep 6

  with_fx :lpf, cutoff: :c1, cutoff_slide: 8 do |fx|
    play :c4, sustain: 9
    control fx, cutoff: :c7
  end
  sleep 10.5
end
#lpf_saw

define :hpf_saw do
  use_synth :saw
  play :c4, sustain: 5
  sleep 6

  with_fx :hpf, cutoff: :c1, cutoff_slide: 8 do |fx|
    play :c4, sustain: 9
    control fx, cutoff: :c7
  end
  sleep 10.5
end
#hpf_saw

define :bpf_saw do
  use_synth :saw
  play :c4, sustain: 5
  sleep 6

  with_fx :bpf, centre: :c1, centre_slide: 8 do |fx|
    play :c4, sustain: 9
    control fx, centre: :c7
  end
  sleep 10.5
end
bpf_saw

# The program simply loops through the same 3 octave c-major apegio with each of the fundamental
# wave forms (sine, saw, square, and triangle), and using the low, high, and band pass filters.
# Give the program a listen a few times, and then continue reading
#
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