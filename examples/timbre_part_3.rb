use_bpm 140

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
saw_vs_sine

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
square_vs_sine

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
tri_vs_sine

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
