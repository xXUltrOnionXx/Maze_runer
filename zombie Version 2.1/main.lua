
    ---------------------Camera-------------------
require "camera"
--------------------------------------------------------------
--------------------------------------------------------------
-------------LOAD---------------------------------------------
function love.load()

    ----------------------Collider----------------
    wf = require 'windfield' --collider
    world = wf.newWorld(0, 0, false)
    world:addCollisionClass('Solid')
    ----------------------------------------------
    sprites ={}
    sprites.player = love.graphics.newImage('sprites/player.png')
    sprites.bullet = love.graphics.newImage('sprites/bullet.png')
	  sprites.fireball = love.graphics.newImage('sprites/fireball.png')
    sprites.zombie = love.graphics.newImage('sprites/zombie.png')
    sprites.background = love.graphics.newImage('sprites/background.png')
    sprites.Holz_wand_vertic = love.graphics.newImage('sprites/Holz_wand_vertic.png')
    sprites.Holz_wand_horiz = love.graphics.newImage('sprites/Holz_wand_horiz.png')
    sprites.Holz_wand_vertic_mid = love.graphics.newImage('sprites/Holz_wand_vertic_mid.png')
    sprites.Holz_wand_horiz_mid = love.graphics.newImage('sprites/Holz_wand_horiz_mid.png')
    sprites.Holz_wand_horiz_mini = love.graphics.newImage('sprites/Holz_wand_horiz_mini.png')
    sprites.Holz_wand_vertic_mini = love.graphics.newImage('sprites/Holz_wand_vertic_mini.png')


    player = {}
    player.x = love.graphics.getWidth()/2
    player.y = love.graphics.getHeight()/2
    player.speed = 100
    player.hp = 100

    zombies = {}
    bullets = {}
    Fireballs = {}
    Fireball_cost = 15

    gameState = 1
    maxTime = 2
    timer = maxTime
    score = 0

    myFont = love.graphics.newFont(40)

    player.collider = world:newRectangleCollider(385, 287,  sprites.player:getWidth(),  sprites.player:getHeight()) --newCircleCollider(COLLIDER.x, COLLIDER.y, 30)
    player.collider:setCollisionClass('Solid')

    --testwall = world:newRectangleCollider(0, 250, 400, 30)
    --testwall:setType('static')
    --testwall:setCollisionClass('Solid')


end

--------------------------------------------------------------
--------------------------------------------------------------
-------------------------UPDATE-------------------------------
function love.update(dt)

    world:update(dt)

    if player.x > love.graphics.getWidth() / 2 then
      camera.x = player.x -love.graphics.getWidth() / 2
    end
    if player.y > love.graphics.getHeight() / 2 then
      camera.y = player.y - love.graphics.getHeight() / 2
    end

  if gameState == 2 then

    if love.keyboard.isDown("s") and player.collider:getY() < love.graphics.getHeight() then
      --COLLIDER.y = COLLIDER.y + COLLIDER.speed * dt
      player.collider:setPosition(player.collider:getX(), player.collider:getY() + player.speed * dt)
      --player.collider:setX(COLLIDER.x +5)
      --player.collider:setY(COLLIDER.y)

      px, py = player.collider:getPosition()

      player.x = px
      player.y = py

    end

    if love.keyboard.isDown("w") and player.collider:getY() > 0 then
      --COLLIDER.y = COLLIDER.y - COLLIDER.speed * dt
      player.collider:setPosition(player.collider:getX(), player.collider:getY() - player.speed * dt)
      --player.collider:setX(COLLIDER.x +5)
      --player.collider:setY(COLLIDER.y)

      px, py = player.collider:getPosition()

      player.x = px
      player.y = py

    end

    if love.keyboard.isDown("a") and player.collider:getX() > 0 then
      --COLLIDER.x = COLLIDER.x - COLLIDER.speed * dt
      player.collider:setPosition(player.collider:getX() - player.speed * dt, player.collider:getY())
      --player.collider:setX(COLLIDER.x +5)
      --player.collider:setY(COLLIDER.y)

      px, py = player.collider:getPosition()

      player.x = px
      player.y = py

    end

    if love.keyboard.isDown("d") and player.collider:getX() < love.graphics.getWidth() then
      --COLLIDER.x = COLLIDER.x + COLLIDER.speed * dt
      player.collider:setPosition(player.collider:getX() + player.speed * dt, player.collider:getY())
      --player.collider:setX(COLLIDER.x +5)
      --player.collider:setY(COLLIDER.y)

      px, py = player.collider:getPosition()

      player.x = px
      player.y = py

    end
  end

  for i, z in ipairs(zombies) do

    z.collider:setPosition(z.x, z.y)



    z.x = z.x + math.cos(zombie_player_angle(z)) * z.speed * dt
    z.y = z.y + math.sin(zombie_player_angle(z)) * z.speed * dt

    if distanceBetween(z.x, z.y, player.x, player.y) < 20 then

      if zombie.dmg_cooldown == 3 and player.hp > 0 then
        player.hp = player.hp - zombie.dmg
        zombie.dmg_cooldown = zombie.dmg_cooldown - dt
        if zombie.dmg_cooldown <= 0 then
            zombie.dmg_cooldown = 3
        end
      end

      if player.hp == 0 then
          for i,z in ipairs(zombie) do
            z.collider:destroy()
          end

          for i,z in ipairs(zombies) do
            zombies[i] = nil
          end

          gameState = 1
          player.hp = 100
          player.x = love.graphics.getWidth()/2
          player.y = love.graphics.getHeight()/2
      end
    end
  end

  --------------------------------------------------------------

  for i,b in ipairs(bullets) do
    b.x = b.x + math.cos(b.direction) * b.speed * dt
    b.y = b.y + math.sin(b.direction) * b.speed * dt
  end

  --------------------------------------------------------------

  for i,b in ipairs(Fireballs) do
    b.x = b.x + math.cos(b.direction) * b.speed * dt
    b.y = b.y + math.sin(b.direction) * b.speed * dt
  end

  --------------------------------------------------------------

  for i=#bullets,1,-1 do -- # return the number of all items inside the table
    local b = bullets[i]
    if b.x < 0 or b.y < 0 or b.x > love.graphics.getWidth() or b.y > love.graphics.getHeight() then
      table.remove(bullets, i)
    end
  end

  --------------------------------------------------------------

  for i=#Fireballs,1,-1 do -- # return the number of all items inside the table
    local b = Fireballs[i]
    if b.x < 0 or b.y < 0 or b.x > love.graphics.getWidth() or b.y > love.graphics.getHeight() then
      table.remove(Fireballs, i)
    end
  end

  --------------------------------------------------------------

  for i,z in ipairs(zombies) do
    for j,b in ipairs(bullets) do
      if distanceBetween(z.x, z.y, b.x, b.y) < 25 then
        z.dead = true
        z.collider:destroy()
        b.dead = true
        score = score + 1
      end
    end
  end

  --------------------------------------------------------------

  for i,z in ipairs(zombies) do
    for j,b in ipairs(Fireballs) do
      if distanceBetween(z.x, z.y, b.x, b.y) < 50 then
        z.dead = true
        z.collider:destroy()
        b.dead = true
        score = score + 1
      end
    end
  end

  --------------------------------------------------------------

  for i=#zombies,1,-1 do
    local z = zombies[i]
    if z.dead == true then
      table.remove(zombies, i)
    end
  end

  --------------------------------------------------------------

    for i=#bullets,1,-1 do
      local b = bullets[i]
      if b.dead == true then
        table.remove(bullets, i)
      end
    end

--------------------------------------------------------------
---------------------Zobie Spawn------------------------------
--------------------------------------------------------------
    if gameState == 2 then
      timer = timer - dt
      if timer <= 0 then
        --
        --spawnZombies()
        maxTime = maxTime * 0.95
        timer = maxTime
      end
    end

    --------------------------------------------------------------
end

--------------------------------------------------------------
--------------------------------------------------------------
--------------------------DRAW--------------------------------

function love.draw()
  camera:set()
  --------------------------------------------------------------

  love.graphics.draw(sprites.background, 0, 0)

  --love.graphics.draw(sprites.Holz_wand_vertic, 250, 250, nil, nil, nil, 250, 10)

  --love.graphics.draw(sprites.Holz_wand_horiz, 250, 250, nil, nil, nil, 0, 10)

  love.graphics.draw(sprites.Holz_wand_vertic_mini, 250, 250, nil, nil, nil, 140, 205)
  love.graphics.draw(sprites.Holz_wand_vertic_mid, 250, 250, nil, nil, nil, 250, 270)
  love.graphics.draw(sprites.Holz_wand_horiz_mini, 250, 250, nil, nil, nil, 262.5, 172.5)
  love.graphics.draw(sprites.Holz_wand_horiz_mini, 250, 250, nil, nil, nil, 262.5, 222)
  love.graphics.draw(sprites.Holz_wand_vertic_mid, 250, 250, nil, nil, nil, 250, 150)
  love.graphics.draw(sprites.Holz_wand_horiz_mini, 250, 250, nil, nil, nil, 91.5, 130)
  love.graphics.draw(sprites.Holz_wand_vertic_mid, 250, 250, nil, nil, nil, 250, 10)
  love.graphics.draw(sprites.Holz_wand_vertic_mid, 250, 250, nil, nil, nil, 250, 100)
  love.graphics.draw(sprites.Holz_wand_horiz_mid, 250, 250, nil, nil, nil, 270, -30)
  love.graphics.draw(sprites.Holz_wand_horiz_mid, 250, 250, nil, nil, nil, -10, 250)
  love.graphics.draw(sprites.Holz_wand_vertic_mid, 250, 250, nil, nil, nil, -256.5, 270)
  love.graphics.draw(sprites.Holz_wand_vertic_mid, 250, 250, nil, nil, nil, -55, 285)
  love.graphics.draw(sprites.Holz_wand_horiz_mini, 250, 250, nil, nil, nil, -214, 237)
  love.graphics.draw(sprites.Holz_wand_horiz_mid, 250, 250, nil, nil, nil, 10, -37.5)
  love.graphics.draw(sprites.Holz_wand_vertic_mid, 250, 250, nil, nil, nil, -5, 10)
  love.graphics.draw(sprites.Holz_wand_vertic_mid, 250, 250, nil, nil, nil, 125, -270)
  love.graphics.draw(sprites.Holz_wand_vertic_mid, 250, 250, nil, nil, nil, 250, -270)
  love.graphics.draw(sprites.Holz_wand_vertic_mid, 250, 250, nil, nil, nil, 250, -200)
  love.graphics.draw(sprites.Holz_wand_horiz_mini, 250, 250, nil, nil, nil, -63.5, -290)
  love.graphics.draw(sprites.Holz_wand_horiz_mini, 250, 250, nil, nil, nil, -140, -290)
  love.graphics.draw(sprites.Holz_wand_horiz_mid, 250, 250, nil, nil, nil, -115.5, 189)
  love.graphics.draw(sprites.Holz_wand_vertic_mid, 250, 250, nil, nil, nil, -5, -200)
  love.graphics.draw(sprites.Holz_wand_vertic_mid, 250, 250, nil, nil, nil, -157, 150)
  love.graphics.draw(sprites.Holz_wand_horiz_mid, 250, 250, nil, nil, nil, -250, 105)
  love.graphics.draw(sprites.Holz_wand_vertic_mini, 250, 250, nil, nil, nil, 140, -100)
  love.graphics.draw(sprites.Holz_wand_vertic_mini, 250, 250, nil, nil, nil, 95, -100)
  wall_collider(83, -100)
  --love.graphics.draw(sprites.Holz_wand_vertic_mini, 250, 250, nil, nil, nil, 83, -100)
  love.graphics.draw(sprites.Holz_wand_vertic_mid, 250, 250, nil, nil, nil, -350, -300)
  love.graphics.draw(sprites.Holz_wand_horiz_mid, 250, 250, nil, nil, nil, -325, -150)
  love.graphics.draw(sprites.Holz_wand_horiz_mid, 250, 250, nil, nil, nil, -417, -70)
  love.graphics.draw(sprites.Holz_wand_vertic_mini, 250, 250, nil, nil, nil, -460, -230)
  love.graphics.draw(sprites.Holz_wand_vertic_mid, 250, 250, nil, nil, nil, -292.5, 50)
  --------------------------------------------------------------

  if gameState == 1 then
    love.graphics.setFont(myFont)
    love.graphics.printf("Press enter to Start the Game", 0, 50, love.graphics.getWidth(), "center")
  end

  --------------------------------------------------------------

  love.graphics.printf("Score: " .. score, 0, love.graphics.getHeight() - 100, love.graphics.getWidth(), "center")

  if score >= 15 then
    Fireball_On()
  end

  --------------------------------------------------------------
  love.graphics.printf("HP: ".. player.hp, 0, love.graphics.getHeight() - 100, love.graphics.getWidth(), "left")

  --------------------------------------------------------------

  love.graphics.draw(sprites.player, player.x, player.y, player_mouse_angle(), nil, nil, sprites.player.getWidth(sprites.player)/2, sprites.player.getHeight(sprites.player)/2)

  --------------------------------------------------------------

  for i,z in ipairs(zombies) do
    love.graphics.draw(sprites.zombie, z.x, z.y, zombie_player_angle(z), nil, nil, sprites.zombie.getWidth(sprites.player)/2, sprites.zombie.getHeight(sprites.player)/2)
  end

  --------------------------------------------------------------

  for i,b in ipairs(bullets) do
    love.graphics.draw(sprites.bullet, b.x, b.y, nul, 0.5, 0.5, sprites.bullet.getWidth(sprites.bullet)/3, sprites.bullet.getHeight(sprites.bullet)/3)
  end

  --------------------------------------------------------------

  for i,b in ipairs(Fireballs) do
    love.graphics.draw(sprites.fireball, b.x, b.y, nul, 2, 2, sprites.fireball.getWidth(sprites.fireball)/3, sprites.fireball.getHeight(sprites.fireball)/3)
  end

  --------------------------------------------------------------
  world:draw()
  camera:unset()
end

--------------------------------------------------------------
--------------------------------------------------------------
--------------------------FUNCTIONS---------------------------

function player_mouse_angle()
  return math.atan2(player.y - love.mouse.getY(), player.x - love.mouse.getX()) + math.pi
end

--------------------------------------------------------------

function zombie_player_angle(enemy)
  return math.atan2(player.y - enemy.y, player.x - enemy.x)
end

--------------------------------------------------------------

function spawnZombies()
  zombie = {}
  zombie.x = 0
  zombie.y = 0
  zombie.speed = 50
  zombie.dead = false
  zombie.isattacking = false
  zombie.dmg = 5
  zombie.dmg_cooldown = 3
  zombie.collider = world:newRectangleCollider(zombie.x, zombie.y, 30, 30) --newCircleCollider(COLLIDER.x, COLLIDER.y, 30)
  zombie.collider:setCollisionClass('Solid')

  local side = math.random(1, 4)

  if side == 1 then
      zombie.x = -30
      zombie.y = math.random(0, love.graphics.getHeight())
  elseif side == 2 then
    zombie.x = love.math.random(0, love.graphics.getWidth())
    zombie.y = -30
  elseif side == 3 then
    zombie.x = love.graphics.getWidth() + 30
    zombie.y = math.random(0, love.graphics.getWidth())
  else
    zombie.x = math.random(0, love.graphics.getWidth())
    zombie.y = love.graphics.getHeight() + 30
  end

  -------------------------------------------------------------

  --------------------------------------------------------------

  table.insert(zombies, zombie)
end

--------------------------------------------------------------

function spawnBullet()
  bullet = {}
  bullet.x = player.x
  bullet.y = player.y
  bullet.speed = 2500
  bullet.direction = player_mouse_angle()
  bullet.dead = false

  table.insert(bullets, bullet)
end

--------------------------------------------------------------

function spawnFireballs()
  Fireball = {}
  Fireball.x = player.x
  Fireball.y = player.y
  Fireball.speed = 500
  Fireball.direction = player_mouse_angle()
  Fireball.dead = false

  table.insert(Fireballs, Fireball)
end

--------------------------------------------------------------

function love.keypressed(key, scancode, isrepeat)

  if key == "return" and gameState == 1 then
     gameState = 2
     maxTime = 2
     timer = maxTime
     score = 0
  end
  --if key == "space" then
    --spawnZombies()
  --end
end

--------------------------------------------------------------

function love.mousepressed(x, y, b, isTouch)
  if b == 1 and gameState == 2 then
    spawnBullet()
  end

   if b == 2 and gameState == 2 and score >= 15 then
    spawnFireballs()
    score = score - Fireball_cost
  end
end

--------------------------------------------------------------

function distanceBetween(x1, y1, x2, y2)
  return math.sqrt((y2 - y1)^2 + (x2 - x1)^2)
end

--------------------------------------------------------------

function Fireball_On()
  love.graphics.printf("FireBall On", 0, love.graphics.getHeight() - 100, love.graphics.getWidth(), "right")
end

--------------------------------------------------------------
--------------------------------------------------------------
--------------------------------------------------------------

function wall_collider(y, x)
  love.graphics.draw(sprites.Holz_wand_vertic_mini, 250, 250, nil, nil, nil, x, y)
  --blocquee
  testwall = world:newRectangleCollider(x, y, sprites.Holz_wand_vertic_mini:getWidth(), sprites.Holz_wand_vertic_mini:getHeight())
  testwall:setType('static')
  testwall:setCollisionClass('Solid')

end
