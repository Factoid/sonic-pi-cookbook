use_bpm 140

live_loop :kick do
  2.times do
    sample :drum_bass_soft, rate: 1.05
    sleep 1.0
    sample :drum_snare_soft, pan: -0.3, rate: rrand(0.9,1.1)
    sleep 1.0
    2.times { sample :drum_bass_soft; sleep 0.5 }
    sample :drum_snare_soft, pan: -0.3, rate: rrand(0.9,1.1)
    sleep 1.0
  end
end

live_loop :hat do
  use_sample_defaults amp: 0.6, pan: 0.5
  sync :kick
  15.times do
    sample :drum_cymbal_closed
    sleep 0.5
  end
  sample :drum_cymbal_hard, rate: rrand(0.95,1.05), start: 0.1, finish: 0.25
  sleep 0.5
end

chords = knit(
  chord( :F, '6' ), 3,
  [nil], 1,
  chord( :C, '6' ), 3,
  [nil], 1,
  chord( :D, :m7 ), 4,
  chord( :G, :sus4 ), 3,
  chord( :G, :M ), 1
)

live_loop :chords do
  with_fx :panslicer, phase: 0.5, mix: 1, wave: 3 do
    with_fx :ixi_techno do
      use_synth :subpulse
      use_transpose -12
      sync :kick
      chords.each do |c|
        play_chord c, sustain: 1, attack: 0.1, release: 0.1, amp: 1
        sleep 1.0
      end
    end
  end
end

live_loop :bass do
  use_synth :tb303
  use_synth_defaults res: 0.2, sustain: 0.5, attack: 0.01, release: 0.5
  use_transpose -24
  sync :chords
  with_fx :bitcrusher, sample_rate: 400, bits: 4, sample_rate_slide_shape: 1, sample_rate_slide: 8, bits_slide: 8 do |f|
    control f, sample_rate: 4000
    1.times {
      knit(:d,2,:f,1,:es,1,:d,2,:e,1,:f,2,:g,1,:d,1,:c,1,:d,2).each do |n|
        play n
        sleep knit(2.0,1,0.5,3,1.0,3,0.5,2).tick
      end
    }
  end
end

def play_pattern_timed_smooth( notes, times, opts = {})
  time_ring = times.ring
  notes.each_with_index do |note,i|
    dur = time_ring[i]
    play note, opts.merge(sustain: dur)
    sleep dur
  end
end

comment do
  live_loop :melody do
    use_synth :saw
    use_synth_defaults attack: 0.05, release: 0.1, amp: 0.5
    sync :chords
    play_pattern_timed_smooth [:a,:g,:f,:e,nil,:g,:f,:e,:d], [2.5,0.5,0.5,0.5,4,2.5,0.5,0.5,0.5], current_synth_defaults
  end
end