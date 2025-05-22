camera = {}
camera.x = 0
camera.y = 0
camera.scaleX = 1
camera.scaleY = 1
camera.rotation = 0

-- Define the background dimensions
local backgroundWidth = 894
local backgroundHeight = 896

-- Get window dimensions
local windowWidth = love.graphics.getWidth()
local windowHeight = love.graphics.getHeight()

function camera:set()
  love.graphics.push()
  love.graphics.rotate(-self.rotation)
  love.graphics.scale(1 / self.scaleX, 1 / self.scaleY)
  love.graphics.translate(-self.x, -self.y)
end

function camera:unset()
  love.graphics.pop()
end

function camera:move(dx, dy)
  self.x = self.x + (dx or 0)
  self.y = self.y + (dy or 0)
end

function camera:rotate(dr)
  self.rotation = self.rotation + dr
end

function camera:scale(sx, sy)
  sx = sx or 1
  self.scaleX = self.scaleX * sx
  self.scaleY = self.scaleY * (sy or sx)
end

-- Update `camera:setPosition` to follow the player and stay within the background boundaries
function camera:setPosition(playerX, playerY)
  -- Calculate the target camera position, centered on the player
  local targetX = playerX - love.graphics.getWidth() / 2
  local targetY = playerY - love.graphics.getHeight() / 2

  -- Clamp the target position within the background boundaries
  self.x = math.max(0, math.min(targetX, backgroundWidth - love.graphics.getWidth()))
  self.y = math.max(0, math.min(targetY, backgroundHeight - love.graphics.getHeight()))
end

function camera:setScale(sx, sy)
  self.scaleX = sx or self.scaleX
  self.scaleY = sy or self.scaleY
end

function camera:getX()
  return love.mouse.getX() * self.scaleX + self.x
end

function camera:getY()
  return love.mouse.getY() * self.scaleY + self.y
end
