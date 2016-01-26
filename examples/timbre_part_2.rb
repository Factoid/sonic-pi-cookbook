use_bpm 140

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
add_sine

# When you listen to it, it's adding random harmonics at diminishing strengths
# Even though the fundamental :c2 is the loudest single waveform, you can hear
# how the timbre and sometimes even the perceived pitch changes as more waves
# are introduced. Next time we'll look at some other waves that aren't produced
# with additive synthisys, but who's shape contains many harmonics within them.

