require "zombie_player_angle"
require "spawn_functions"
require "distance"

backgroundWidth = 894
backgroundHeight = 896

debugPaths = {}

gameState = gameState or 1

function distanceBetween(x1, y1, x2, y2)
  return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

-- Terminal log buffer
logLines = logLines or {}
logScroll = logScroll or 0
function addToLog(line)
  local timestamp = os.date("%H:%M:%S")
  local entry = string.format("[%s] %s", timestamp, line)
  table.insert(logLines, entry)
  if #logLines > 100 then table.remove(logLines, 1) end

  -- Write to log file as well
  local file = io.open("game_log.txt", "a")
  if file then
    file:write(entry .. "\n")
    file:close()
  end
end

function love.wheelmoved(x, y)
  if gameState == 2 then
    logScroll = logScroll - y
    logScroll = math.max(0, math.min(logScroll, math.max(0, #logLines - 11)))
  end
end

function love.update(dt)
  debugPaths = debugPaths or {}
  for z, pathData in pairs(debugPaths) do
    if pathData.expires and love.timer.getTime() > pathData.expires then
      debugPaths[z] = nil
    end
  end

  local fps = love.timer.getFPS()
  --addToLog("FPS: " .. fps)

  if world then
    world:update(dt * 2)
  end

  if player and player.collider and camera then
    player.x, player.y = player.collider:getPosition()
    local mx, my = camera:getX(), camera:getY()
    player.angle = math.atan2(my - player.y, mx - player.x)
    camera:setPosition(player.x, player.y)
  end

  if gameState == 2 then
    local vx, vy = 0, 0
    if love.keyboard.isDown("w") then vy = -player.speed end
    if love.keyboard.isDown("s") then vy = player.speed end
    if love.keyboard.isDown("a") then vx = -player.speed end
    if love.keyboard.isDown("d") then vx = player.speed end
    player.collider:setLinearVelocity(vx, vy)
    player.x, player.y = player.collider:getPosition()
  end

  for _, z in ipairs(zombies or {}) do
    local zx, zy = z.collider:getPosition()
    local target = z.path and z.path[z.currentTargetIndex]

    if (not z.path or z.currentTargetIndex > #z.path) or (love.timer.getTime() - (z.pathUpdateTimer or 0) > 0.5) then
      local function toTile(val, max)
        if not val then return 1 end
        return math.max(1, math.min(max, math.floor(val / 32) + 1))
      end
      local zxTile = toTile(zx, 27)
      local zyTile = toTile(zy, 28)
      local pxTile = toTile(player.x, 27)
      local pyTile = toTile(player.y, 28)
      local newPath = pathfinder:getPath(zxTile, zyTile, pxTile, pyTile)
      if newPath then
        z.path = {}
        debugPaths[z] = {points = {}, expires = love.timer.getTime() + 2}
        for node, _ in newPath:nodes() do
          local px = (node:getX() - 1) * 32 + 16 + math.random(-12, 12)
          local py = (node:getY() - 1) * 32 + 16 + math.random(-12, 12)
          table.insert(z.path, {x = px, y = py})
          table.insert(debugPaths[z].points, {x = px, y = py})
        end
        z.currentTargetIndex = 1
        z.pathUpdateTimer = love.timer.getTime()
      end
    end

    zx, zy = z.collider:getPosition()
    target = z.path and z.path[z.currentTargetIndex]
    if target then
      local dx, dy = target.x - zx, target.y - zy
      local dist = math.sqrt(dx * dx + dy * dy)

      if dist < 5 then
        z.currentTargetIndex = z.currentTargetIndex + 1
        z.collider:setLinearVelocity(0, 0)
        z.blockedTime = (z.blockedTime or 0) + dt
        target = nil
        if z.blockedTime > 1.5 then
          z.lastPathUpdate = 0
          z.blockedTime = 0
        end
      else
        local nx, ny = dx / dist, dy / dist
        local futureX = zx + nx * z.speed * dt
        local futureY = zy + ny * z.speed * dt

        local items = world:queryCircleArea(futureX, futureY, 16, {"Solid"}) or {}
        local clear = true
        for _, item in ipairs(items) do
          if item ~= z.collider and item ~= player.collider and not item:isSensor() then
            clear = false
            break
          end
        end

        for _, other in ipairs(zombies) do
          if other ~= z and not other.dead then
            local ox, oy = other.collider:getPosition()
            local distToOther = distanceBetween(futureX, futureY, ox, oy)
            if distToOther < 30 then
              clear = false
              break
            end
          end
        end

        if clear then
          local jitterX = (math.random() - 0.5) * 10
          local jitterY = (math.random() - 0.5) * 10
          z.collider:setLinearVelocity(nx * z.speed + jitterX, ny * z.speed + jitterY)
          z.blockedTime = 0
        else
          z.collider:setLinearVelocity(0, 0)
        end
      end
    end

    z.x, z.y = z.collider:getPosition()
    if distanceBetween(z.x, z.y, player.x, player.y) < 20 then
      z.dmg_cooldown = love.timer.getTime() - z.start
      if z.dmg_cooldown > 3 and player.hp > 0 then
        player.hp = player.hp - z.dmg
        z.dmg_cooldown = 0
        z.start = love.timer.getTime()
      end

      if player.hp <= 0 then
        for _, z in ipairs(zombies) do z.collider:destroy() end
        for i = #zombies, 1, -1 do table.remove(zombies, i) end
        player.collider:destroy()
        gameState = 1
        player.hp = 100
        player.collider = world:newRectangleCollider(385, 287, sprites.player:getWidth(), sprites.player:getHeight())
        player.collider:setType('dynamic')
        player.collider:setMass(1)
        player.collider:setLinearDamping(10)
        player.x = love.graphics.getWidth() / 2
        player.y = love.graphics.getHeight() / 2
      end
    end
  end

  for i, b in ipairs(bullets or {}) do
    b.x = b.x + math.cos(b.direction) * b.speed * dt
    b.y = b.y + math.sin(b.direction) * b.speed * dt
  end
  for i = #bullets, 1, -1 do
    local b = bullets[i]
    if distance(b.x, b.y, player.x, player.y) > 500 or b.dead then
      table.remove(bullets, i)
    end
  end

  for i, b in ipairs(Fireballs or {}) do
    b.x = b.x + math.cos(b.direction) * b.speed * dt
    b.y = b.y + math.sin(b.direction) * b.speed * dt
  end
  for i = #Fireballs, 1, -1 do
    local b = Fireballs[i]
    if distance(b.x, b.y, player.x, player.y) > 500 or b.dead then
      table.remove(Fireballs, i)
    end
  end

  for i, z in ipairs(zombies or {}) do
    for j, b in ipairs(bullets or {}) do
      if distanceBetween(z.x, z.y, b.x, b.y) < 25 then
        z.dead = true
        z.collider:destroy()
        b.dead = true
        score = score + 1
      end
    end
  end

  for i, z in ipairs(zombies or {}) do
    for j, b in ipairs(Fireballs or {}) do
      if distanceBetween(z.x, z.y, b.x, b.y) < 50 then
        z.dead = true
        z.collider:destroy()
        b.dead = true
        score = score + 1
      end
    end
  end

  for i = #zombies, 1, -1 do
    if zombies[i].dead then
      table.remove(zombies, i)
    end
  end
  for i = #bullets, 1, -1 do
    if bullets[i].dead then
      table.remove(bullets, i)
    end
  end

  if gameState == 2 then
    timer = timer - dt
    if timer <= 0 then
      local success, result = pcall(function() return spawnZombies() end)
      if not success then
        addToLog(tostring(result))
      elseif not result then
        addToLog("Kein Pfad gefunden – Zombie wurde nicht gespawnt.")
      end
      timer = maxTime
    end
  end
end


function love.draw()
  if camera and camera.set then camera:set() end

  if sprites and sprites.background then
    love.graphics.draw(sprites.background, 0, 0)
  end

  if world then world:draw() end

  if player and sprites.player then
    love.graphics.draw(sprites.player, player.x, player.y, player.angle, 1, 1, sprites.player:getWidth() / 2, sprites.player:getHeight() / 2)
  end

  for _, z in ipairs(zombies or {}) do
    if not z.dead and sprites.zombie then
      love.graphics.draw(sprites.zombie, z.x - sprites.zombie:getWidth() / 2, z.y - sprites.zombie:getHeight() / 2)
    end
  end

  for _, f in ipairs(Fireballs or {}) do
    if sprites.fireball then
      love.graphics.draw(sprites.fireball, f.x - sprites.fireball:getWidth() / 2, f.y - sprites.fireball:getHeight() / 2)
    end
  end

  for _, b in ipairs(bullets or {}) do
    if sprites.bullet then
      love.graphics.draw(sprites.bullet, b.x - sprites.bullet:getWidth() / 2, b.y - sprites.bullet:getHeight() / 2)
    end
  end

  for _, pathData in pairs(debugPaths or {}) do
    local path = pathData.points
    for i = 1, #path - 1 do
      local p1 = path[i]
      local p2 = path[i + 1]
      love.graphics.setColor(1, 0, 0, 0.5)
      love.graphics.line(p1.x, p1.y, p2.x, p2.y)
      love.graphics.setColor(1, 1, 1)
    end
  end

  for _, z in ipairs(zombies or {}) do
    if z.x and z.y then
      local r = 24
      local directions = {
        {x =  1, y =  0}, {x = -1, y =  0}, {x =  0, y = -1}, {x =  0, y =  1},
        {x =  1, y = -1}, {x = -1, y = -1}, {x =  1, y =  1}, {x = -1, y =  1},
      }
      for _, dir in ipairs(directions) do
        local px = z.x + dir.x * r
        local py = z.y + dir.y * r
        local items = world:queryCircleArea(px, py, 4, {"Solid"}) or {}
        if #items > 0 then
          love.graphics.setColor(1, 0, 0)
        else
          love.graphics.setColor(0, 1, 0)
        end
        love.graphics.circle("fill", px, py, 2)
      end
      love.graphics.setColor(1, 1, 1)
    end
  end

  if camera and camera.unset then camera:unset() end

  -- Draw terminal log bottom left
  if gameState == 2 then
    love.graphics.setFont(myFont or love.graphics.newFont(1))
    local baseY = love.graphics.getHeight() - 160
    local boxHeight = 160
    local lineHeight = 14
    local maxVisibleLines = 11
    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.rectangle("fill", 10, baseY - 10, 420, boxHeight)
    for i = 1, maxVisibleLines do
      local index = i + logScroll
      local line = logLines[index]
      if line then
        love.graphics.setColor(1, 1, 1)
        local maxWidth = 400
        -- local trimmed = line
        -- while love.graphics.getFont():getWidth(trimmed) > maxWidth do
        --   trimmed = string.sub(trimmed, 1, #trimmed - 1)
        -- end
        love.graphics.print(line, 20, baseY + (i - 1) * lineHeight)
      end
    end
  end
end
