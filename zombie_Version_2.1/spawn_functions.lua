
function spawnZombies()
  zombie = {}
  zombie.x = 0
  zombie.y = 0
  zombie.speed = 50
  zombie.dead = false
  zombie.isattacking = false
  zombie.dmg = 5
  zombie.dmg_cooldown = 0
  zombie.start = love.timer.getTime()
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
