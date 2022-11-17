pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
--game loop
function _init()
 p={
  sp=1,
  flp=false,
  x=10,
  y=20,
  w=8,
  h=24,
  dx=0,
  dy=0,
  max_dx=1,
  max_dy=2,
  anim=0,
  running=false,
  sliding=false,
  landed=false,
  jumping=false,
  falling=false,
  acc=.25,
  boost=3.7
 }
 gravity=.2
 friction=.85

 cam_x=0
 map_start=0
 map_end=1024
 palt(0,false)
 palt(13,true)
 
 starx={}
 stary={}
 for i=1,100 do
  add(starx,flr(144+rnd(328)))
  add(stary,flr(rnd(128)))
 end
end

function _update60()
 p_update()
 p_animate()
 cam_update()
end

function _draw()
 cls(12)
 palt(13,true)
 palt(0,false)
 rectfill(144,0, 472,128,1)
 starfield()
 map(0,0)
 spr(p.sp,p.x,p.y,p.w/8,p.h/8,p.flp)
end
-->8
--player
function p_update()
 if map_collision_full(p,'down',3) then
  friction=.99
 elseif not map_collision_full(p,'down',3) 
 and map_collision_full(p,'down',0) then
  friction=.85
 end
 p.dy+=gravity
 p.dx*=friction
 
 --input 
 --move left/right
 if btn(⬅️) then 
  p.dx-=p.acc 
  p.running=true
  p.flp=true
 end
 if btn(➡️) then 
  p.dx+=p.acc 
  p.running=true
  p.flp=false
 end
--slide
if p.running
and not btn(⬅️)
and not btn(➡️)
and not p.falling
and not p.jumping then
 p.running=false
 p.sliding=true
end
--jump
 if btnp(4)
 and p.landed then
 sfx(1,1)
  p.dy-=p.boost 
  p.landed=false
 end
 if btn(5) then
  p.max_dx=2
 elseif not btn(5) then
  p.max_dx=1
 end

 --collisions
 --down
 if p.dy>0 then
  p.falling=true
  p.landed=false
  p.jumping=false

  p.dy=limit_speed(p.dy,p.max_dy)

  --map collisions
  if map_collision_full(p,'down',0) then
   p.landed=true
   p.falling=false
   p.dy=0
   p.y-=((p.y+p.h+1)%8)-1
  end
 --up
 elseif p.dy<0 then
  p.jumping=true
  if map_collision_full(p,'up', 1) then
   p.dy=0
  end
 end
 --left
 if p.dx<0 then
  p.dx=limit_speed(p.dx,p.max_dx)
  if map_collision_full(p,'left',1) then
   p.dx=0
  end
  if map_collision_half(p,'left',2) and not p.falling and not p.jumping then
   p.dx=0
  end
 --right
 elseif p.dx>0 then 
  p.dx=limit_speed(p.dx,p.max_dx)
  if map_collision_full(p,'right',1)
  or map_collision_half(p,'right',2) then
   p.dx=0
  end
 end

 --stop sliding
 if p.sliding then
  if abs(p.dx)<.2
  or p.running then
   p.dx=0
   p.sliding=false
  end
 end
 --apply change in loc
 p.x+=p.dx
 p.y+=p.dy
 if p.x<0 then p.x=0 p.dx=0 p.running=false end
end

function p_animate()
 if p.jumping then
  sfx(-1,0)
  p.sp=4
 elseif p.falling then
  sfx(-1,0)
  p.sp=3
 elseif p.sliding then
  sfx(-1,0)
  p.sp=7
 elseif p.running then
  if not sfx(0,0) then
  sfx(0,0)
  end
  if time()-p.anim>.1 then
   p.anim=time()
   p.sp+=1
   if p.sp>6 then
    p.sp=5
   end
   if p.sp<5 then
    p.sp=5
   end
  end
 else
 sfx(-1,0)
 if time()-p.anim>.3 then
  p.anim=time()
  p.sp+=1
  if p.sp>2 then p.sp=2 end
 end
 if time()-p.anim>.85 then
  p.anim=time()
  p.sp+=1
  if p.sp>2 then p.sp=1 end
  if p.sp<1 then p.sp=1 end
  end
 end
 if p.x<0 then p.x=0 p.dx=0 end
end

--speed limiter
function limit_speed(num,maximum)
 return mid(-maximum,num,maximum)
end
-->8
--collisions
function map_collision_full(obj,aim,flag)
 local x=obj.x+4 local y=obj.y+7
 local w=obj.w-4 local h=obj.h-14
 local x1=0    local x2=0
 local y1=0    local y2=0
 --create hitbox
 if aim=='left' then
  x1=x-1 x2=x
  y1=y   y2=y+h-1
 elseif aim=='right' then
  x1=x+w x2=x+w+1
  y1=y   y2=y+h-1
 elseif aim=='up' then
  x1=x+1 x2=x+w-1
  y1=y-1 y2=y
 elseif aim=='down' then
  x1=x   x2=x+w
  y1=y+h y2=y+h
 end
 --convert hitbox to pixels
 x1/=8   x2/=8
 y1/=8   y2/=8
 --check collision
 if fget(mget(x1,y1),flag)
 or fget(mget(x1,y2),flag)
 or fget(mget(x2,y1),flag)
 or fget(mget(x2,y2),flag) then
  return true
 else
  return false
 end
end

function map_collision_half(obj,aim,flag)
 local x=obj.x+4 local y=obj.y+7
 local w=obj.w-4 local h=obj.h-14
 local x1=0    local x2=0
 local y1=0    local y2=0
 --create hitbox
 if aim=='left' then
  x1=x+1 x2=x+2
  y1=y   y2=y+h-1
 elseif aim=='right' then
  x1=x+w-2 x2=x+w-3
  y1=y   y2=y+h-1
 elseif aim=='up' then
  x1=x+1 x2=x+w-1
  y1=y-1 y2=y
 elseif aim=='down' then
  x1=x   x2=x+w
  y1=y+h y2=y+h
 end
 --convert hitbox to pixels
 x1/=8   x2/=8
 y1/=8   y2/=8
 --check collision
 if fget(mget(x1,y1),flag)
 or fget(mget(x1,y2),flag)
 or fget(mget(x2,y1),flag)
 or fget(mget(x2,y2),flag) then
  return true
 else
  return false
 end
end

-->8
--camera
function cam_update()
 cam_x=p.x-64+(p.w/2)
 if cam_x<map_start then
  cam_x=map_start
 end
 if cam_x>map_end then
  cam_x=map_end
 end
 camera(cam_x,0)
end

-->8
--stars
function starfield()
 for i=0,#starx do
  pset(starx[i],stary[i],7)
 end
end
__gfx__
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dd7dd7dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
ddd77ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
ddd77ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dd7dd7dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddd0000dddd0000dddd0000dddd0000dddd0000dddd0000dddd0000dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
ddddddddd099770dd099770dd099770dd099770dd099770dd099770dd099770ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddd09999990099999900999999009999990099999900999999009999990dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddd047070f0047070f0047070f0047070f0047070f0047070f0047070f0dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddd0f4444400f4444400f4444400f4444400f4444400f4444400f444440dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
ddddddddd044e40dd044e40df944e40fd0f4e40fd044e40dd044e40dd044e40ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
ddddddddd094440d0f0444f000944490d09444900f9444f00f9444f00f9444f0dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddd0f0990f0d009900d04099020d009900dd009920dd029900dd009920ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
ddddddddd044220dd044220dd040020dd04020ddd04000dddd00040ddd04420ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddd0000dddd0000dddd0000dddd0000dddd0000dddd0000dddd0000dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddd00000000d0000000000000000000000d00000000dd00000000000000000000dddddddddddddddd555555dddddddddddddddddddd000000000000000d
ddddddddbbbbbbbb0bbbbbbbbbbbbbbbbbbbbbb0eeeeeeeed0eeeeeeeeeeeeeeeeeeee0ddddddddddddd5577777755dddddddddddddddddd6677777766666000
dddddddd333b3333033333333333333333333330222222220e2222222222222222222220ddddddddddd577777777775ddddddddddddddddd7777777777777660
dddddddd000b3000d0000000000000000000000d22222222022222222222222222222220dddddddddd57777777777775dddddddddddddddd7777776666667760
dddddddddd0b30dddddddddddddddddddddddddd000e2000d0000000000000000000000ddddddddddd577775775776755ddddddddddddddd7777777777777660
dddddddddd0b30dddddddddddddddddddddddddddd0e20ddddddddddddddddddddddddddddddddddd5777775775777675ddddddddddddddd7777666666777760
dddddddddd0b30dddddddddddddddddddddddddddd0e20ddddddddddddddddddddddddddddddddddd5777775775777675ddddddddddddddd7776666667777660
dddddddddd0b30dddddddddddddddddddddddddddd0e20ddddddddddddddddddddddddddddddddd55777777777777777755555dddddddddd7766666677777660
dddddddddd0b30dddddddddddddddddddddddddddd0e20ddddddddddddddddddddddddddddddd555777777777777777777777755dddddddd6666666777776660
dddddddddd0b30dddddddddddddddddddddddddddd0e20ddddddddddddddddddddddddddddd557777777777777777777777777775ddddddd6666667777767660
dddddddddd0b30dddddddddddddddddddddddddddd0e20dddddddddddddddddddddddddddd5777777777777777777777777776775ddddddd6666677777677660
dddddddddd0b30dddddddddddddddddddddddddddd0e20ddddddddddddddddddddddddddd577777777777777777777777777776775dddddd6666777776777660
dddddddddd0b30dddddddddddddddddddddddddddd0e20ddddddddddddddddddddddddddd577777777777777777777777777776775dddddd6667777767777660
dddddddddd0b30dddddddddddddddddddddddddddd0e20dddddddddddddddddddddddddd5777777777777777777777777777766775dddddd6677777677777660
dddddddddd0b30dddddddddddddddddddddddddddd0e20dddddddddddddddddddddddddd577777777777777777777777776666775ddddddd6777776777777660
dddddddddd0b30dddddddddddddddddddddddddddd0e20dddddddddddddddddddddddddd57777777777777777777777777776675dddddddd7777767777777660
dddd000000000000000000000000dddddddddddd00000000000000000000000000000000d5777777677777777777777777766755ddddddddd000000000007000
dd00bbbbbbbbbbbbbbbbbbbbbbbb00dddddddddd07777777777777777777777777777770d576777667777777667777777776675ddddddddd0066677667776766
d0bbbbbbbbbbbbbbbbbbbbbbbbbbbb0ddddddddd07777777777777777777777777777770dd57766677777777667777777766775ddddddddd0667777777777777
d0bbbbb333bbb333333bbb333bbbbb0ddddddddd07777777777777777777777777777770ddd557777777777766777677767775dddddddddd0677766777676666
0bbbb3300033300000033300033bbbb0dddddddd06777667666777766667777676677760ddddd557776777766755777666755ddddddddddd0677677777777777
0bbb330222000222222000222033bbb0dddddddd00666006000667600006676060066600ddddddd557766666775d5577775ddddddddddddd0776777776766677
0bbb302222222222222222222203bbb0dddddddd05000550555006055550060505500050ddddddddd557777755dddd5555dddddddddddddd0776777767666777
0bb33024422224444442222442033bb0dddddddd05555555555550555555505555555550ddddddddddd55555dddddddddddddddddddddddd0677777676667777
0bb302244444444f4444444942203bb0dddddddd05555555555555555555555555555550dddddddddddddddddddddddddddddddddddddddd0677776766677777
0bb30224444444444444444442203bb0dddddddd05555555555555555555555555556650dddddddddddddddddddddddddddddddddddddddd0777767666777776
0bb302244464444444444ff442203bb0dddddddd05555555556555555555555555556650dddddddddddddddddddddddddddddddddddddddd0777776667777766
0bbb30224464444444444ff42203bbb0dddddddd05555555556555555555555555555550dddddddddddddddddddddddddddddddddddddddd0776766677777666
0bbb30224444444444444ff42203bbb0dddddddd05555555555555555555555555555550dddddddddddddddddddddddddddddddddddddddd0677766777776666
0bbb3022444444ff444244442203bbb0dddddddd05555555555555555552555555555550dddddddddddddddddddddddddddddddddddddddd0776767777766666
0bb30222449444ff4442444422203bb0dddddddd05555555555555555552555555555550dddddddddddddddddddddddddddddddddddddddd0676777777666666
0bb30224444444444444444442203bb0dddddddd05555555555555555555555555555550dddddddddddddddddddddddddddddddddddddddd0676777776666667
dddddddddddd00000000ddddddddddddddddd000000ddddddddddd000000ddddddddddd000000ddddddddddddddddddddddddddddddddddddddddddddddddddd
ddddddddd00066666666000dddddddddddd00bbbbbb00ddddddd00bbbbbb00ddddddd00bbbbbb00ddddddddddddddddddddddddddddddddddddddddddddddddd
ddddddd006666666666666600ddddddddd0bbbbbbbbbb0ddddd0bbbbbbbbbb0ddddd0bbbbbbbbbb0dddddddddddddddddddddddddddddddddddddddddddddddd
dddddd06666666666666666660ddddddd0bbbb0b0bbbbb0ddd0bbbb0b0bbbbb0ddd0bbbb0b0bbbbb0ddddddddddddddddddddddddddddddddddddddddddddddd
ddddd0666666666666666666660dddddd0bbbb0b0bbbbb0ddd0bbbb0b0bbbbb0ddd0bbbb0b0bbbbb0ddddddddddddddddddddddddddddddddddddddddddddddd
dddd066666666666666666666660dddd0bbbbbbbbbbbb0000000bbbbbbbbbb0000000bbbbbbbbbbbb0dddddddddddddddddddddddddddddddddddddddddddddd
dddd066666600666666006666660dddd0bbbbbbbbbb00bbbbbbb00bbbbbb00bbbbbbb00bbbbbbbbbb0dddddddddddddddddddddddddddddddddddddddddddddd
ddd06666666006666660066666660ddd0bbbbbbbbb0bbbbbbbbbbb0bbbb0bbbbbbbbbbb0bbbbbbbbb0dddddddddddddddddddddddddddddddddddddddddddddd
ddd06666666666666666666666660ddd0bbbbbbbb0bbbbbbbbbbbbb0bb0bbbbbbbbbbbbb0bbbbbbbb0dddddddddddddddddddddddddddddddddddddddddddddd
dd0666666666666666666666666660dd0bbbbbbbb0bbbbb0b0bbbbb0bb0bbbb0bbb0bbbb0bbbbbbbb0dddddddddddddddddddddddddddddddddddddddddddddd
dd0666666666666666666666666660dd0bbbbbbb0bbbbbb0b0bbbbbb00bbbbb0bbb0bbbbb0bbbbbbb0dddddddddddddddddddddddddddddddddddddddddddddd
dd0666666666666666666666666660dd0bbbbbbb0bbbbbbbbbbbbbbb00bbbbbbbbbbbbbbb0bbbbbbb0dddddddddddddddddddddddddddddddddddddddddddddd
d066666666666666666666666666660d0bbbbbbb0bbbbbbbbbbbbbbb00bbbbbbbbbbbbbbb0bbbbbbb0dddddddddddddddddddddddddddddddddddddddddddddd
d066666666666666666666666666660d0bbbbbbb0bbbbbbbbbbbbbbb00bbbbbbbbbbbbbbb0bbbbbbb0dddddddddddddddddddddddddddddddddddddddddddddd
d066666666666666666666666666660d0bbbbbbb0bbbbbbbbbbbbbbb00bbbbbbbbbbbbbbb0bbbbbbb0dddddddddddddddddddddddddddddddddddddddddddddd
d066666666666666666666666666660d0bbbbbbb0bbbbbbbbbbbbbbb00bbbbbbbbbbbbbbb0bbbbbbb0dddddddddddddddddddddddddddddddddddddddddddddd
d066666666666666666666666666660dddddd000000ddddddddddd000000ddddddddddd000000ddddddddddddddddddddddddddddddddddddddddddddddddddd
d066666666666666666666666666660dddd0077777700ddddddd0077777700ddddddd0077777700ddddddddddddddddddddddddddddddddddddddddddddddddd
d066666666666666666666666666660ddd077777777770ddddd077777777770ddddd077777777770dddddddddddddddddddddddddddddddddddddddddddddddd
d066666666666666666666666666660dd07777070777770ddd07777070777770ddd07777070777770ddddddddddddddddddddddddddddddddddddddddddddddd
d066666666666666666666666666660dd07777070777770ddd07777070777770ddd07777070777770ddddddddddddddddddddddddddddddddddddddddddddddd
d066666666666666666666666666660d07777777777770000000777777777700000007777777777770dddddddddddddddddddddddddddddddddddddddddddddd
d066666666666666666666666666660d07777777777007777777007777770077777770077777777770dddddddddddddddddddddddddddddddddddddddddddddd
d066666666666666666666666666660d07777777770777777777770777707777777777707777777770dddddddddddddddddddddddddddddddddddddddddddddd
d066666666666666666666666666660d07777777707777777777777077077777777777770777777770dddddddddddddddddddddddddddddddddddddddddddddd
d066666666666666666666666666660d07777777707777707077777077077770777077770777777770dddddddddddddddddddddddddddddddddddddddddddddd
d066666666666666666666666666660d07777777077777707077777700777770777077777077777770dddddddddddddddddddddddddddddddddddddddddddddd
d066666666666666666666666666660d07777777077777777777777700777777777777777077777770dddddddddddddddddddddddddddddddddddddddddddddd
d066666666666666666666666666660d07777777077777777777777700777777777777777077777770dddddddddddddddddddddddddddddddddddddddddddddd
d066666666666666666666666666660d07777777077777777777777700777777777777777077777770dddddddddddddddddddddddddddddddddddddddddddddd
d066666666666666666666666666660d07777777077777777777777700777777777777777077777770dddddddddddddddddddddddddddddddddddddddddddddd
d066666666666666666666666666660d07777777077777777777777700777777777777777077777770dddddddddddddddddddddddddddddddddddddddddddddd
__label__
7ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccc555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccc5577777755cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccc577777777775ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccc57777777777775cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccc577775775776755ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccc5777775775777675ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccc5777775775777675ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccc55777777777777777755555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccc555777777777777777777777755cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccc557777777777777777777777777775ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccc5777777777777777777777777776775ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccc577777777777777777777777777776775cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccc577777777777777777777777777776775cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccc5777777777777777777777777777766775cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccc577777777777777777777777776666775ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccc57777777777777777777777777776675cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccc5777777677777777777777777766755cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccc576777667777777667777777776675ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccc57766677777777667777777766775ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccc557777777777766777677767775cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccc557776777766755777666755ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccc557766666775c5577775ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccc557777755cccc5555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccc55555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc000000000000000000000000000000000000cccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0ccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0e22222222222222222222222222222222222220cccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0222222222222222222222222222222222222220cccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0000000000e200000000000000e20000000000ccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccc0000cccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccc099770ccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccc09999990cccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccc047070f0cccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccc0f444440cccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccc044e40ccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccc0f0444f0cccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccc009900ccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccc044220ccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
ccccccccccccccccccccccccc00000000000000000000000000000000000000ccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccc0bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0cccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccc03333333333b333333333333333b333333333330cccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
ccccccccccccccccccccccccc0000000000b300000000000000b30000000000ccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccc0b30cccccccccccc0b30cccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccc0b30cccccccccccc0b30cccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccc0b30cccccccccccc0b30cccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccc0b30cccccccccccc0b30cccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccc0b30cccccccccccc0b30cccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccc0b30cccccccccccc0b30cccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccc0b30cccccccccccc0b30cccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccc0b30cccccccccccc0b30cccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccc0b30cccccccccccc0b30cccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccc0b30cccccccccccc0b30cccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccc0b30cccccccccccc0b30cccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccc0b30cccccccccccc0b30cccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccc0b30cccccccccccc0b30cccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccc0b30cccccccccccc0b30cccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccc0b30cccccccccccc0b30cccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccc0b30cccccccccccc0b30cccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccc0b30cccccccccccc0b30cccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccc0b30cccccccccccc0b30cccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccc0b30cccccccccccc0b30cccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccc0b30cccccccccccc0b30cccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccc0b30cccccccccccc0b30cccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccc0b30cccccccccccc0b30cccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccc0b30cccccccccccc0b30cccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccc0b30cccccccccccc0b30cccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccc0b30cccccccccccc0b30cccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccc0b30cccccccccccc0b30cccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccc0b30cccccccccccc0b30cccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccccccccccccccccccccccccccccccccc0b30cccccccccccc0b30cccccccccccccccccccccccccccccccccccc0e20cccccccccccc0e20cccccccccccccccccc
cccc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
cc00bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
c0bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
c0bbbbb333bbb333333bbb3333bbb333333bbb3333bbb333333bbb3333bbb333333bbb3333bbb333333bbb3333bbb333333bbb3333bbb333333bbb3333bbb333
0bbbb330003330000003330000333000000333000033300000033300003330000003330000333000000333000033300000033300003330000003330000333000
0bbb3302220002222220002222000222222000222200022222200022220002222220002222000222222000222200022222200022220002222220002222000222
0bbb3022222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
0bb33024422224444442222442222444444222244222244444422224422224444442222442222444444222244222244444422224422224444442222442222444
0bb302244444444f444444494444444f444444494444444f444444494444444f444444494444444f444444494444444f444444494444444f444444494444444f
0bb30224444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
0bb302244464444444444ff44464444444444ff44464444444444ff44464444444444ff44464444444444ff44464444444444ff44464444444444ff444644444
0bbb30224464444444444ff44464444444444ff44464444444444ff44464444444444ff44464444444444ff44464444444444ff44464444444444ff444644444
0bbb30224444444444444ff44444444444444ff44444444444444ff44444444444444ff44444444444444ff44444444444444ff44444444444444ff444444444
0bbb3022444444ff44424444444444ff44424444444444ff44424444444444ff44424444444444ff44424444444444ff44424444444444ff44424444444444ff
0bb30222449444ff44424444449444ff44424444449444ff44424444449444ff44424444449444ff44424444449444ff44424444449444ff44424444449444ff
0bb30224444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
0bb302244444444f4444444f4444444f4444444f4444444f4444444f4444444f4444444f4444444f4444444f4444444f4444444f4444444f4444444f4444444f
0bb30224444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
0bb30224446444444464444444644444446444444464444444644444446444444464444444644444446444444464444444644444446444444464444444644444
0bbb3022446444444464444444644444446444444464444444644444446444444464444444644444446444444464444444644444446444444464444444644444
0bbb3022444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
0bbb3022444444ff444444ff444444ff444444ff444444ff444444ff444444ff444444ff444444ff444444ff444444ff444444ff444444ff444444ff444444ff
0bb30222449444ff449444ff449444ff449444ff449444ff449444ff449444ff449444ff449444ff449444ff449444ff449444ff449444ff449444ff449444ff
0bb30224444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
0bb302244444444f4444444f4444444f4444444f4444444f4444444f4444444f4444444f4444444f4444444f4444444f4444444f4444444f4444444f4444444f
0bb30224444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
0bb30224446444444464444444644444446444444464444444644444446444444464444444644444446444444464444444644444446444444464444444644444
0bbb3022446444444464444444644444446444444464444444644444446444444464444444644444446444444464444444644444446444444464444444644444
0bbb3022444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
0bbb3022444444ff444444ff444444ff444444ff444444ff444444ff444444ff444444ff444444ff444444ff444444ff444444ff444444ff444444ff444444ff
0bb30222449444ff449444ff449444ff449444ff449444ff449444ff449444ff449444ff449444ff449444ff449444ff449444ff449444ff449444ff449444ff
0bb30224444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444

__gff__
0000000000000000020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001010101010109090900000000000000010101000001000000000000000000000101010100090909090000000000000000010001000809080900000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000494a4b4c4d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000494a4b4c4d000000000000000000000000494a4b4c4d00000000000000000000000000000000494a4b4c4d00000000000000000000595a5b5c5d00000000000000000000000000000000000000494a4b4c4d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000595a5b5c5d000000000000000000000000595a5b5c5d00000000000000000000000000000000595a5b5c5d00000000000000000000696a6b6c6d00000000000000000000000000000000000000595a5b5c5d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000696a6b6c6d000000000000000000000000696a6b6c6d46474800000000000000000000000000696a6b6c6d00000000000000000000000000000000000000000000000000000000000000000000696a6b6c6d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000046454745480000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000550055000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000550055000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000004241434144000000550055000000000000004647480000000000000000000046474800000000000000000000000000008081828300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000051005100000000550055000000000000000000000000000000000000000000000000000000000000000000000000009091929300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000510051000000005500550000000000000000a4a5a6a7a8a9aa00000000808182830000000000000000000000000000a0a1a2a3000000000000008485868788898a0000000000000000000000000000008485868788890000000000008485868788898a00000000000000000000000000000000000000000000000000
00000000510051000000005500550000000000000000b4b5b6b7b8b9ba00000000909192930000000000004647480000000000b0b1b2b3000000000000009495969798999a0000000000000000000000000000009495969798990000000000009495969798999a00000000000000000000000000000000000000000000000000
6061626162616261626162616261626163646566676766676667666766676667666766676667666768000000000000000065666667666768000000606261626162616261626162616261626162616261626162616261626162616261626162616261626162616261626162616261626162616261626162616261626162616261
7071727172717271727172717271727173647576777776777677767776777677767776777677767778000000000000000075767677767778000000707271727172717271727172717271727172717271727172717271727172717271727172717271727172717271727172717271727172717271727172717271727172717271
7071717171717171717171717171717173647576777676767676767676767676767676767676767678000000000000000075767677767778000000707171717171717171717171717171717171717171717171717171717171717171717171717171717171717171717171717171717171717171717171717171717171717171
7071717171717171717171717171717173647576777676767676767676767676767676767676767678000000000000000075767677767778000000707171717171717171717171717171717171717171717171717171717171717171717171717171717171717171717171717171717171717171717171717171717171717171
__sfx__
c001001f3b0252e705327002e705327002e705327002e705370052e7053270000705327000070532700007053b025007050070500705007050070500705007053270500705007050070500705007050070500705
aa04000016011180111b01120011270112d0112e00118001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001
