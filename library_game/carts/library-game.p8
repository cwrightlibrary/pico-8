pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
--game loop
function _init()
 p={
  sp=1,
  flp=false,
  x=2,
  y=13*8,
  w=16,
  h=16,
  dx=0,
  dy=0,
  max_dx=0,
  max_dy=4,
  anim=0,
  hold_anim=0,
  running=false,
  sliding=false,
  landed=false,
  jumping=false,
  falling=false,
  acc=.25,
  boost=3.7
 }
 bouncer={
  sp=150,
  flp=false,
  x=8,
  y=13,
  w=16,
  h=16,
  dx=0,
  dy=0,
  max_dx=0,
  max_dy=4,
  anim=0,
  hold_anim=0,
  waiting=false,
  falling=false,
  landed=true,
  boost=3
 }
 gravity=.2
 friction=.85

 palt(0,false)
 palt(2,true)

 rx1=0 rx2=0
 ry1=0 ry2=0

 looper=false
 waiting=0

 rain_init()
end

function bouncer_update()
 bouncer.dy+=gravity
 bouncer.dx*=friction

 if bouncer.dy>0 then
  bouncer.fallling=true
  bouncer.landed=false
  bouncer.dy=0
  bouncer.dy=limit_speed(bouncer.dy,bouncer.max_dy)
  if map_collision(bouncer,'down',0)
  or map_collision(bouncer,'down',1) then
   bouncer.landed=true
   bouncer.falling=false
   bouncer.dy=0
   bouncer.y-=((bouncer.y+bouncer.h+1)%8)-1
  end
 end
 if bouncer.dx<0 then
  bouncer.dx=limit_speed(bouncer.dx,bouncer.max_dx)
  if map_collision(bouncer,'left',0) then
   bouncer.dx=0
  end
 elseif bouncer.dx>0 then
  bouncer.dx=limit_speed(bouncer.dx,bouncer.max_dx)
  if map_collision(bouncer,'right',0) then
   bouncer.dx=0
  end
 end
end

function bouncer_animate()
 
end

function bouncer_draw()
 spr(bouncer.sp,bouncer.x*8,bouncer.y*8,bouncer.w/8,bouncer.h/8,bouncer.flp)
end

function _update60()
 p_update()
 p_animate()
 rain_update()
 bouncer_update()
end

function _draw()
 cls(1)
 rain_draw()
 map(16,0)
 map(0,0)
 bouncer_draw()
 p_draw()
 print(bouncer.waiting)
end
-->8
--player
function p_update()
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
  p.max_dx=1.5
 end

 --collisions
 --down
 if p.dy>0 then
  p.falling=true
  p.landed=false
  p.jumping=false

  p.dy=limit_speed(p.dy,p.max_dy)

  --map collisions
  if map_collision(p,'down',0)
  or map_collision(p,'down',1) then
   p.landed=true
   p.falling=false
   p.dy=0
   p.y-=((p.y+p.h+1)%8)-1
  end
 --up
 elseif p.dy<0 then
  p.jumping=true
  if map_collision(p,'up',0) then
   p.dy=0
  end
 end
 --left
 if p.dx<0 then
  p.dx=limit_speed(p.dx,p.max_dx)
  if map_collision(p,'left',0) then
   p.dx=0
  end
 --right
 elseif p.dx>0 then 
  p.dx=limit_speed(p.dx,p.max_dx)
  if map_collision(p,'right',0) then
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
 if p.x<-4 then p.x=-4 p.dx=0 p.running=false end
 if p.x>116 then p.x=116 p.dx=0 p.running=false end
end

function p_animate()
 if p.running 
 and p.landed then
  waiting=0
  if time()-p.anim>.05 then
   p.anim=time()
   p.sp+=2
   if p.sp>41 then
    p.sp=33
   end
   if p.sp<33 then
    p.sp=33
   end
  end
  elseif not p.landed then
   waiting=0
   p.sp=11
  else
   if p.sp>10 then
    p.sp=1
   end
   if waiting<rnd(540)+300 then
    waiting+=1
   else
    if time()-p.anim>.1 then
     p.anim=time()
     if looper==false then
      p.sp+=2
      if p.sp>=9 then
       looper=true
      end
     elseif looper==true then
      p.sp-=2
      if p.sp<=1 then
       p.sp=1
       looper=false
       waiting=0
     end
    end
   end
  end
 end
end

function p_draw()
  spr(p.sp,p.x,p.y,p.w/8,p.h/8,p.flp)
end
-->8
--rain
function rain_init()
 raincol=7
 rainx={}
 rainy={}
 for i=1,50 do
  add(rainx,0)
  add(rainy,flr(rnd(192)-64))
 end
 rainx[1]=-64
 for i=2,#rainx do
  rainx[i]=rainx[i-1]+(flr(3+(rnd(7))))
 end
end

function rain_update()
 for i=1,#rainx do
  rainx[i]+=2
  rainy[i]+=2
  if rainx[i]>128
  or rainy[i]>128 then
   randomx=flr(rnd(192)-64)
   rainx[i]=randomx+3
   rainy[i]=0
  end
 end
end

function rain_draw()
 for i=1,#rainx do
  line(rainx[i],rainy[i],rainx[i]+2,rainy[i]+2,raincol)
 end
end
-->8
--custom functions
--speed limiter
function limit_speed(num,maximum)
 return mid(-maximum,num,maximum)
end
--collisions
function map_collision(obj,aim,flag)
 local x=obj.x local y=obj.y
 local w=obj.w local h=obj.h
 local x1=0    local x2=0
 local y1=0    local y2=0
 --create hitbox
 if aim=='left' then
  x1=x+2   x2=x+5
  y1=y+1   y2=y+h-2

 elseif aim=='right' then
  x1=x+w-3 x2=x+w-5
  y1=y+1   y2=y+h-2

 elseif aim=='up' 
 and not obj.flp then
  x1=x+5   x2=x+w-5
  y1=y-1   y2=y
 elseif aim=='up' 
 and obj.flp then
  x1=x+5   x2=x+w-5
  y1=y-1   y2=y

 elseif aim=='down'
 and not obj.flp then
  x1=x+5   x2=x+w-6
  y1=y+h-1   y2=y+h+1
 elseif aim=='down'
 and obj.flp then
  x1=x+5   x2=x+w-6
  y1=y+h-1   y2=y+h+1
 end
 rx1=x1 rx2=x2
 ry1=y1 ry2=y2
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
__gfx__
00000000222222222222222222222222222222222222222222222222222222222222222222222222222222222222200000022222222222222222222222222222
00000000222220000002222222222000000222222222200000022222222220000002222222222000000222222222000000002222222222222222222222222222
00700700222200000000222222220000000022222222000000002222222200000000222222220000000022222222004444402222222222222222222222222222
00077000222200444440222222220044444022222222004444402222222200444440222222220400440022222222040044002222222222222222222222222222
00077000222204004400222222220400440022222222040044002222222204004400222222220077007702222222007700770222222222222222222222222222
00700700222200770077022222220077007702222222007700770222222200770077022222200077000702222220007700070222222222222222222222222222
00000000222000770007022222200077000702222220007700070222222000770007022222220400440040222220040044000022222222222222222222222222
00000000222204004400022222220400440002222222040044000222222204004400022222222044444002222204004444400402222222222222222222222222
00000000222220444440222222222044444022222222204444402022222220444440402222222044444002222220dd0000000022222222222222222222222222
0000000022220d000000222222220d000000222222220d000000040222220d000000022222220d0000002222222200ed0e002222222222222222222222222222
000000002220d0ed0e0d02222220d0ed0e0002222220d0ed0e0d00222220d0ed0e0002222220d0ed0e022222222220dedd022222222222222222222222222222
00000000222000dedd000222222000dedd004022222000dedd002222222000dedd022222222000dedd0222222222200000002222222222222222222222222222
00000000222040000004022222204000000202222220400000022222222040000002222222204000000222222222200000002222222222222222222222222222
00000000222200000000222222220000000222222222000000022222222200000002222222220000000222222222090020902222222222222222222222222222
00000000222220900902222222222090090222222222209009022222222220900902222222222090090222222222002220022222222222222222222222222222
00000000222222002002222222222200200222222222220020022222222222002002222222222200200222222222222222222222222222222222222222222222
00000000222220000002222222222000000222222222222222222222222220000002222222222000000222222222222222222222222222222222222222222222
00000000222200000000222222220000000022222222200000022222222200000000222222220000000022222222222222222222222222222222222222222222
00000000222200444440222222220044444022222222000000002222222200444440222222220044444022222222222222222222222222222222222222222222
00000000222204004400222222220400440022222222004444402222222204004400222222220400440022222222222222222222222222222222222222222222
00000000222200770077022222220077007702222222040044002222222200770077022222220077007702222222222222222222222222222222222222222222
00000000222000770007022222200077000702222222007700770222222000770007022222200077000702222222222222222222222222222222222222222222
00000000222204004400022222220400440002222220007700070222222204004400022222220400440002222222222222222222222222222222222222222222
00000000222220444440222222222044444022222222040044000222222220444440222222222044444022222222222222222222222222222222222222222222
0000000022220d000000222222220d0000002222222220444440222222220d000000222222220d00000022222222222222222222222222222222222222222222
000000002220d0ed0e0d02222220d0ed0e0d022222220d00000022222220d0ed0e0d02222220d0ed0e0d02222222222222222222222222222222222222222222
00000000220400dedd004022220400dedd0040222220d0ed0e0d0222220400dedd004022220400dedd0040222222222222222222222222222222222222222222
0000000022202000000002222220200000000222220400dedd004022222020000002022222202000000002222222222222222222222222222222222222222222
00000000222220002200022222222000200022222220200000020222222220000000222222222000000022222222222222222222222222222222222222222222
00000000222220002209022222222000220022222222200000022222222222000090222222222090009022222222222222222222222222222222222222222222
00000000222209022200222222220902220902222222209090022222222220900002222222222002200222222222222222222222222222222222222222222222
00000000222220222222222222222002220002222222220000222222222220022222222222222222222222222222222222222222222222222222222222222222
22222222220000000000000000000000000000000000000022222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222200099999999999999999999999999999999999022222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222209000000000000000000000000000000000000022222222222222222222222222222222222222222222222222222222222222222222222222222222
2222222200900aa000660030aa000080003380088000aa0022222222222222222222222222777777777777727777777777772222222222222222222222222222
2222222209000a9088660c00aa00038000008cc00000a90022222222222222222222222226777777777777767777777777776222222222222222222222222222
2222222009000a9088660c30aa00338000338cc88600a90022222222221111111119992296775575557577767777777777776922222222222222222222222222
222222209400044088660c00aa03308000008cc006004400222222222111dddddddd192296777777777777767575557557776922222222222222222222222222
222222009000000088660c30aa33008000338cc88600000022222222111ddddddddd192216775555575757767777777777776122222222222222222222222222
222222090400a9909999999999999999999999999990a990777aaaa211ddddddddddd12216777777777777767555755757776122222222222222222222222222
2222200940000a94000000000000000000000000000a94007999999a11dd1ddddd1dd12216775557555557767777777777761222222222222222222222222222
222220940400000066cc00000000066000000000550000007977a99911dd11d1d11dd12216777777777777767555557557761222222222222222222222222222
2222209440000aa000cc008000000000c00000030000aa00a979949911dddd1dd1ddd12216771333111111767777777777761222222222222222222222222222
2222009404000a90660cc08066000660ca0008835500a900a9a9949911ddd1dd11d1d122167711c3c11c11767575755757761222222222222222222222222222
2222094440000a90660cc08066000660caa008835500a900a944449911dd111d1dddd12216771ccccccc11767777777777761222222222222222222222222222
22220944040004400000cc8066000000c0aa088300004400a999999911ddddddddddd1221677111ccc1331767555757557761222222222222222222222222222
22200944400000006600cc8066000660c00aa883550000004444444911ddddddddddd1221677111ccc33c1767777777777761222222222222222222222222222
2220944404000000999999999999999999999999994000001111111111ddddddddddd122167711c1133333767557575557761222222222222222222222222222
2220944440000aa09444444444444444444444444440aa0011111111111ddd1d1ddd192216771111113337767777777777761222222222222222222222222222
2220944404000a900000000000000000000000000000a900dd1ddddd1111ddddddd1192216777777777777767777777777761222222222222222222222222222
22209444400004400aaaaaaaaa0aaaaaaa0aaaaaaa004400dddddddd111111111119992216777777577777767777757777761222222222222222222222222222
22209444040000000a999990040a0099940a009994000000ddddd1dd115588555555512216777777777777767777777777761222222222222222222222222222
2220944440000a900a999999940a9999940a99999400a900dd1ddddd156688666666592296666666666666656666666666669222222222222222222222222222
222094440400a994044444444404444444044444440a4440dddddddd115588555555592296666666666666656666666666669222222222222222222222222222
222094440000000000000000000000000000000000000000dddd1ddd211118111119992299911111111115551188111111999222222222222222222222222222
22209444222222222222222222222222222222222222222222222222222222222222222222222222222211111228222222222222222222222222222222222222
22209444222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22209444222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22209444222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22209444222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22209444222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22209444222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22200000222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
66666666666666666666666666666666666666662222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
66666666666666666666666666666666666666662222222222000002220000022222222222222222222222222222222222222222222222222222222222222222
66666666655555555555555555555555555555562222222220333330203333302222222222222222222222222222222222222222222222222222222222222222
6666666664444444444444444444444444444556222222222033e3e02033e3e02222222222222222222222222222222222222222222222222222222222222222
66666666642222222222222222222222222245562222222220333330203333302222222222222222222222222222222222222222222222222222222222222222
66666666642222222222222222222222222245562222222222033302220333022222222222222222222222222222222222222222222222222222222222222222
66666666642222222222222222222222222245562222222222030302203000302222222222222222222222222222222222222222222222222222222222222222
66666666642222222222222222222222222245562222222222002002220222022222222222222222222222222222222222222222222222222222222222222222
22222222642222222222222222222222222245562222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222642222222222222222222222222245562222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222642222222222222222222222222245562222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222642222222222222222222222222245562222222222222222222222222220000000002222222222222222222222222222222222222222222222222222
22222222642222222222222222222222222245562222222222200000000022222203333333330222222222222222222222222222222222222222222222222222
22222222642222222222222222222222222245562222222222033333333302222033311133311022222222222222222222222222222222222222222222222222
22222222642222222222222222222222222245562222222220333111333110222033331113111022222222222222222222222222222222222222222222222222
22222222642222222222222222222222222245562222222220333311131110222033333703703022222222222222222222222222222222222222222222222222
22222222642222222222222222222222222245562222222220333337037030222033333703703022222222222222222222222222222222222222222222222222
22222222642222222222222222222222222245562222222220333337037030222033333333333022222222222222222222222222222222222222222222222222
22222222642222222222222222222222222245562222222220333333333330222033333300033022222222222222222222222222222222222222222222222222
22222222642222222222222222222222222245562222222220333333000330222203333333330222222222222222222222222222222222222222222222222222
22222222642222222222222222222222222245562222222222033333333302222033300000333022222222222222222222222222222222222222222222222222
22222222642222222222222222222222222245562222222222033000003022222033022222033022222222222222222222222222222222222222222222222222
22222222642222222222222222222222222245562222222222033022033022222000222222200022222222222222222222222222222222222222222222222222
22222222642222222222222222222222222245562222222222000222000222222222222222222222222222222222222222222222222222222222222222222222
22222222642222222222222222222222222245562222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222642222222222222222222222222245562222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222642222222222222222222222222245562222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222642222222222222222222222222245562222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222642222222222222222222222222245562222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222644444444444444444444444444445562222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222666666666666666666666666666666662222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222666666666666666666666666666666662222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000020202020202000000000000000000000000000000020000000000000000000000000000000300000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000000000000080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000080808080818283838383848080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000080808080919293939393948080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000474800000000000000000000000080808080a1a2a3a3a3a3a48080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000575800000000000000000000000080808080b1b2b3b3b3b3b48080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000676800000000000000000000000080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4041424344450000000000000000000080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5051545352550056565600000000000080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6051535354550000000000000000000080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6051545452550000000000000000000080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6051525353550000000000565656000080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6051545354550000000000000000000080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7061626364650000000000000000000080808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6666666666666666666666666666666680808080808080808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
