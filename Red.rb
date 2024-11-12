use_bpm 130

define :d_ply_beat do  |x|
  live_loop :ply_beat do
    with_synth :sc808_snare do
    play rrand_i(45, 67), amp: rand(0.8), attack: rand(0.1), attack_level: rand(0.7), release: rand(0.3) if (spread rrand_i(1, 7), 7).tick end
    sample :hat_bdu, amp: rand(1.5), release: rand if (spread rrand_i(1, 12), 12).look
    sample :bd_klub, amp: 1.2 if (spread rrand_i(1, 6), 8).look
    sleep x
  end
end

define :d_atmosphere do
  live_loop :atmosphere do
    sample :vinyl_hiss, amp: 0.85, rate: [-1,1].choose
    sleep sample_duration :vinyl_hiss
  end
end

define :d_main_melody do |x, a|
  live_loop :main_meldy do
    with_synth :dsaw do
      s = play scale(x, :major_pentatonic, num_octaves: 2).tick, release: 0.32, amp: rand(1.2)
      control s, pan: rdist(1,0) if (spread 7, 13).tick
      control s, cutoff: rdist(30,80) if (spread 3, 8).tick
    end
    sleep a
  end
end

define :d_bass do |x,a|
  
  live_loop :chords do
    with_synth :subpulse do
      play x, release: 0.32, amp: 0.9 if (spread 6, 8).tick
    end
    sleep a
  end
end



/main/
live_loop :main do
  A = [0.25, 0.25].tick # play around with these values or the bpm up top
  d_ply_beat A
  print A
  x = [:Eb2,:Ab2,:Eb2,:Db2].tick #change this chord progression
  d_main_melody x, A
  d_bass x, A
  sleep 16
end

d_atmosphere


