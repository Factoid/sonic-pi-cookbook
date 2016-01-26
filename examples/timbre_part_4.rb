use_bpm 140

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
lpf_sine

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
hpf_sine

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
bpf_sine

# So now that we understand how filters can be used to remove frequencies, let's see what happens when we use them
# with our harmonically rich synths.