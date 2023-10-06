function wall_collider(y, x)
  love.graphics.draw(sprites.Holz_wand_vertic_mini, 250, 250, nil, nil, nil, x, y)
  --blocquee
  testwall = world:newRectangleCollider(x, y, sprites.Holz_wand_vertic_mini:getWidth(), sprites.Holz_wand_vertic_mini:getHeight())
  testwall:setType('static')
  testwall:setCollisionClass('Solid')
end
