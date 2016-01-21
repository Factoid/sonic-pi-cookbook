define :a1 do
  use_synth :pretty_bell
  p2 = [:D6,:E6,:F6,:E6,:D6]
  t2 = [1.25, 0.25, 0.25, 0.25]
  with_fx :panslicer, phase: 8.0, wave: 3 do |pan|
    with_fx :echo, phase: 0.125, max_phase: 0.25, decay: 1.0 do
      play_pattern_timed p2, t2, release: 0.33
      2.times { play_pattern_timed [:E6,:F6,:E6,:D6], 0.25, release: 0.33 }
      2.times { play_pattern_timed [:E6,:F6,:E6,:D6], 0.25, release: 0.33 }
      sleep 0.25
      play_pattern_timed [:A5,:C6], 0.5, release: 0.33
    end
  end
end

define :a2 do |a=nil|
  use_synth :pretty_bell
  with_fx :panslicer, phase: 8.0, wave: 3 do |pan|
    with_fx :echo, phase: 0.125, max_phase: 0.25, decay: 1.0 do
      p1 = [:as5,:f6,:g6,:f6,:e6,:f6]
      t2 = [0.75, 0.5, 0.25, 0.25, 0.25, 1.25]
      play_pattern_timed p1, t2, release: 0.33
      2.times do
        play_pattern_timed [:g6,:f6,:e6,:f6], 0.25, release: 0.33
      end
      2.times do
        play_pattern_timed [:g6,:f6,:e6,:f6], 0.25, release: 0.33
      end
      sleep 0.25
      play_pattern_timed [:e6,:f6,:e6,:d6], [0.5, 0.125, 0.125, 1.75], release: 0.33
      play a, release: 0.33 if a
    end
  end
end

define :a3 do |a|
  use_synth :beep
  p1 = [:D,:A,:D5,:A]
  with_fx :reverb do
    cue :start
    a.each do |x|
      x[1].times do
        with_transpose x[0] do
          play_pattern_timed p1, 0.5, release: 0.5
        end
      end
    end
  end
end

define :h1 do
  in_thread do
    2.times do
      a3 [[0,4], [-5,2]]
    end
    cue :end
  end

  2.times do
    sync :start
    a1
  end
end

define :h2 do
  in_thread do
    a3 [[-7,4], [-4,2]]
    a3 [[-7,4], [-4,1], [-5,1]]
    cue :end
  end

  sync :start
  a2
  sync :start
  a2 :c6
end

use_bpm 75
loop do
  h1
  sync :end
  h2
  sync :end
end