pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
function _init()
 p={}
 p.x1=5
 p.y1=5
 p.x2=9
 p.y2=16
 p.col=12
 p.speed=3

 ball={}
 ball.x=64
 ball.y=64
 ball.r=2
 ball.col=8
 ball.speed=2
 ball.rand_dir_x=rnd(1)-1
 ball.rand_dir_y=rnd(1)-1
 ball.dx=0
 ball.dy=0
 ball.max_speed_x=2
 ball.max_speed_y=2
 ball.acc=.5
end

function _update()
 p_update()
 ball_update()
 collision_update()
end

function p_update()
 --player input
 if btn(2) then
  p.y1-=p.speed
  p.y2-=p.speed
 end
 if btn(3) then 
  p.y1+=p.speed
  p.y2+=p.speed
 end
 --player limits
 if p.y1<1 then p.y1=1 p.y2=12 end
 if p.y1>116 then p.y1=116 p.y2=127 end
end

function ball_update()
 ball.dx-=ball.acc
 --ball.dy+=ball.acc

 ball.dx=mid(-ball.max_speed_x,ball.dx,ball.max_speed_x)
 ball.dy=mid(-ball.max_speed_y,ball.dy,ball.max_speed_y)

 ball.x+=ball.dx
 ball.y+=ball.dy
end

function collision_update()
 local ball_r=ball.x+ball.r
 local ball_l=ball.x-ball.r
 local ball_t=ball.y-ball.r
 local ball_b=ball.y+ball.r

 if ball_r>128
 or ball_l<0 then
  ball.dx*=-1
 elseif ball_t<0
 or ball_b>128 then
  ball.dy*=-1
 end
end

function _draw()
 cls()
 rectfill(p.x1,p.y1,p.x2,p.y2,p.col)
 circfill(ball.x,ball.y,ball.r,ball.col)
 print(ball.dx)
 print(ball.dy)
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
