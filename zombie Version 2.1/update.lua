require "zombie_player_angle"
require "spawn_functions"

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

    if gameState == 2 then
      timer = timer - dt
      if timer <= 0 then
        --
        spawnZombies()
        maxTime = maxTime * 0.95
        timer = maxTime
      end
    end
end

function distanceBetween(x1, y1, x2, y2)
  return math.sqrt((y2 - y1)^2 + (x2 - x1)^2)
end
