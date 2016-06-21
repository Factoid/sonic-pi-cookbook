last_note = nil
define :bass do |n,d|
  with_bpm 60 do
    with_fx :rhpf, cutoff: 40 do
      with_fx :rlpf, cutoff: 120, res: 0.5 do |fx|
        with_octave -3 do
          unless n == :r
            last_note ||= n
            s = synth :saw, note: last_note, attack: 0.1, sustain: d, release: 0.2
            control s, note: n, note_slide: 0.15
            with_cent_tuning 4 do
              s2 = synth :square, attack: 0.1, note: last_note, sustain: d, release: 0.2
              control s2, note: n, note_slide: 0.15
            end
            last_note = n;
          else
            last_note = nil;
          end
        end
        at [d] do
          control fx, cutoff: 80, cutoff_slide: 0.2
        end
      end
    end
  end
end

live_loop :funk do
  at [1, 1.5, 1.75, 2, 2.25, 2.5, 2.75] do |d,i|
    puts i
    bass [:e,:c5,:e,:d,:e,:c,:d,:e][i], 0.25
  end
  sleep 2
end
