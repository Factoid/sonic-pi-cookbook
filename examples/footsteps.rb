use_bpm 60
live_loop :curve do
  with_fx :hpf, cutoff: [40,60,80].choose do
    synth :cnoise, attack: 0.02, release: 0.01, decay: 0.02, sustain: 0.03, sustain_level: 0.1, env_curve: 6
    sleep 0.5
  end
end