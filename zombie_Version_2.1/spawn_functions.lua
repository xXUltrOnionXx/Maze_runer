function spawnZombies()
  for attempt = 1, 100 do
    local zx = math.random(64, backgroundWidth - 64)
    local zy = math.random(64, backgroundHeight - 64)

    local occupied = world:queryCircleArea(zx, zy, 5, {'Solid'}) or {}
    if #occupied == 0 and player and player.x and player.y then
      local zombie = {
        x = zx,
        y = zy,
        speed = 50,
        dead = false,
        dmg = 5,
        start = love.timer.getTime(),
        feelers = {
          {dx = 32, dy = 0}, {dx = -32, dy = 0},
          {dx = 0, dy = 32}, {dx = 0, dy = -32},
          {dx = 24, dy = 24}, {dx = -24, dy = -24},
          {dx = -24, dy = 24}, {dx = 24, dy = -24}
        }
      }

      zombie.collider = world:newRectangleCollider(zx, zy, 30, 30)
      zombie.collider:setCollisionClass('Solid')

      local function toTile(val)
        return math.max(1, math.floor(val / 32) + 1)
      end

      local zxTile, zyTile = toTile(zx), toTile(zy)
      local px, py = toTile(player.x), toTile(player.y)

      local path = pathfinder:getPath(zxTile, zyTile, px, py)
      if path then
        zombie.path = {}
        for node, _ in path:nodes() do
          local px = (node:getX() - 1) * 32 + 16 + math.random(-10, 10)
          local py = (node:getY() - 1) * 32 + 16 + math.random(-10, 10)
          table.insert(zombie.path, {x = px, y = py})
        end
        zombie.currentTargetIndex = 1
        zombie.pathUpdateTimer = love.timer.getTime()
        table.insert(zombies, zombie)
        addToLog("Zombie gespawnt bei [" .. zx .. "," .. zy .. "]")
        return true
      else
        zombie.collider:destroy()
        addToLog("Pfad nicht gefunden bei [" .. zxTile .. "," .. zyTile .. "]")
      end
    end
  end
  addToLog("Kein Zombie gespawnt (100 Versuche)")
  return false
end


--------------------------------------------------------------

function spawnBullet()
  bullet = {}
  bullet.x = player.x
  bullet.y = player.y
  bullet.speed = 500
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
