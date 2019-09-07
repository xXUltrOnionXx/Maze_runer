function love.mousepressed(x, y, b, isTouch)
  if b == 1 and gameState == 2 then
    spawnBullet()
  end

   if b == 2 and gameState == 2 and score >= 15 then
    spawnFireballs()
    score = score - Fireball_cost
  end
end
