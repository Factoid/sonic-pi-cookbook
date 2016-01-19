#Bits and Bytes theme
use_bpm 54

puts Chord::CHORD

uncomment do
  in_thread name: :rchords do
    use_synth :saw
    use_synth_defaults release: 0.25, amp: 0.75
    8.times do
      play_chord chord(:e, :sus4)
      sleep 0.25
    end
    2.times do
      8.times do
        play_chord chord(:e, :major)
        sleep 0.25
      end
      12.times do
        play_chord chord(:d, :major)
        sleep 0.25
      end
      4.times do
        play_chord chord(:a, :major)
        sleep 0.25
      end
      8.times do
        play_chord chord(:e, :major)
        sleep 0.25
      end
    end
    8.times do
      play_chord chord(:e, :major)
      sleep 0.25
    end
    8.times do
      play_chord chord(:a, :major)
      sleep 0.25
    end
    8.times do
      play_chord chord(:e, :major)
      sleep 0.25
    end
    4.times do
      play_chord chord(:d, :major)
      sleep 0.25
    end
    4.times do
      play_chord chord(:a3, :major)
      sleep 0.25
    end
    8.times do
      play_chord chord(:e, :major)
      sleep 0.25
    end
    8.times do
      play_chord chord(:a, :major)
      sleep 0.25
    end
    8.times do
      play_chord chord(:e, :major)
      sleep 0.25
    end
    8.times do
      play_chord chord(:d, :major)
      sleep 0.25
    end
    8.times do
      play_chord chord(:a3, :major)
      sleep 0.25
    end
    16.times do
      play_chord chord(:e, :major)
      sleep 0.25
    end
  end
end

uncomment do
  sleep 3.0
  in_thread name: :melody do
    use_synth :square
    use_transpose 4
    use_synth_defaults release: 0.5
    2.times do |x|
      puts x
      patterns = [[:c,:d,:e,nil,:f,nil],[:f,:f,:f,:g,:a,:g,nil]]
      timings = [knit(0.25,4,0.25,1,2.25,1),knit(0.25,4,0.5,2,2.5,1)]
      play_pattern_timed patterns[x], timings[x].to_a
    end
    play_pattern_timed [:c,:d,:e,nil,:f,nil], knit(0.25,4,0.25,1,2.25,1).to_a
    play_pattern_timed [:f,:f,:f,:g,:a,:a,nil,:g,:g,nil], knit(0.25,4,0.5,2,0.25,2,1.75,1).to_a

    sleep 1.0
    play_pattern_timed [:a,:a,:a,:a,:g,:e], knit(0.25,1,0.5,1,1.0,1,0.25,1).to_a
    sleep 1.25
    play_pattern_timed [:d,:d,:d,:c,:e], knit(0.25,1,0.75,1,0.5,1,0.25,1).to_a
    sleep 2.0
    play_pattern_timed [:a,:a,:a,:a,:c5,:g,:e,:c], [0.25,0.5,1.0,0.25,0.5,0.25,0.5,0.75]
    play_pattern_timed [:d,:d,:d,:c,:c,:g], knit(1.5,1,0.5,2,1.0,1,0.5,1).to_a
  end
end

uncomment do
  in_thread name: :ooohs do
    use_synth :tri
    use_transpose 4
    use_synth_defaults release: 1.0, attack: 0.25, amp: 0.5
    sleep 16
    play :c
    sleep 0.5
    play :g
    sleep 0.5
    play :c5, sustain: 6
    sleep 7
    play :c
    sleep 0.5
    play :g
    sleep 0.5
    play :c5, sustain: 6
  end
end

comment do
  in_thread name: :bass do
    use_synth :dull_bell
    play :c3
    sleep 1.0
  end
end

uncomment do
  in_thread name: :warble do
    2.times do
      puts "loop warble"
      sleep 1.0
      use_transpose 2
      use_synth :saw
      use_synth_defaults release: 0.125
      play_pattern_timed [:c3,:d3,:c3,:d3,:c3,nil], knit(0.125,5,0.75-0.375,1).to_a
      with_transpose 14 do
        play_pattern_timed [:c3,:d3,:c3,:d3,:c3,nil], knit(0.125,5,0.75-0.375,1).to_a
      end
      sleep 2.0
      use_transpose 4
      play_pattern_timed [:c3,:d3,:c3,:d3,:c3,nil], knit(0.125,5,0.75-0.375,1).to_a
      with_transpose 16 do
        play_pattern_timed [:c3,:d3,:c3,:d3,:c3,nil], knit(0.125,5,0.75-0.375,1).to_a
      end
      play_pattern_timed [:c3,:d3,:c3,:d3,:c3,nil], knit(0.125,5,0.75-0.375,1).to_a
    end
    puts "bridge"
    sleep 32
  end
end

uncomment do
  sleep 1.0
  live_loop :beat do |x|
    sample :drum_heavy_kick, amp: 0.5
    sleep 0.5
    sample :drum_snare_hard, amp: 0.4
    sleep 0.5
  end
end