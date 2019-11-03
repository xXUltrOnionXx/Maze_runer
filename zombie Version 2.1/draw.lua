require "zombie_player_angle"
require "draw_map"
function love.draw()
  camera:set()


    draw_map()
  

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

    --love.graphics.printf("Y: "..player.y - love.mouse.getY()..", ".."X: "..player.x - love.mouse.getX(), 0, love.graphics.getHeight() - 100, love.graphics.getWidth(), "right")
  --------------------------------------------------------------
  world:draw()
  camera:unset()
end

function Fireball_On()
  love.graphics.printf("FireBall On", 0, love.graphics.getHeight() - 100, love.graphics.getWidth(), "right")
end
