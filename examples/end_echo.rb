delay = 2
echoes = 10
sample :loop_amen, beat_stretch: delay, finish: 6.0/8.0
sleep delay*6.0/8.0
with_fx :echo, phase: delay*0.15, decay: echoes*delay*0.15 do
  sample :loop_amen, beat_stretch: delay, start: 6.0/8.0, finish: 7.0/8.0
end