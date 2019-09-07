require "zombie_player_angle"
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
  love.graphics.draw(sprites.Holz_wand_vertic_mini, 250, 250, nil, nil, nil, 83, -100)
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

function Fireball_On()
  love.graphics.printf("FireBall On", 0, love.graphics.getHeight() - 100, love.graphics.getWidth(), "right")
end
