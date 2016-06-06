use_bpm 60

define :arppegio do |s,c|
  n=chord(s,c,num_octaves: 4)
  n+[s+48]+n.reverse[0..-2]
end

live_loop(:ff) do
  use_synth :sine
  use_synth_defaults attack: 0, release: 0.75
  with_fx :reverb do
    [[:c3,:add2],[:a2,:madd2],[:c3,:add2],[:a2,:madd2],[:a2,'m7+5'],[:b2,'m7+5'],[:af2,'M7'],[:bf2,'M7']].each do |s,c|
      play_pattern_timed (arppegio s,c), 0.25
    end
  end
end