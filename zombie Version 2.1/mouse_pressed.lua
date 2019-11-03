function love.mousepressed(x, y, b, isTouch)
  if b == 1 and gameState == 2 then
    spawnBullet()
    --love.audio.play(sound)
  end

   if b == 2 and gameState == 2 and score >= 15 then
    spawnFireballs()
    local score = score - Fireball_cost
  end
end
