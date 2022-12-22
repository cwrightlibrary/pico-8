pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
--game loop
function _init()
 rain_init()
 p_init()
 --sk_init()
 coin_index={}
 q_brick_index={}
 p_brick_index={}
 brick_break_index={}
 life_one_index={}
 platform_searched=false

 sk_index={}
 sk_small_index={}

 gravity=.2
 friction=.85

 palt(0,false)
 palt(2,true)

 rx1=0 rx2=0
 ry1=0 ry2=0

 cam_x=0
 map_start=0
 map_end=340
 map_end_full=1024
 success=false
 brick_break=false
 broken={
  ceil_x=false,
  flr_x=false,
  sp=156,
  x1=0,
  x2=0,
  x3=0,
  x4=0,
  y=0,
  dx1=0,
  dx2=0,
  dy=0,
  max_dx=2,
  max_dy=3,
  boost=-2,
  spawn=false,
  spawned=true
 }
end

function _update60()
 p_update()
 p_animate()
 rain_update()
 sk_update()
 sk_animate()
 sk_small_update()
 sk_small_animate()
 cam_update()
 coin_update()
 q_brick_update()
 life_one_update()
end

function _draw()
 cls(1)
 rain_draw()
 map(0,0)
 fix_platform()
 add_q_brick()
 add_p_brick()
 add_coin()
 add_brick_coin()
 add_life_one()
 p_draw()
 add_sk()
 add_sk_small()
 break_brick()
 if p.hit 
 and p.y>140 then
  rectfill(cam_x+43,60,cam_x+71,66,0)
  print('press p',cam_x+44,61,7)
 end
 _ui()
end

function add_life_one()
 obj_search('life_one',128)
 for life_one in all(life_one_index) do
  spr(life_one.sp,life_one.x,life_one.y,life_one.w/8,life_one.h/8)
 end
end

function life_one_update()
 if #life_one_index!=0 then
  for life_one in all(life_one_index) do
   life_one.sp+=.07
   if life_one.sp>=62 then
    life_one.sp=59
   end
   if life_one.y<=life_one.start_height-life_one.max_height then
    life_one.top=true
   elseif life_one.y>=life_one.start_height then
    life_one.top=false
   end
   if life_one.top then
    if life_one.y<life_one.start_height-(life_one.max_height/2) then
     life_one.dy+=.015
    else 
     life_one.dy-=.015
    end
   elseif not life_one.top then
    if life_one.y>life_one.start_height-(life_one.max_height/2) then
     life_one.dy-=.015
    else 
     life_one.dy+=.015
    end
   end
   life_one.y+=life_one.dy

   if object_collide(p.x+5,p.y+1,p.x+5+p.w-8,p.y+1+p.h-1,life_one.x,life_one.y,life_one.x+life_one.w,life_one.y+life_one.h)
   and not p.invincible then
    life_one.y-=50
    life_one.start_height-=50
    p.lives+=1
    del(life_one_index,life_one)
   end
  end
 end
end
-->8
--ui
function _ui()
 rectfill(0,0,cam_x+127,8,0)
 for i=1,p.lives do
  spr(45,cam_x+128-(9*i),0,1,1)
 end
 print('lives: ',cam_x+128-54,2,2)
 print('score: '..p.score,cam_x+1,2,9)
end

function break_brick()
 if brick_break then
  local clx=ceil(p.x/8)
  local fly=flr(p.y/8)
  local flx=flr(p.x/8)
  local cly=ceil(p.y/8)
  if broken.ceil_x then
   mset(clx,fly,128)
   broken.ceil_x=false
  end
  if broken.flr_x then
   mset(flx,fly,128)
   broken.flr_x=false
  end
  broken.x1=p.x
  broken.x2=p.x+8
  broken.x3=p.x-2
  broken.x4=p.x+10
  broken.y=p.y
  broken.dx=0
  broken.dy=0
  broken.spawn=true
  broken.spawned=true
  brick_break=false
 end
 if broken.spawn then
  spr(broken.sp,broken.x1,broken.y-13,1,1,false,false)
  spr(broken.sp,broken.x2,broken.y-15,1,1,true,false)
  spr(broken.sp,broken.x3,broken.y-7,1,1,false,false)
  spr(broken.sp,broken.x4,broken.y-9,1,1,true,false)
  broken.dy+=gravity
  if broken.spawned then
   broken.dy=broken.boost
   broken.dx1=broken.boost/1.2
   broken.dx2=-broken.boost/1.2
   broken.spawned=false
  end
  if broken.dy>0 then
   limit_speed(broken.dy,broken.max_dy)
  end
  if broken.y>150 then
   broken.spawn=false
  end
 end
 broken.dx1/=1.2
 broken.dx2/=1.2
 if broken.dx1<0 then
  limit_speed(broken.dx1,broken.max_dx)
 end
 if broken.dx2>0 then
  limit_speed(broken.dx2,broken.max_dx)
 end
 broken.x1+=broken.dx1
 broken.x2+=broken.dx2
 broken.x3+=broken.dx1
 broken.x4+=broken.dx2
 broken.y+=broken.dy
end
-->8
--player
function p_init()
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
  running=false,
  sliding=false,
  landed=false,
  jumping=false,
  falling=false,
  looper=false,
  idle=true,
  waiting=0,
  acc=.2,
  boost=2,
  higher_boost=.75,
  jump_hold=0,
  jump_hold_time=0,
  jump_held=false,
  score=0,
  hit=false,
  hit_hold=0,
  hit_up=10,
  hit_down=.7,
  hit_tip='',
  lives=3,
  hurt_loop=false,
  invincible=false,
  invincible_timer=150,
  invincible_sp_switch=false,
  invincible_sp_flash=5
 }
end

function p_update()
 p.dy+=gravity
 p.dx*=friction
 --input 
 --move left/right
 if not btn(0)
 and not btn(1)
 and not btn(2)
 and not btn(3)
 and not btn(4)
 and not p.jumping
 and not p.falling
 and not p.sliding then
  p.idle=true
 else
  p.idle=false
 end
 if p.lives>0 then
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
  if btn(4)
  and p.landed
  and not p.jump_held then
   p.jump_held=true
   sfx(0)
   p.dy-=p.boost 
   p.landed=false
  elseif btn(4)
  and p.jumping then
   if time()-p.jump_hold_time>.05 then
    p.jump_hold_time=time()
    if p.jump_hold<3 then
     p.jump_hold+=1
     p.dy-=p.higher_boost
    end
    if p.jump_hold>3 then
     p.jumping=false
     p.falling=true
    end
   end
  end
  if p.landed then
   p.jump_hold=0
   p.jump_hold_time=0
  end
  if not btn(4) then
   p.jump_held=false
  end
  if btn(5) 
  and not p.hit then
   p.max_dx=2.5
  elseif not btn(5)
  and not p.hit then
   p.max_dx=1.25
  elseif p.hit 
  and p.lives>0 then
   p.max_dx=8
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
   or (map_collision(p,'down',1)
   and map_collision(p,'down_more',1)) then
    p.landed=true
    p.falling=false
    p.dy=0
    p.y-=((p.y+p.h+1)%8)-1
   end
  --up
  elseif p.dy<0 then
   p.jumping=true
   if map_collision(p,'up',0)
   and not map_collision(p,'up',7) then
    sfx(3)
    p.dy=0
   end
   if map_collision(p,'up',7) then
    local clx=ceil(p.x/8)
    local fly=flr(p.y/8)
    local flx=flr(p.x/8)
    local cly=ceil(p.y/8)

    if (mget(clx,fly)==144
    and mget(flx,fly)==144)
    or (mget(clx,fly)==144
    and mget(flx,fly)!=144) then
     broken.ceil_x=true
     brick_break=true
     sfx(-1,2)
     sfx(5,2)
     p.dy=0
    elseif mget(flx,fly)==144
    and mget(clx,fly)!=144 then
     broken.flr_x=true
     brick_break=true
     sfx(-1,2)
     sfx(5,2)
     p.dy=0
    end
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
  --limit to map
  if p.x<0 then
   p.x=0
  elseif p.x>451 then
   p.x=451
  end
 elseif p.hit
 and p.lives<1 then
  if p.hit_hold<25 then
   if time()-p.anim>.03 then
    p.anim=time()
    p.hit_up*=.7
    if p.hit_up>.1 then
     p.y-=p.hit_up
    else
     p.hit_hold+=1
    end
   end
  else
   if time()-p.anim>.03 then
    p.anim=time()
    if p.hit_down<10 then
     p.hit_down*=1.1
     end
     if p.y<140 then
      p.y+=p.hit_down
     else
    end
   end
  end
 end
end

function p_animate()
 if (p.invincible and p.invincible_sp_switch)
 or not p.invincible then
  if p.running 
  and p.landed then
   p.waiting=0
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
    p.waiting=0
    p.sp=11
   else
    if p.sp>10 then
     p.sp=1
    end
    if p.waiting<rnd(540)+300 then
     p.waiting+=1
    else
     if time()-p.anim>.1 then
      p.anim=time()
      if p.looper==false then
       p.sp+=2
       if p.sp>=9 then
        p.looper=true
       end
      elseif p.looper==true then
       p.sp-=2
       if p.sp<=1 then
        p.sp=1
        p.looper=false
        p.waiting=0
      end
     end
    end
   end
  end
 elseif not p.invincible_sp_switch then
  p.sp=103
 end
 if p.hit
 and p.lives<1 then
  p.sp=13
 end
 if p.invincible then
  if p.invincible_timer>0 then
   p.invincible_timer-=1
  else
   p.invincible=false
   p.invincible_timer=200
  end
  if p.invincible_sp_flash>0 then
   p.invincible_sp_flash-=1
  else
   p.invincible_sp_switch=not p.invincible_sp_switch
   p.invincible_sp_flash=5
  end
 end
end

function p_draw()
  spr(p.sp,p.x,p.y,p.w/8,p.h/8,p.flp)
end
-->8
--skeleton
function sk_update()
 if #sk_index!=0 then
  for sk in all(sk_index) do
   if not sk.switch then
    if sk.hold<100 then
     sk.hold+=1
    else
     sk.hold=0
     sk.is_waiting=true
    end
   else
    if sk.hold<100 then
     sk.hold+=1
    else
     sk.hold=0
     sk.is_waiting=false
    end
   end
   if sk.is_waiting then
    if not sk.hit then
     sk.flp=true
     sk.dx-=.04
     sk.switch=not sk.switch
    end
   else
    if not sk.hit then
     sk.flp=false
     sk.dx+=.04
     sk.switch=not sk.switch
    end
   end
   if sk.dx>0 
   or sk.dx<0 then
    sk.dx=limit_speed(sk.dx,sk.max_dx)
   end
   if sk.hit then
    sk.dx=0
    if not sk.added_coin then
     add_object('coin',sk.x/8,sk.y/8-3.5,8,8)
     sfx(6)
     sk.added_coin=true
    end
   end
   sk.x+=sk.dx
   if object_collide(p.x+2,p.y+p.h,p.x+2+p.w-4,p.y+p.h+1,sk.x+1,sk.y+2,sk.x+1+sk.w-2,sk.y+3) 
   and not p.jumping 
   and p.falling
   and not p.invincible then
    if sk.hit==false then
     p.dy=-p.boost
     sk.hit=true
    end
   elseif object_collide(p.x+3,p.y+1,p.x+3+p.w-6,p.y+1+p.h-1,sk.x+3,sk.y+3,sk.x+3+sk.w-6,sk.y+3+sk.h-3)
   and not object_collide(p.x+2,p.y+p.h,p.x+2+p.w-4,p.y+p.h+1,sk.x+1,sk.y+2,sk.x+1+sk.w-2,sk.y+3) 
   and not sk.hit
   and p.lives>0
   and not p.invincible then
    p.score-=25
    sfx(7)
    p.invincible=true
    p.hit=true
    p.hurt_loop=true
    p.dy=-p.boost
    if p.x<sk.x then
     p.dx=-p.boost*2
    else 
     p.dx=p.boost*2
    end
    p.lives-=1
   elseif not object_collide(p.x+2,p.y+p.h,p.x+2+p.w-4,p.y+p.h+1,sk.x+1,sk.y+2,sk.x+1+sk.w-2,sk.y+3) 
   and not sk.hit
   and p.hit
   and p.lives>0 then
    if sk.hit_wait>0 then
     sk.hit_wait-=1
    else
     p.hit=false
    end
   end
   if p.max_dx<3 then
    sk.hit_wait=50
   end
   local despawn_timer=50
   if sk.hit then
    if despawn_timer>0 then
     despawn_timer-=1
    else
     del(sk_index,sk)
    end
   end
  end
 end
end

function sk_animate()
 if #sk_index!=0 then
  for sk in all(sk_index) do
   if time()-sk.anim>.1 
   and abs(sk.dx)>.16 
   and not sk.hit then
    sk.anim=time()
    if sk.sp==64 then
     sk.forward=not sk.forward
    end
    if sk.sp==72 then
     sk.forward=not sk.forward
    end
    if sk.forward then
     sk.sp+=2
    else
     sk.sp-=2
    end
   elseif sk.hit then
    sk.sp=100
   end
  end
 end
end

function add_sk()
 obj_search('sk',128)
 for sk in all(sk_index) do
  spr(sk.sp,sk.x,sk.y,sk.w/8,sk.h/8,sk.flp)
 end
end

function sk_small_update()
 if #sk_small_index!=0 then
  for sk_small in all(sk_small_index) do
   if not sk_small.switch then
    if sk_small.hold<150 then
     sk_small.hold+=1
    else
     sk_small.hold=0
     sk_small.is_waiting=true
    end
   else
    if sk_small.hold<150 then
     sk_small.hold+=1
    else
     sk_small.hold=0
     sk_small.is_waiting=false
    end
   end
   if sk_small.is_waiting then
    if not sk_small.hit then
     sk_small.flp=true
     sk_small.dx-=.025
     sk_small.switch=not sk_small.switch
    end
   else
    if not sk_small.hit then
     sk_small.flp=false
     sk_small.dx+=.025
     sk_small.switch=not sk_small.switch
    end
   end
   if sk_small.dx>0 
   or sk_small.dx<0 then
    sk_small.dx=limit_speed(sk_small.dx,sk_small.max_dx)
   end
   if sk_small.hit then
    sk_small.dx=0
    if not sk_small.added_coin then
     add_object('coin',sk_small.x/8,sk_small.y/8-3.5,8,8)
     sfx(6)
     sk_small.added_coin=true
    end
   end
   sk_small.x+=sk_small.dx
   if object_collide(p.x+2,p.y+p.h,p.x+2+p.w-4,p.y+p.h+1,sk_small.x,sk_small.y,sk_small.x+sk_small.w,sk_small.y+1)
   and not p.jumping
   and p.falling 
   and not p.invincible then
    if not sk_small.hit then
     p.dy=-p.boost
     sk_small.hit=true
    end
   elseif object_collide(p.x+3,p.y+1,p.x+3+p.w-6,p.y+1+p.h-1,sk_small.x+2,sk_small.y,sk_small.x+sk_small.w,sk_small.y+2+sk_small.h-4)
   and not object_collide(p.x+2,p.y+p.h,p.x+p.w-2,p.y+p.h+1,sk_small.x,sk_small.y,sk_small.x+sk_small.w-2,sk_small.y+1)
   and not sk_small.hit
   and p.lives>0
   and not p.invincible then
    sfx(7)
    p.invincible=true
    p.score-=25
    p.hit=true
    p.hurt_loop=true
    p.dy=-p.boost
    if p.x<sk_small.x then
     p.dx=-p.boost*2
    else
     p.dx=p.boost*2
    end
    p.lives-=1
   elseif not object_collide(p.x+2,p.y+p.h,p.x+p.w-2,p.y+p.h+1,sk_small.x,sk_small.y,sk_small.x+sk_small.w-2,sk_small.y+1)
   and not sk_small.hit
   and p.hit
   and p.lives>0 then
    if sk_small.hit_wait>0 then
     sk_small.hit_wait-=1
    else
     p.hit=false
    end
   end
    if p.max_dx<3 then
     sk_small.hit_wait=50
   end
  end
 end
end

function sk_small_animate()
 if #sk_small_index!=0 then
  for sk_small in all(sk_small_index) do
   if time()-sk_small.anim>.1 
   and abs(sk_small.dx)>.16
   and not sk_small.hit then
    sk_small.anim=time()
    if sk_small.sp==96 then
     sk_small.forward=not sk_small.forward
    end
    if sk_small.sp==99 then
     sk_small.forward=not sk_small.forward
    end
    if sk_small.forward then
     sk_small.sp+=1
    else
     sk_small.sp-=1
    end
   elseif sk_small.hit then
    sk_small.sp=112
   end
  end
 end
end

function add_sk_small()
 obj_search('sk_small',128)
 for sk_small in all(sk_small_index) do
  spr(sk_small.sp,sk_small.x,sk_small.y,sk_small.w/8,sk_small.h/8,sk_small.flp)
 end
end
-->8
--coins/bricks/platforms
function add_coin()
 obj_search('coin',128)
 for coin in all(coin_index) do
  spr(coin.sp,coin.x,coin.y,coin.w/8,coin.h/8)
 end
end

function add_brick_coin()
 if brick_coin_draw_again then
  for coin in all(coin_index) do
   spr(coin.sp,coin.x,coin.y,coin.w/8,coin.h/8)
   brick_coin_draw_again=false
  end
 end
end

function coin_update()
 if #coin_index!=0 then
  for coin in all(coin_index) do
   --animation
   coin.sp+=.15
   if coin.sp>=184
   and coin.shimmer<coin.no_shimmer_length then
    coin.shimmer+=1
    coin.sp=181
   end
   if coin.sp>188
   and coin.shimmer==coin.no_shimmer_length then
    coin.sp=181
    coin.shimmer=0
    coin.no_shimmer_length=flr(rnd(8))+3
   end
   if object_collide(p.x+5,p.y+1,p.x+5+p.w-8,p.y+1+p.h-1,coin.x,coin.y,coin.x+coin.w,coin.y+coin.h) then
    coin.y=-10
    sfx(1)
    p.score+=100
    del(coin_index,coin)
   end
   --update
   coin.anim=time()
   coin.dy+=gravity/4
   if coin.dy>0 then
    limit_speed(coin.dy,coin.max_dy)
    if not coin.bounce
    and coin.bounces<5 then
     coin.bounces+=1
     if coin.bounces>0 then
      coin.boost/=1.25
     end
     coin.bounce=true
    end
   end
   if coin.spawned then
    coin.dy=coin.boost/1.15
    coin.spawned=false
   end
   local mx=coin.x/8
   local my=coin.y/8+1
   if fget(mget(mx,my),0) then
    --coin.dy=0
    if coin.bounce then
     coin.dy=coin.boost
     coin.bounce=false
    else
     coin.dy=0
    end
   end
   coin.y+=coin.dy
   end
 end
end

function add_q_brick()
 local searched=false
 if not searched then
  obj_search('q_brick',177)
  searched=true
 end
 for q_brick in all(q_brick_index) do
  if not q_brick.fin then
   spr(q_brick.sp,q_brick.x,q_brick.y,q_brick.w/8,q_brick.h/8)
  else
   mset(q_brick.x/8,q_brick.y/8,155)
   pset(q_brick.x,q_brick.y,6)
   pset(q_brick.x+7,q_brick.y,6)
   pset(q_brick.x,q_brick.y+7)
   pset(q_brick.x+7,q_brick.y+7)
  end
 end
end

function add_p_brick()
 obj_search('p_brick',155)
 for p_brick in all(p_brick_index) do
  mset(p_brick.x,p_brick.y,155)
  testx=p_brick.x
  texty=p_brick.y
  coloris=pget(p_brick.x,p_brick.y-1)
  if pget(p_brick.x,p_brick.y-1)==6 then
   pset(p_brick.x,p_brick.y,6)
   pset(p_brick.x+7,p_brick.y,6)
   pset(p_brick.x,p_brick.y+7,6)
   pset(p_brick.x+7,p_brick.y+7,6)
  end
 end
end

function q_brick_update()
 if #q_brick_index!=0 then
  for q_brick in all(q_brick_index) do
   --animation
   if q_brick.start then
    q_brick.sp+=.15
    if q_brick.sp>143 then
     q_brick.sp=138
    end
   elseif q_brick.hit
   and not q_brick.apex then
    q_brick.sp=154
   elseif q_brick.finish then
    q_brick.sp=155
   end
   --update
   if object_collide(p.x+7,p.y+1,p.x+p.w-7,p.y+1+p.h-2,q_brick.x,(q_brick.y)+8,q_brick.x+q_brick.w,(q_brick.y)+9)
   and (p.jumping or p.dy<0)
   and q_brick.start then
    sfx(2)
    q_brick.hit=true
    p.dy=0
    p.y+=1
   end
   brick_hit_move(q_brick)
   if q_brick.hit and not q_brick.added_coin then
    add_object('coin',q_brick.x/8,q_brick.y/8-1.5,8,8)
    q_brick.added_coin=true
   end
  end
 end
end

function brick_hit_move(brick)
 if brick.hit then
  brick.start=false
  if time()-brick.anim>.1 then
   if brick.y>=brick.max_y then
    brick.speed_up/=brick.slow_down
    brick.y-=brick.speed_up
   else
    brick.apex=true
    brick.hit=false
   end
  end
 elseif brick.apex then
  if time()-brick.anim>.1 then
   if brick.y<brick.init_y then
    brick.speed_down*=brick.fast_down
    brick.y+=brick.speed_down
   else
    brick.y=brick.init_y
    brick.finish=true
    brick.apex=false
   end
  end
 end
end

function fix_platform()
 if not platform_searched then
  for x=0,127 do
   for y=0,15 do
    if mget(x,y)==159 then
     if mget(x+1,y)==128 then
      for sx=x,x+7 do
       for sy=y,y+7 do
        if (y<4) then
         pset(sx,sy,6)
        end
       end
      end
     end
    elseif mget(x,y)==175 then
     if mget(x+1,y)==128 then
      for sx=x+3,x+7 do
       for sy=y,y+7 do
        pset(sx,sy,6)
       end
      end
     end
    end
   end
  end
  platform_searched=true
 end
end
-->8
--rain
function rain_init()
 local screen_size=128
 raincol=7
 rainx={}
 rainy={}
 for i=1,8 do
  rain_init_loop(50*i,screen_size*i)
 end
end

function rain_init_loop(num,screen_size)
 local block=64
 for i=(num-49),num do
  add(rainx,(num-50))
  add(rainy,flr(rnd(screen_size+block)-screen_size-block))
 end
 rainx[(num-49)]=screen_size-(block*3)
 for i=(num-48),num do
  rainx[i]=rainx[i-1]+(flr(3+(rnd(7))))
 end
end

function rain_update()
 local screen_size=128
 for i=1,8 do
  rain_update_loop(50*i,screen_size*i)
 end
end

function rain_update_loop(num,screen_size)
 block=64
 for i=(num-49),num do
  rainx[i]+=2
  rainy[i]+=2
  if rainy[i]>128 then
   randomx=flr(rnd(screen_size+block)-block)
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
--object searching by map tile
function obj_search(obj_name,cell_replace)
 local searched=false
 if not searched then
  for x=0,127 do
   for y=0,15 do
    if obj_name=='coin' then
     if mget(x,y)==181 then
      add_object('coin',x,y,8,8)
      mset(x,y,cell_replace)
     end
    elseif obj_name=='sk' then
     if mget(x,y)==64 then
      add_object('sk',x,y,16,16)
      mset(x,y,cell_replace)
     end
    elseif obj_name=='sk_small' then
     if mget(x,y)==96 then
      add_object('sk_small',x,y,8,8)
      mset(x,y,cell_replace)
     end
    elseif obj_name=='q_brick' then
     if mget(x,y)==138 then
      add_object('q_brick',x,y,8,8)
      mset(x,y,cell_replace)
     end
    elseif obj_name=='life_one' then
     if mget(x,y)==59 then
      add_object('life_one',x,y,8,8)
      mset(x,y,cell_replace)
     end
    end
   end
  end
  searched=true
 end
end
--add object
function add_object(obj_name,objx,objy,objw,objh)
 if obj_name=='coin' then
  local coin={
   sp=181,
   x=objx*8,
   y=objy*8,
   w=objw,
   h=objh,
   dx=0,
   dy=0,
   max_dx=2,
   max_dy=.001,
   spawned=true,
   bounce=true,
   boost=-1.1,
   falling=false,
   bounces=0,
   landed=false,
   shimmer=0,
   no_shimmer_length=flr(rnd(8))+3,
   anim=0,
  }
  add(coin_index,coin)
 elseif obj_name=='sk' then
  local newx=objx*8
  local newy=objy*8
  local sk={
   sp=64,
   x=newx,
   y=newy,
   w=objw,
   h=objh,
   flp=false,
   dx=0,
   dy=0,
   max_dx=.4,
   max_dy=4,
   anim=0,
   hold=0,
   switch=false,
   is_waiting=false,
   forward=false,
   falling=false,
   landed=true,
   boost=3,
   hit=false,
   added_coin=false,
   hit_wait=50
  }
  add(sk_index,sk)
 elseif obj_name=='sk_small' then
  local newx=objx*8
  local newy=objy*8
  local sk_small={
   sp=96,
   x=newx,
   y=newy,
   w=objw,
   h=objh,
   flp=false,
   dx=0,
   dy=0,
   max_dx=.25,
   max_dy=4,
   anim=0,
   hold=0,
   switch=false,
   is_waiting=false,
   forward=false,
   falling=false,
   landed=true,
   boost=3,
   hit=false,
   added_coin=false,
   hit_wait=50
  }
  add(sk_small_index,sk_small)
 elseif obj_name=='q_brick' then
  local newy=objy*8
  local q_brick={
   sp=138,
   x=objx*8,
   y=objy*8,
   init_y=objy*8,
   max_y=(objy*8)-2,
   w=objw,
   h=objh,
   anim=0,
   hold=0,
   start=true,
   hit=false,
   apex=false,
   finish=false,
   speed=.8,
   speed_low=.03,
   speed_up=.8,
   speed_down=.03,
   slow_down=1.01,
   fast_down=1.7,
   added_coin=false
  }
  add(q_brick_index,q_brick)
 elseif obj_name=='broken' then
  local broken={
   sp=156,
   x1=0, x2=0, x3=0,x4=0,
   y=0,
   dx1=0, dx2=0,
   dy=0,
   max_dx=2,
   max_dy=3,
   boost=-2,
   spawn=false,
   spawned=true,
   ceil_x=false,
   flr_x=false
  }
  add(brick_break_index,broken)
 elseif obj_name=='life_one' then
  local life_one={
   sp=59,
   x=objx*8,
   y=objy*8,
   w=objw,
   h=objh,
   dx=0,
   dy=0,
   anim=0,
   top=false,
   start_height=objy*8,
   max_height=7,
   speed_down=.7,
   speed_up=.7,
  }
  add(life_one_index,life_one)
 end
end
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
 --create player hitbox
 if aim=='left' then
  x1=x+2   x2=x+3
  y1=y+1   y2=y+h-2
 elseif aim=='right' then
  x1=x+w-3 x2=x+w-4
  y1=y+1   y2=y+h-2
 elseif aim=='up' then
  x1=x+6   x2=x+w-6
  y1=y-1   y2=y
 elseif aim=='down' then
  x1=x+7   x2=x+w-8
  y1=y+h-1 y2=y+h+1
 elseif aim=='down_more' then
  x1=x+7   x2=x+w-8
  y1=y+h y2=y+h+4
 elseif aim=='coin' then
  x1=obj.x       x2=obj.x+obj.w
  y1=obj.y+obj.h y2=obj.y+2
 elseif aim=='up_break' then
  x1=x+8   x2=x+w-7
  y1=y-1   y2=y
 end
 --rx1=x1 rx2=x2
 --ry1=y1 ry2=y2
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
--hitbox collision
function object_collide(player_x1,player_y1,player_x2,player_y2,enemy_x1,enemy_y1,enemy_x2,enemy_y2)
 local collide_1=player_y1<=enemy_y2
 local collide_2=player_y2>=enemy_y1
 local collide_3=player_x1<=enemy_x2
 local collide_4=player_x2>=enemy_x1

 if collide_1 and collide_2
 and collide_3 and collide_4 then
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
__gfx__
00000000222222222222222222222222222222222222222222222222222222222222222222222222222222222222200000022222222222222222222222222222
00000000222220000002222222222000000222222222200000022222222220000002222222222000000222222222000000002222222220000002222222222222
00700700222200000000222222220000000022222222000000002222222200000000222222220000000022222222004444402222222200000000222222222222
00077000222200444440222222220044444022222222004444402222222200444440222222220400440022222222040044002222222204444440222222222222
00077000222204004400222222220400440022222222040044002222222204004400222222220077007702222222007700770222222200044000222222222222
00700700222200770077022222220077007702222222007700770222222200770077022222200077000702222220007700070222222207700770222222222222
00000000222000770007022222200077000702222220007700070222222000770007022222220400440040222220040044000022220007700070002222222222
00000000222204004400022222220400440002222222040044000222222204004400022222222044444002222204004444400402204000044000040222222222
00000000222220444440222222222044444022222222204444402022222220444440402222222044444002222220dd00000000222200d044440d002222222222
0000000022220d000000222222220d000000222222220d000000040222220d000000022222220d0000002222222200ed0e00222222220d0000d0222222222222
000000002220d0ed0e0d02222220d0ed0e0002222220d0ed0e0d00222220d0ed0e0002222220d0ed0e022222222220dedd022222222220ed0e02222222222222
00000000222000dedd000222222000dedd004022222000dedd002222222000dedd022222222000dedd0222222222200000002222222220dedd02222222222222
00000000222040000004022222204000000202222220400000022222222040000002222222204000000222222222200000002222222220000002222222222222
00000000222200000000222222220000000222222222000000022222222200000002222222220000000222222222090020902222222200000000222222222222
00000000222220900902222222222090090222222222209009022222222220900902222222222090090222222222002220022222222090022009022222222222
00000000222222002002222222222200200222222222220020022222222222002002222222222200200222222222222222222222222200222200222222222222
00000000222220000002222222222222222222222222222222222222222220000002222222222000000222222222222222222222dddddddd2222222222222222
00000000222200000000222222222000000222222222200000022222222200000000222222220000000022222222222222222222dd0000dd2222222222222222
00000000222200444440222222220000000022222222000000002222222200444440222222220044444022222222222222222222d004400d2222222222222222
00000000222204004400222222220044444022222222004444402222222204004400222222220400440022222222222222222222d070070d2222222222222222
00000000222200770077022222220400440022222222040044002222222200770077022222220077007702222222222222222222d004400d2222222222222222
00000000222000770007022222220077007702222222007700770222222000770007022222200077000702222222222222222222d044440d2222222222222222
00000000222204004400022222200077000702222220007700070222222204004400022222220400440002222222222222222222dd0000dd2222222222222222
00000000222220444440222222220400440002222222040044000222222220444440222222222044444022222222222222222222dddddddd2222222222222222
0000000022220d00000022222222204444402222222220444440222222220d000000222222220d00000022222002200222000022222002222200002222222222
000000002220d0ed0e0d022222220d000000222222220d00000022222220d0ed0e0d02222220d0ed0e0d02220880008020800002222000222080000222222222
00000000220400dedd0040222220d0ed0e0d02222220d0ed0e0d0222220400dedd004022220400dedd0040220800770020007702220077022000770222222222
000000002220200000000222220400dedd004022220400dedd004022222020000002022222202000000002220070070020700702207007022070070222222222
00000000222220002000022222202000000002222220200000020222222220000002222222222000000022220777070007770702077707020777070222222222
00000000222220002209022222222000200022222222200000022222222222000090222222222090009022220070777020707770207077702070777022222222
00000000222209022200222222220902220902222222209090022222222220900002222222222002200222222008000022080002220000022208000222222222
00000000222220222222222222222002220002222222220000222222222220022222222222222222222222222220002222200022222002222220002222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222dddddddd660000000000000000000066666666660ddddddd
22222222222222222222222222222222222222222222222222222222222222222222222222222222dddddddd60dddddddddddddddddddd06666666660ddddddd
22222222222222222222222222222222222222222222222222222222222222222222222222222222dddddddd0dd00dddddddddddddd00dd0666666660ddddddd
22222000000222222222200000022222222220000002222222222000000222222222200000022222dddddddd0d0f00dddddddddddd00f0d0666666660ddddddd
2222077777702222222207777770222222220777777022222222077777702222222207777770222200dddddd0d00f0dddddddddddd0f00d0006666660ddddddd
22207777777702222220777777770222222077777777022222207777777702222220777777770222000ddddd0dd00dddddddddddddd00dd0000666660ddddddd
22207777777770222220777777777022222077777777702222207777777770222220777777777022000ddddd0dddddddddddddddddddddd0000666660ddddddd
22207770777070222220777077707022222077707770702222207770777070222220777077707022000ddddd0dddddddddddddddddddddd0000666660ddddddd
22207770070070222220777007007022222077700700702222207770070070222220777007007022000ddddd0dddddddddddddddddddddd000066666ddddddd0
22220770870870222222077087087022222207708708702222220770870870222222077087087022000ddddd0dddddddddddddddddddddd000066666ddddddd0
22222077777700222222207777770022222220777777002222222077777700222222207777770022000ddddd0dd00dddddddddddddd00dd000066666ddddddd0
22220006070702222222000707070222222200070707022222222007070702222222200707070222000ddddd0d00f0dddddddddddd0f00d000066666ddddddd0
22200110000002222220011000000222222201100000022222222010000002222222201000000222000ddddd0d0f00dddddddddddd00f0d000066666ddddddd0
22050011000050222205001100005022222050110005022222222001050222222222200105022222000ddddd0dd00dddddddddddddd00dd000066666ddddddd0
22200000000002222220200000020222222200000000222222222000000222222222000000002222000ddddd00dddddddddddddddddddd0000066666ddddddd0
22220022220022222222200220022222222222000022222222222002200222222222002222002222000ddddd60000000000000000000000000066666ddddddd0
20000022200000222000002220000022222222222222222222222222222222222222222222222222000ddddd20000000000000000000002222222222dddddddd
07777702077777020777770207777702222222222222222222222222222222222222222222222222000ddddd00dddddddddddddddddddd0222222222dddddddd
07005070070050700700507007005070222222222222222222222222222222222222222222222222000ddddd0dd00dddddddddddddd00dd022222222dddddddd
07080870070808700708087007080870222222222222222222222222222222222222222222222222000ddddd0d0f00dddddddddddd00f0d022222222dddddddd
20777702207777022077770220777702222222000022222222222222222222222222222222222222000ddddd0d00f0dddddddddddd0f00d000222222dddddddd
20070702200707022007070220070702222220777700222222222222222222222222222222222222000ddddd0dd00dddddddddddddd00dd000022222dddddddd
00000000000000002000002220000022222207777070022222222222222222222222222222222222000ddddd0dddddddddddddddddddddd000022222dddddddd
20020022220002222002002222000222222207777007022222222222222222222222222222222222000000000dddddddddddddddddddddd00002222200000000
22222222222222222222222222222222222077777007702222222222222222222222222222222222000000dd0dddddddddddddddddddddd000022222dddddddd
22000022222222222222222222222222222077770777000222222222222222222222222222222222dddddd0d0dddddddddddddddddddddd000022222dddddddd
20777002222222222222222222222222222077700077700222222222222222222222222222222222ddd00dd00dd00dddddddddddddd00dd000022222dddddddd
07700502222222222222222222222222222077770070002222222222222222222222222222222222dd00f0d00d00f0dddddddddddd0f00d000022222dddddddd
07005700222222222222222222222222220007777777002222222222222222222222222222222222dd0f00d00d0f00dddddddddddd00f0d000022222dddddddd
07777070222222222222222222222222200100777000000222222222222222222222222222222222ddd00dd00dd00dddddddddddddd00dd000022222dddddddd
00007000222222222222222222222222050110000011105022222222222222222222222222222222ddddddd020dddddddddddddddddddd0000022222dddddddd
00000000222222222222222222222222200000000000020022222222222222222222222222222222ddddddd022000000000000000000000000022222dddddddd
66666666666666666666666666666666666666666600000000000000000000000000000000000000200000022000000220000002200000022000000220000002
666666666666666666666666666666666666666660009999999999999999999999999999999999900aaaaaa00aaaaaa00aaaaaa00aaaaaa00aaaaaa00aaaaaa0
666666666555555555555555555555566666666660900000000000000000000000000000000000000a9779400a9977400a99977007999970077999400a779940
666666666444444444444444444445566666666600900aa000660030aa000080003380088000aa000a7997400a979970079979400a7997400a97997007997940
666666666422222222222222222245566666666609000a9088660c00aa00038000008cc00000a9000a9979400a9997400a999970079999400a7999400a979940
666666666422222222222222222245566666666009000a9088660c30aa00338000338cc88600a9000a9999400a9999400a9999400a9999400a9999400a999940
66666666642222222222222222224556666666609400044088660c00aa03308000008cc0060044000a4474400a4447400a444470074444400a74444004474440
66666666642222222222222222224556666666009000000088660c30aa33008000338cc886000000200000022000000220000002200000022000000220000002
00000000642222222222222222224556666666090400a9909999999999999999999999999990a990200000022000000222222222600000062222222222222222
0f0990f06422222222222222222245566666600940000a94000000000000000000000000000a940007777790077aaaa022222222077aaaa02222222222222222
0f0990f0642222222222222222224556666660940400000066cc000000000660000000005500000007aaaa900799994022000022079999402222222222222222
000000006422222222222222222245566666609440000aa000cc008000000000c00000030000aa0007aaaa900a999940220090220a9999402222222222222222
0f9909906422222222222222222245566666009404000a90660cc08066000660ca0008835500a90007aaaa900a999940220090220a9999402222222222222222
0f9909906422222222222222222245566666094440000a90660cc08066000660caa008835500a90007aaaa900a999940220000220a9999402222222222222222
0f99099064222222222222222222455666660944040004400000cc8066000000c0aa088300004400099999900444444022222222044444402222222222222222
0000000064222222222222222222455666600944400000006600cc8066000660c00aa88355000000200000022000000222222222600000062222222222222222
11111111642222222222222222224556666094440400000099999999999999999999999999400000222222222222222222222222222222222222222222222222
111111116422222222222222222245566660944440000aa09444444444444444444444444440aa00222222222222222222222222222222222222222222222222
dd1ddddd6422222222222222222245566660944404000a900000000000000000000000000000a900222222222222222222222222222222222222222222222222
dddddddd64222222222222222222455666609444400004400aaaaaaaaa0aaaaaaa0aaaaaaa004400222222222222222222222222222222222222222222222222
ddddd1dd64222222222222222222455666609444040000000a999990040a0099940a009994000000222222222222222222222222222222222222222222222222
dd1ddddd6444444444444444444445566660944440000a900a999999940a9999940a99999400a900222222222222222222222222222222222222222222222222
dddddddd666666666666666666666666666094440400a994044444444404444444044444440a4440222222222222222222222222222222222222222222222222
dddd1ddd666666666666666666666666666094440000000000000000000000000000000000000000222222222222222222222222222222222222222222222222
66666a96666666662222222222224556666094442211112222211222222112222221122222771122222112222221122222211222222222222222222222222222
6666a96666666666222222222222455666609444219aaa122219a1222219a122221a9122279aaa12221977222219a122221a9122222222222222222222222222
6669a66666666666222222222222455666609444199449a121999a122219a12221a99912799449a121977a122219a12221a99912222222222222222222222222
660890666666666622222222222245566660944419499a912194a9122219a122219a491219499a912177a9122219a722219a4912222222222222222222222222
601001066666666622222222222245566660944419499a912194a9122219a122219a491219499a912774a91222197722219a4972222222222222222222222222
6601106666666666444444444444455666609444149aa991214999122219a12221999412149aa991274999122217712221999472222222222222222222222222
660110666666666600066666000666666660944421444912221491222219a1222219412221444912221491222277a12222194722222222222222222222222222
66600666666666660006666600066666666000002211112222211222222112222221122222111122222112222221122222277222222222222222222222222222
__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004040404040404040404000202020000000000000000000000000000000000000404040400000000000000020202000004000000000000000000020000000000
0000000000020202020203030303030383000000000000000000030300030000030000000000000000000000000000000303000000040404040404040400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
8080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080
8080808080808080808080818282828282828282838080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080
8080808080808080808080919292929292929292938080808080808080818380808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080
8080808080808080808080919292929292929292938080808080808080919380808080808080808081828282828283808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080
8080808080808080808080a1a2a2a2a2a2a2a2a2a380809d80808080809193808080808080808080919292929292938a908a808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080
80808080808080808080808080808080803b80808080808080808080809193809d9d9d808080808091929292929293808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080
80808080808080808080808080848586878889808080808080809d908091938080809d8080808060a1a2a2a2a2a2a3808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080
80808182838a90908a8182838094959697989980818283808080808080a1a38080809d808080809d9d9d9d9d9d8080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080
80809192938080808091929380a49596979899809192938080808080909d908080809d80808080808080808080804b4c4c4c4d4e80808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080
80809192938080808091929380a495969798998091929380808080808080808080809d80808080808080808080804f7f7f7f5f5e80808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080
80809192938080808091929380a495969798998091929380808080808080808080809d80808080808080808080804f7f7f7f5f5e80808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080
8080a1a2a3909d9d90a1a2a380a4959697989980a1a2a3808080808a8080808a80809d8a9d8a9d808080808080804f7f7f7f5f5e80808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080
80808080808080808080808080a4959697989980808080808080808080808080808080808080808080804b4c4c4c4c4c7a4a5f5e80808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080
80808080808080808080808040a4959697989980808080808080808080808080808040808080808080804f7f7f7f7f7f5f5a5f5e80808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080
80808080808080808080808080b4a5a6a7a8a980808060808080808080808080808080808080808080805b5c5c5c5c5c5d6a5d5e80808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080
a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0
__sfx__
0101000019111191211a1311b1311c1311e1312013123121251112611120111291012910129101291012910129101291002910029100291002910029101291010010100101001010000000000000000000000000
011000003403039030390213901139011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000100001401013010120201203013030140301503016030170301703018030180201901019010190100000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4b0100000e0100e0100d0200d0300e0300e0300f030100301003011030130301502016010160101701013000150001600016000170000e0000e0000f000100001000011000130001500016000160001700000000
010300001465327652166532a6521965327652216521e652126531b6531e652146530e6530a653066530365300600006000060000600006000060000600006000060000600006000060000600006000060000600
01020000146001461316600276201960016623216002a62012600196231e600276200e60021620066001e6200000012623000031b623000031e6200000314623000030e623000030a61300003066130000303613
94030000370322b7333f0020000234032287332c0023800230032247332e032227232b0221f713270121b7133f002000020000200002000020000200002000020000200002000020000200002000020000200002
961400000744407435004040040400404004040040400404004040040400404004040040400404004040040400404004040040400404004040040400404004040040400404004040040400404004040040400404
950a00001a7511b7521b7521b7521870018700167511775217752177520c700117001175112752127521275212752127521275212752127521275200701007010070100701007010070100701007010070100701
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00100010240242402024020240202b0202b0222b02226020290202902228020280201c0201d0201f0201f02500000000000000000000000000000000000000000000000000000000000000000000000000000000
002000080c1300c130041300413007130071300713007130001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100
02100010305453753530525375352f535345252f51534535325353751532535375253251537525325153751500505005050050500505005050050500505005050050500505005050050500505005050050500505
001000100c0230c00300003000033c6150000300003000030c0230000300003000033c6150000300003000030c0000000000000000003c6000000000000000000c0000000000000000003c600000000000000000
__music__
00 54151617

