use_bpm 140

# Synths, Timbre and Filters Part 8
# By Adrian Cheater

# In our last example we worked with the :noise synth, which is also known as 'white noise'
# All noise sounds static-y, but the different noise generators work differently, and so
# sound differently.

# :cnoise and :noise both keep the strength of the noise roughly constant across
# all frequencies, :gnoise genrates noise that favours the bass range, but can
# still be pretty loud across the spectrum.
# :pnoise and :bnoise work like they have builtin low pass filters, but the sound
# energy drops by -3 and -6 dB per octave, so it creates a less harsh sound
# with :bnoise having more standout bass than :pnoise

synths = [:cnoise,:noise,:gnoise,:pnoise,:bnoise]

synths.each do |synth|
  puts "This is #{synth}"
  use_synth synth
  play :c4, sustain: 6, attack: 0.1, release: 0.1
  sleep 7.0
end