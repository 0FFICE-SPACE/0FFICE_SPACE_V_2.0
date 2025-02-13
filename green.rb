use_bpm 160

define :d_42floor do |x|
  live_loop :floor do
    sample :bd_haus, amp: 1.1
    sleep 0.5
    sample :hat_snap, amp: 1.2
    sleep 0.5
  end
  
end

define :d_piano_lead do |x, a|
  with_fx :reverb, room: 0.8 do
    live_loop  :piano_lead do
      use_synth :piano
      use_synth_defaults stero_width: 1, vel: 0.2
      play x + 16, release: 0.7
      sleep a
      play (chord x+24, :major7), release: 1
      sleep a*2
      play x + 16, release: 0.7
      sleep a
      play (chord x+24, :major7), release: 1
      sleep a*2
      density 2 do
        play x + 16, release: 0.7
        sleep a
        play (chord x+24, :major7), release: 1
        sleep a*2
      end
    end
  end
end

define :d_rave_lead do |x|
  with_fx :reverb, room: 0.8 do
    use_synth :tb303
    live_loop :squelch do
      n = x +31
      play (chord n,:major7).tick, release: 0.125, cutoff: 100, res: 0.8, wave: 0, amp: rdist(0.2,0.6), pan: rdist(1,0)
      sleep 0.25
    end
  end
end

/main/
live_loop :main do
  x = [:E1,:D1,:C1,:A1].tick  #change this chord progression
  a = [0.5,0.5].choose
  d_42floor x
  sleep 4
  d_rave_lead x
  d_piano_lead x, a
end
