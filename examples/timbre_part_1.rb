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
compare_synths

# If the different synths have different Timbre, then this means they must involve different kinds
# of harmonics. In the next example, we'll look more closely at those different synths and how it
# is that they get their Timbre.
