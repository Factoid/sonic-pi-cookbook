use_bpm 150

define :sq1 do
  use_synth :chiplead
  use_synth_defaults attack: 0, release: 0, sustain: 0.5
  play_pattern_timed [:e5,:e5,:r,:e5,:r,:c5,:e5,:r,:g5,:r,:r,:r,:r,:r,:r,:r,:r], 0.5
end

define :sq2 do
  use_synth :chiplead
  use_synth_defaults attack: 0, release: 0, sustain: 0.5
  play_pattern_timed [:fs,:fs,:r,:fs,:r,:fs,:fs,:r,:b,:r,:r,:r,:g,:r,:r,:r], 0.5
end

define :t1 do
  use_synth :chipbass
  use_synth_defaults attack: 0, release: 0, sustain: 0.5
  play_pattern_timed [:d4,:d4,:r,:d4,:r,:d4,:d4,:r,:g,:r,:r,:r,:g3,:r,:r,:r], 0.5
end

in_thread do
  sq1
end
in_thread do
  sq2
end
in_thread do
  t1
end