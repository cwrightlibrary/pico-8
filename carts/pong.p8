pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
--game loop
p_points=0
o_points=0
scored=''

function _init()
 --variables
 --graphics
 p={
  x=8,
  y=63,
  c=12,
  w=2,
  h=10,
  speed=1
 }
 o={
  x=117,
  y=63,
  c=8,
  w=2,
  h=10,
  speed=.75
 }
 ball={
  x=63,
  y=63,
  c=9,
  w=2,
  dx=.6,
  dy=flr(rnd(2))-.5,
  speed=1,
  speedup=.05
 }
 
 --court
 court_l=0
 court_r=127
 court_t=10
 court_b=127
 court_c=6
 --court center line
 line_x=63
 line_y=10
 line_length=4
 line_col=5
 --sound
 if scored=='p' then
  sfx(3)
 elseif scored=='o' then
  sfx(4)
 else
  sfx(5)
 end
end

function _draw()
 cls()
 --court
 rect(court_l,court_t,court_r,court_b,court_c)
 repeat
  line(line_x,line_y,line_x,line_y+line_length,line_col)
   line_y+=line_length*2
 until line_y>court_b
 line_y=10
 --ball
 circfill(ball.x,ball.y+1,ball.w,ball.c)
 --player
 rectfill(
  p.x,
  p.y,
  p.x+p.w,
  p.y+p.h,
  p.c)
 --opponent
 rectfill(
  o.x,
  o.y,
  o.x+o.w,
  o.y+o.h,
  o.c)
 --scores
 print(p_points,30,2,p.c)
 print(o_points,95,2,o.c)
end

function _update60()
 --player controls
 if btn(2)
 and p.y>court_t+1 then
  p.y-=p.speed
 end
 if btn(3)
 and p.y+p.h<court_b-1
 then
  p.y+=p.speed
 end
 --opponent controls
 mid_o=o.y+(o.h/2)
 
 if ball.dx>0 then
  if mid_o>ball.y
  and o.y>court_t+1 then
   o.y-=o.speed
  end
  if mid_o<ball.y
  and o.y+o.h<court_b-1 then
   o.y+=o.speed
  end
 else
  if mid_o>73 then
   o.y-=o.speed
  end
  if mid_o<53 then
   o.y+=o.speed
  end
 end
 --collide with opponent
 if ball.dx>0
 and ball.x+ball.w>=o.x
 and ball.x+ball.w<=o.x+o.w
 and ball.y>=o.y
 and ball.y+ball.w-1<=o.y+o.h-1 then
  ball.dx=-(ball.dx+ball.speedup)
  sfx(0)
 end
 --collide with player
 if ball.dx<0
 and ball.x-ball.w>=p.x
 and ball.x-ball.w<=p.x+p.w
 and ball.y+ball.w>=p.y
 and ball.y-ball.w<=p.y+p.h then
  if btn(2) then
   if ball.dy>0 then
    ball.dy=-ball.dy
    ball.dy-=ball.speedup*2
   else
    ball.dy-=ball.speedup*2
   end
  end
  if btn(3) then
   if ball.dy<0 then
    ball.dy=-ball.dy
    ball.dy+=ball.speedup*2
   else
    ball.dy+=ball.speedup*2
   end
  end
  ball.dx=-(ball.dx-ball.speedup)
  sfx(1)
 end
 --collide with court
 if ball.y+ball.w>=court_b-1
 or ball.y<=court_t+1 then
  ball.dy=-ball.dy
  sfx(2)
 end
 --score
 if ball.x>court_r then
  p_points+=1
  scored='p'
  _init()
 end
 if ball.x<court_l then
  o_points+=1
  scored='o'
  _init()
 end
 --ball movement
 ball.x+=ball.dx
 ball.y+=ball.dy
end
-->8
--player
-->8
--opponent
-->8
--ball
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
010400000b0510c0510c0510d0511d051230510000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001
000400000b0510c0510f051140511d051250510000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000400000b0510c0510c0510d0511d051230510000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010500001f0501f0501f0502b0552b0502b0502b0502b0502b0402b0402b0302b0302b0202b0202b0102b0102b0002b0002b0002b0002b0000000000000000000000000000000000000000000000000000000000
a00500000d0570d0570d0570d0470d0470d0370d0270d017000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007
01040000300552a055250551f055170550f0550605500005200551c055150550f0550b05507055030550005500005110550b05506055010550100500005000050000500005000050000500005000050000500005
