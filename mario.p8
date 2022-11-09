pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
--variables

function _init()
  player={
    sp=0,
    x=2,
    y=14,
    w=8,
    h=8,
    flp=false,
    dx=0,
    dy=0,
    max_dx=1.7,
    max_dy=3,
    acc=0.25,
    boost=4.65,
    anim=0,
    running=false,
    jumping=false,
    falling=false,
    landed=false
  }
  
  coin={
   sp=35,
   x=15,
   y=8,
   anim=0
  }

  gravity=0.3
  friction=0.85

  --simple camera
  cam_x=0

  --map limits
  map_start=0
  map_end=1024
end

-->8
--update and draw

function _update()
  player_update()
  player_animate()
  coin_animate()

  --simple camera
  cam_x=player.x-64+(player.w/2)
  if cam_x<map_start then
     cam_x=map_start
  end
  if cam_x>map_end-128 then
     cam_x=map_end-128
  end
  camera(cam_x,0)
end

function _draw()
  cls()
  map(0,0)
  spr(coin.sp,coin.x*8, coin.y*8)
  outline_sprite(player.sp,0,player.x,player.y,1,1,player.flp)
end

-->8
--collisions

function collide_map(obj,aim,flag)
 --obj = table needs x,y,w,h
 --aim = left,right,up,down

 local x=obj.x  local y=obj.y
 local w=obj.w  local h=obj.h

 local x1=0	 local y1=0
 local x2=0  local y2=0

 if aim=="left" then
   x1=x-2  y1=y
   x2=x    y2=y+h-1

 elseif aim=="right" then
   x1=x+w        y1=y
   x2=x+w+1  y2=y+h-1

 elseif aim=="up" then
   x1=x+2    y1=y-1
   x2=x+w-3  y2=y

 elseif aim=="down" then
   x1=x+2      y1=y+h
   x2=x+w-3    y2=y+h
 end

 --pixels to tiles
 x1/=8    y1/=8
 x2/=8    y2/=8

 if fget(mget(x1,y1), flag)
 or fget(mget(x1,y2), flag)
 or fget(mget(x2,y1), flag)
 or fget(mget(x2,y2), flag) then
   return true
 else
   return false
 end

end

-->8
--player

function player_update()
  --physics
  player.dy+=gravity
  player.dx*=friction

  --controls
  if btn(⬅️) then
    player.dx-=player.acc
    player.running=true
    player.flp=true
  end
  if btn(➡️) then
    player.dx+=player.acc
    player.running=true
    player.flp=false
  end
  
  --done running
  if player.running
  and not btn(⬅️)
  and not btn(➡️)
  and not player.falling
  and not player.jumping then
   player.running=false
  end

  --jump
  if btnp(❎)
  and player.landed then
    player.dy-=player.boost
    player.landed=false
  end

  --check collision up and down
  if player.dy>0 then
    player.falling=true
    player.landed=false
    player.jumping=false

    player.dy=limit_speed(player.dy,player.max_dy)

    if collide_map(player,"down",0) then
      player.landed=true
      player.falling=false
      player.dy=0
      player.y-=((player.y+player.h+1)%8)-1
    end
  elseif player.dy<0 then
    player.jumping=true
    if collide_map(player,"up",1) then
      player.dy=0
    end
  end

  --check collision left and right
  if player.dx<0 then

    player.dx=limit_speed(player.dx,player.max_dx)

    if collide_map(player,"left",1) then
      player.dx=0
    end
  elseif player.dx>0 then

    player.dx=limit_speed(player.dx,player.max_dx)

    if collide_map(player,"right",1) then
      player.dx=0
    end
  end

  player.x+=player.dx
  player.y+=player.dy

  --limit player to map
  if player.x<map_start then
    player.x=map_start
  end
  if player.x>map_end-player.w then
    player.x=map_end-player.w
  end
end

function player_animate()
  if player.jumping then
    player.sp=32
  elseif player.falling then
    player.sp=33
  elseif player.running then
    if time()-player.anim>.1 then
      player.anim=time()
      player.sp+=1
      if player.sp<16 then
      	 player.sp=16
      end
      if player.sp>19 then
        player.sp=16
      end
    end
  else --player idle
    if time()-player.anim>.3 then
      player.anim=time()
      player.sp+=1
      if player.sp>1 then
        player.sp=0
      end
    end
  end
end

function limit_speed(num,maximum)
  return mid(-maximum,num,maximum)
end
-->8
--coin animate
function coin_animate()
 if time()-coin.anim>.1 then
 coin.anim=time()
 coin.sp+=1
 if coin.sp<35 then
  coin.sp=35
 end
 if coin.sp>40 then
  coin.sp=35
 end
 end
end
-->8
--outline sprite
function outline_sprite(n,col_outline,x,y,w,h,flip_x,flip_y)
    -- reset palette to col_outline
    for c=1,15 do
      pal(c,col_outline)
    end
    -- draw outline
    
    spr(n,x+1,y,w,h,flip_x,flip_y)
    spr(n,x-1,y,w,h,flip_x,flip_y)
    spr(n,x,y+1,w,h,flip_x,flip_y)
    spr(n,x,y-1,w,h,flip_x,flip_y)
  
    -- reset palette
    pal()
    -- draw final sprite
    spr(n,x,y,w,h,flip_x,flip_y)	
end
__gfx__
00088870000888700000000000000000000440000000000000044000000000000000000000000000cccccccccccccccccccccccccccccccc0000000000000000
00888888008888880000000000044000004444000004400000444400000000000000000000000000ccccccccccccccccccccccccccc00ccc0bbbbbbbbbbbbbb0
0044f1f00044f1f00000000000444400044040200044440004404020000000000000000000000000cccccccccccccccccccccccccc0b30cc03333b33333b3b30
004ff44f004ff44f0000000004404020447222270440402044722227000000000000000000000000ccccccccccccccccccccccccc0b3330c0bb33b3b333333b0
0004fff00884fff00000000044722227444444424472222744444442000000000000000000000000ccccccccccccccccccccccccc033330c0bb33b3b333b3bb0
088add90701add960000000044444442002990004444444200299000000000000000000000000000cccccccccccccccccccccccccc0330cc0bb33b3b3333b3b0
70dddd1600dddd100000000000299000004022000029900000044000000000000000000000000000ccccccccccccccccccccccccccc00ccc0bb33b3b333b3bb0
00440022004400220000000000442200004000000044220000020000000000000000000000000000cccccccccccccccccc000000000330cc0bb33b3b3333b3b0
00088870000000000008887000000000000000000000000000000000000000000000000000000000cccccccccccccccccc0777bbb70330cc0000000000000000
00888888000888700088888800088870000000000000000000000000000000000000000000000000cccccccccccccccccc077b7b7b0330ccc0b333bb333b3b0c
0044f1f0008888880044f1f000888888000000000000000000000000000000000000000000000000ccccccccccccccccccc07b7b7b0330ccc0b333bb33b3bb0c
004ff44f0044f1f0004ff44f0044f1f0000000000000000000000000000000000000000000000000cccccccccccccccccccc0bb7bb0330ccc0b333bb333b3b0c
0884fff6004ff44f0004fff0004ff44f000000000000000000000000000000000000000000000000ccccccccccccccccccccc0bbb70330ccc0b333bb33b3bb0c
071add900004fff000887d900004fff0000000000000000000000000000000000000000000000000cccccccccccccccccccccc07770330ccc0b333bb333b3b0c
00d44d10008add9600dd8d00008add90000000000000000000000000000000000000000000000000ccccccccccccccccccccccc0770330ccc0b333bb33b3bb0c
00000220000442200004400000044220000000000000000000000000000000000000000000000000cccccccccccccccccccccccc070330ccc0b333bb333b3b0c
00088870000888780000000000799900009977000009900000099000000990000099990000000000ccccccccccccccccccccccccc00330ccc0b333bb33b3bb0c
00888880008888800000000007aaaa9009a77a9000aaa90000099000009aa90009aaaa9000000000cccccccccccccccccccccccccc0330ccc0b333bb333b3b0c
0044f1f80044f1f0000000007aa44aa909774a900094970000099000009a490009aa4a9000000000cccccccccccccccccccccccccc0330ccc0b333bb33b3bb0c
004ff44f004ff44f000000009aa49aa907749a900099770000099000009a490009a44a9000000000cccccccccccccccccccccccccc0330ccc0b333bb333b3b0c
0084fff00004fff0000000009aa49aa907a99a900097790000099000009a490009a49a9000000000cccccccccccccccccccccccccc0330ccc0b333bb33b3bb0c
081add00000d8876000000009aa9aaa909a9aa900077a90000099000009a490009a99a9000000000cccccccccccccccccccccccccc0330ccc0b333bb333b3b0c
07dddd220044ddd00000000009aaaa9009aaaa90007aa90000099000009aa90009aaaa9000000000cccccccccccccccccccccccccc0330ccc0b333bb33b3bb0c
04400000000000220000000000999900009999000009900000099000000990000099990000000000cccccccccccccccccccccccccc0330ccc0b333bb333b3b0c
4ffff0f0ffffffff9ffffff7bbbbbbbbffffffff9ffffff7ffffffff000000000077770000777700ffffffffffffffffcccccccccc0330ccc0b333bb33b3bb0c
f44440400000000049ffff7f33b3333b00000000000000000000000000000000087777800b7777b090a99a0900444400cccccccccc0330ccc0b333bb333b3b0c
f444400044044404449999ff033333030000000000000000000000000000000088877888bbb77bbb9a9aa9a904444440cccccccccc0330ccc0b333bb33b3bb0c
f44440ff00000000449999ff0000000000000000000000000000000000000000788888877bbbbbb79aaa9aa904444440cccccccccc0330ccc0b333bb333b3b0c
f04400f404440444449999ff04440444000000000000000000000000000000007788887777bbbb779aaaaaa904444440cccccccccc0330ccc0b333bb33b3bb0c
ff040f4400000000449999ff0000000000000000000000000000000000000000088888800bbbbbb09aaa9aa904444440cccccccccc0330ccc0b333bb333b3b0c
f4f00f44440444044422229f440444040000000000000000000000000000000000eeee000033330090aaaa0900444400cccccccccc0330ccc0b333bb33b3bb0c
40004f44000000004222222900000000000000000000000000000000000000000077770000777700c444444c00000000cccccccccc0330ccc0b333bb333b3b0c
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc044400000444044400000444cccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc000000000000000000000000cccccccccccccccccccccccccccccccc
ccccccc00cccccccccccccc00cccccc00ccccccccccccccccccccccccccccccccccccccc440400000404440400000404cccccccccccccccccccccccccccccccc
cccccc0770cccccccccccc0770cccc0770cccccccccccccccccccccccccccccccccccccc000000000000000000000000cccccccccccccccccccccccccccccccc
ccccc077770cccccccccc077770cc077770ccccccccccccccccccccccccccccccccccccc044400000444044400000444cccccccccccccccccccccccccccccccc
ccccc077d70cccccccccc077d70cc077d70ccccccccccccccccccccccccccccccccccccc000000000000000000000000cccccccccccccccccccccccccccccccc
ccc0077d7d70c0ccccc0077d7d70077d7d70c0cccccccccccccccccccccccccccccccccc440400000404440400000404cccccccccccccccccccccccccccccccc
cc0777d77777070ccc0777d7777777d77777070ccccccccccccccccccccccccc999ccc99999000099990000999900009999ccc99cccccccccccccccccccccccc
c07777777777070cc0777777777777777777070ccccccccccccccccccccccccc049ccc94049404940494049404940494049ccc94cccccccccccccccccccccccc
077d77777d777770077d77777d77777777777770cccccccccccccccccccccccc009ccc90009000900090009000900090009ccc90cccccccccccccccccccccccc
c077dd77d777770cc077dd77d77777777777770ccccccccccccccccccccccccc449ccc94449444944494449444944494449ccc94cccccccccccccccccccccccc
cc0777ddd77d7770cc0777ddd77ddd77d77d7770cccccccccccccccccccccccc0099999000999990009999900099999000999990cccccccccccccccccccccccc
cc0777777dd7770ccc0777777dd777dd7dd7770ccccccccccccccccccccccccc0444044404440444044404440444044404440444cccccccccccccccccccccccc
ccc00770777700ccccc0077077777777777700cccccccccccccccccccccccccc0000000000000000000000000000000000000000cccccccccccccccccccccccc
ccccc00c0770ccccccccc00c077007700770cccccccccccccccccccccccccccc4404440444044404440444044404440444044404cccccccccccccccccccccccc
ccccccccc00cccccccccccccc00cc00cc00ccccccccccccccccccccccccccccc0000000000000000000000000000000000000000cccccccccccccccccccccccc
ccccccccccccccccccccccc000cccc000cccccccccccccc000cccccccccccccc0444044404440444044404440444044404440444cccccccccccccccccccccccc
cccccccccccccccccccccc03330cc03330cccccccccccc03330ccccccccccccc0000000000000000000000000000000000000000cccccccccccccccccccccccc
ccccccccccccccccccccc0333330c033330cccccccccc0333330cccccccccccc4404440444044404440000044404440444044404cccccccccccccccccccccccc
ccccccccccccccccccccc03330330333330cccccccccc033303300cccccccccc0000000000000000000000000000000000000000cccccccccccccccccccccccc
ccccccccccccccccccc003303303333003300cccccc003303303330ccccccccc0444044404440444000000000444044404440444cccccccccccccccccccccccc
cccccccccc0000ccc0033303333333033033300cc003330333330030cccccccc0000000000000000000000000000000000000000cccccccccccccccccccccccc
ccccccccc033330c0333333333333333333333300333333333303330cccccccc4404440444044404000000000404440444044404cccccccccccccccccccccccc
cccccccc03333330c0333333333333333333330cc033333333333330cccccccc0000000000000000000000000000000000000000999ccc99999ccc99999ccc99
ccccccc0333333330cccccccccccccc03333333333333333333333330ccccccc0444044404440444000000000444044404440444049ccc94049ccc94049ccc94
cccccc033333303330cccccccccccc0333333033333333333333303330cccccc0000000000000000000000000000000000000000009ccc90009ccc90009ccc90
ccccc03333333003330cccccccccc033333330033333333333333003330ccccc4404440444044404000000000404440444044404449ccc94449ccc94449ccc94
cccc0333333033033330cccccccc03333330330333333333333033033330cccc0000000000000000000000000000000000000000009999900099999000999990
ccc033333330333333330cccccc0333333303333333333333330333333330ccc0444044404440444000000000444044404440444044404440444044404440444
cc03333333333333333330cccc033333333333333333333333333333333330cc0000000000000000000000000000000000000000000000000000000000000000
c0333333333333333333330cc03333333333333333333333333333333333330c4404440444044404000000000404440444044404440444044404440444044404
03333333333333333333333003333333333333333333333333333333333333300000000000000000000000000000000000000000000000000000000000000000
__gff__
0000000000000000010100000000030300000000000000000000000100000303000000000000000000000000000003030103030303030300000003030000030300000000000000000001010100000000000000000000000001010101010101010000000000000000010101010101010100000000000000000101010101010101
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001010101010101010101000000000000010101010101010101010000000000000101010101010101010101010101010101010101010101010101010101010100
__map__
0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a
0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a
0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a4243440a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a4243440a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a40410a0a
0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a40410a0a0a0a0a0a0a0a0a0a0a0a0a0a0a5253540a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a5253540a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a4243440a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a50510a0a
0a0a0a0a0a0a40410a0a0a0a0a0a0a0a50510a0a0a0a0a0a0a424343440a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a40410a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a40410a0a0a0a0a0a0a0a0a0a0a0a0a0a0a5253540a0a0a0a0a0a0a0a0a0a0a0a0a0a0c0d0a0a40410a0a0a0a0a0a0a0a
0a0a0a0a0a0a50510a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a525353540a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a50510a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a50510a0a0a0a0a0a424343440a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a32320a0a0a0a1c1d0a0a50510a0a0a0a0a0a0a0a
0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a3a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a525353540a0a0a0a0a0a0a0a0a0a0a0a0a0a0a3232320a0a0a0a0a2d0a0a0a0a0a0a0a0a0a0a0a0a
0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a323232320a0a0a0a0a3d0a0a0a6d6e6f0a0a0a0a0a0a
0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a32323232320a0a0a0a0a3d0a0a0a7d7e7f0a0a0a0a0a0a
0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a3a0a0a0a313a313a310a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a3a0a0a0a0a0a0a0a0a0a320a0a320a0a0a0a0a0a0a0a0a0a320a0a320a0a0a0a0a0a0a0a0a0a0a0a0a31313a310a0a0a0a0a0a0a0a0a0a0a0a0a0a0a3232323232320a0a0a0a0a3d0a0a48494a4b4c0a0a0a0a0a
0a60610a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a60610a0a0a0e0f0a0a0a0a0a0a0a0a0a0a0a0a0a0a32320a0a32320a0a0a60610a0a0a32320a0a32320a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a32323232323232610a0a0a0a3d0a0a58595a5b5c0a0a0a0a0a
0a7071720a0a0a0a0a0a0a0a0a0a0a60610a0a0a0a0a0a0a0a0a0a0a0e0f0a0a7071720a0a1e1f0a0a0a0a0a0a0a0a0a0a0a0a0a3232320a0a3232320a0a7071720a3232320a0a3232320a0a60610a0e0f0a0a0a0a0a0a0a0a0a0a0a0a0a0a0e0f0a0a0a0a0a323232323232323271720a0a0a3d0a0a68696a6b6c0a60610a0a
73747576770a0a0a0a0a626363640a7071720a0a0a0a0a65660a0a0a1e1f0a73747576770a2e2f0a0a6263640a0a0a0a0a0a0a3232323263643232323273747576323232320a0a32323232647071721e1f0a0a0a65660a0a0a0a0a0a0a0a0a1e1f0a0a0a0a3232323232323232327576770a0a320a0a78797a7b7c0a7071720a
3030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030300a0a303030303030303030303030303030303030300a0a303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030
3030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030300a0a303030303030303030303030303030303030300a0a303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030
3030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030300a0a303030303030303030303030303030303030300a0a303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000323200000000000000000000000000000000000000
0000000000000000000000000000000000000000003600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000032323200000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003232323200000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000323232323200000000000000000000000000000000000000
00000000000000000000000000000036000000343634363400000000000000000000000000000000000000003a0000000000000000003200003200000000000000000000320000320000000000000000000000000031313a31000000000000000000000000000032323232323200000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000e0f0000000000000000000000000000323200003232000000000000000032320000323200000000000000000000000000000000000000000000000000000000003232323232323200000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000e0f000000000000000000000000000000000000000000003232320000323232000000000000323232000032323200000000000e0f00000000000000000000000000000e0f00000000323232323232323200000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003232323200003232323200000000323232320000323232320000000000000000000000000000000000000000000000000032323232323232323200000000000032000000000000000000000000
3030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030300000303030303030303030303030303030303030300000303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030
3030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030300000303030303030303030303030303030303030300000303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030
3030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030300000303030303030303030303030303030303030300000303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030
