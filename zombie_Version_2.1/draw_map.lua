--------------------------------------------------------------
function draw_map()
  love.graphics.draw(sprites.background, 0, 0)
  local wall_arr = {}
  local wall = {}

  -- if(map_drawn == false) then
  --   wall.collider = world:newRectangleCollider(0 , 0, love.graphics:getWidth()+95, 27)
  --   wall.collider:setType('static')
  --   wall.collider:setCollisionClass('Solid')
  --   table.insert(wall_arr, wall)
  --
  --   wall.collider = world:newRectangleCollider(0 , 860, love.graphics:getWidth()+95, 35)
  --   wall.collider:setType('static')
  --   wall.collider:setCollisionClass('Solid')
  --   table.insert(wall_arr, wall)
  --
  --   wall.collider = world:newRectangleCollider(120 , 90, 40, love.graphics:getHeight()/2-95)
  --   wall.collider:setType('static')
  --   wall.collider:setCollisionClass('Solid')
  --   table.insert(wall_arr, wall)
  --
  --   wall.collider = world:newRectangleCollider(120 , 90, love.graphics:getWidth()/2-95, 30)
  --   wall.collider:setType('static')
  --   wall.collider:setCollisionClass('Solid')
  --   table.insert(wall_arr, wall)
  --
  --   wall.collider = world:newRectangleCollider(0 , 90, 35, love.graphics:getHeight()+170)
  --   wall.collider:setType('static')
  --   wall.collider:setCollisionClass('Solid')
  --   table.insert(wall_arr, wall)
  --
  --   wall.collider = world:newRectangleCollider(860 , 0, 35, love.graphics:getHeight()+130)
  --   wall.collider:setType('static')
  --   wall.collider:setCollisionClass('Solid')
  --   table.insert(wall_arr, wall)
  --
  --   map_drawn = true
  -- elseif (map_drawn == true) then
  --   for i,w in ipairs(wall_arr) do
  --       w.collider:destroy()
  --   end
  --   map_drawn = true
  -- end
  --
  --
  -- love.graphics.draw(sprites.Holz_wand_vertic_mini, 250, 250, nil, nil, nil, 140, 205)
  -- local wall_1 = world:newRectangleCollider(110 , 45, sprites.Holz_wand_vertic_mini:getWidth(), sprites.Holz_wand_vertic_mini:getHeight())
  -- wall_1:setType('static')
  -- wall_1:setCollisionClass('Solid')

  --[[love.graphics.draw(sprites.Holz_wand_vertic_mid, 250, 250, nil, nil, nil, 250, 270)
  local wall_2 = world:newRectangleCollider(0, 0, sprites.Holz_wand_vertic_mid:getWidth()-90, sprites.Holz_wand_vertic_mid:getHeight()-50)
  wall_2:setType('static')
  wall_2:setCollisionClass('Solid')

  love.graphics.draw(sprites.Holz_wand_horiz_mini, 250, 250, nil, nil, nil, 262.5, 172.5)
  local wall_3 = world:newRectangleCollider(0, 78, sprites.Holz_wand_horiz_mini:getWidth()/2, sprites.Holz_wand_horiz_mini:getHeight()-10)
  wall_3:setType('static')
  wall_3:setCollisionClass('Solid')

  love.graphics.draw(sprites.Holz_wand_horiz_mini, 250, 250, nil, nil, nil, 262.5, 222)
  local wall_4 = world:newRectangleCollider(0, 30, sprites.Holz_wand_horiz_mini:getWidth()/2, sprites.Holz_wand_horiz_mini:getHeight()-12.5)
  wall_4:setType('static')
  wall_4:setCollisionClass('Solid')

  love.graphics.draw(sprites.Holz_wand_vertic_mid, 250, 250, nil, nil, nil, 250, 150)
  local wall_5 = world:newRectangleCollider(0, 122, sprites.Holz_wand_vertic_mid:getWidth()-90, sprites.Holz_wand_vertic_mid:getHeight()/3)
  wall_5:setType('static')
  wall_5:setCollisionClass('Solid')

  love.graphics.draw(sprites.Holz_wand_horiz_mini, 250, 250, nil, nil, nil, 91.5, 130)
  local wall_6 = world:newRectangleCollider(173, 150, sprites.Holz_wand_horiz_mini:getWidth()/2, sprites.Holz_wand_horiz_mini:getHeight()-35)
  wall_6:setType('static')
  wall_6:setCollisionClass('Solid')

  love.graphics.draw(sprites.Holz_wand_vertic_mid, 250, 250, nil, nil, nil, 250, 10)
  local wall_7 = world:newRectangleCollider(0, 263, sprites.Holz_wand_vertic_mid:getWidth()-90, sprites.Holz_wand_vertic_mid:getHeight()/3)
  wall_7:setType('static')
  wall_7:setCollisionClass('Solid')

  love.graphics.draw(sprites.Holz_wand_vertic_mid, 250, 250, nil, nil, nil, 250, 100)
  local wall_7 = world:newRectangleCollider(0, 175, sprites.Holz_wand_vertic_mid:getWidth()-90, sprites.Holz_wand_vertic_mid:getHeight()/3)
  wall_7:setType('static')
  wall_7:setCollisionClass('Solid')

  love.graphics.draw(sprites.Holz_wand_horiz_mid, 250, 250, nil, nil, nil, 270, -30)
  local wll_8 = world:newRectangleCollider(0, 290, sprites.Holz_wand_horiz_mid:getWidth()-32, sprites.Holz_wand_horiz_mid:getHeight()-12)
  wll_8:setType('static')
  wll_8:setCollisionClass('Solid')

  love.graphics.draw(sprites.Holz_wand_horiz_mid, 250, 250, nil, nil, nil, -10, 250)
  local wall_9 = world:newRectangleCollider(275, 0, sprites.Holz_wand_horiz_mid:getWidth()-30, sprites.Holz_wand_horiz_mid:getHeight())
  wall_9:setType('static')
  wall_9:setCollisionClass('Solid')

  love.graphics.draw(sprites.Holz_wand_vertic_mid, 250, 250, nil, nil, nil, -256.5, 270)
  local wall_10 = world:newRectangleCollider(505, 0, sprites.Holz_wand_vertic_mid:getWidth()-90, sprites.Holz_wand_vertic_mid:getHeight()/3)
  wall_10:setType('static')
  wall_10:setCollisionClass('Solid')

  love.graphics.draw(sprites.Holz_wand_vertic_mid, 250, 250, nil, nil, nil, -55, 285)
  testwall = world:newRectangleCollider(300, -5, sprites.Holz_wand_vertic_mid:getWidth()-90, sprites.Holz_wand_vertic_mid:getHeight()/4)
  testwall:setType('static')
  testwall:setCollisionClass('Solid')


------------------------------------------Alle Collider Fertig bis hier-------------------------------------------------------


  love.graphics.draw(sprites.Holz_wand_horiz_mini, 250, 250, nil, nil, nil, -214, 237)
  testwall = world:newRectangleCollider(x, y, sprites.Holz_wand_vertic_mini:getWidth(), sprites.Holz_wand_vertic_mini:getHeight())
  testwall:setType('static')
  testwall:setCollisionClass('Solid')

  love.graphics.draw(sprites.Holz_wand_horiz_mid, 250, 250, nil, nil, nil, 10, -37.5)
  testwall = world:newRectangleCollider(x, y, sprites.Holz_wand_vertic_mini:getWidth(), sprites.Holz_wand_vertic_mini:getHeight())
  testwall:setType('static')
  testwall:setCollisionClass('Solid')

  love.graphics.draw(sprites.Holz_wand_vertic_mid, 250, 250, nil, nil, nil, -5, 10)
  testwall = world:newRectangleCollider(x, y, sprites.Holz_wand_vertic_mini:getWidth(), sprites.Holz_wand_vertic_mini:getHeight())
  testwall:setType('static')
  testwall:setCollisionClass('Solid')

  love.graphics.draw(sprites.Holz_wand_vertic_mid, 250, 250, nil, nil, nil, 125, -270)
  testwall = world:newRectangleCollider(x, y, sprites.Holz_wand_vertic_mini:getWidth(), sprites.Holz_wand_vertic_mini:getHeight())
  testwall:setType('static')
  testwall:setCollisionClass('Solid')

  love.graphics.draw(sprites.Holz_wand_vertic_mid, 250, 250, nil, nil, nil, 250, -270)
  testwall = world:newRectangleCollider(x, y, sprites.Holz_wand_vertic_mini:getWidth(), sprites.Holz_wand_vertic_mini:getHeight())
  testwall:setType('static')
  testwall:setCollisionClass('Solid')

  love.graphics.draw(sprites.Holz_wand_vertic_mid, 250, 250, nil, nil, nil, 250, -200)
  testwall = world:newRectangleCollider(x, y, sprites.Holz_wand_vertic_mini:getWidth(), sprites.Holz_wand_vertic_mini:getHeight())
  testwall:setType('static')
  testwall:setCollisionClass('Solid')

  love.graphics.draw(sprites.Holz_wand_horiz_mini, 250, 250, nil, nil, nil, -63.5, -290)
  testwall = world:newRectangleCollider(x, y, sprites.Holz_wand_vertic_mini:getWidth(), sprites.Holz_wand_vertic_mini:getHeight())
  testwall:setType('static')
  testwall:setCollisionClass('Solid')

  love.graphics.draw(sprites.Holz_wand_horiz_mini, 250, 250, nil, nil, nil, -140, -290)
  testwall = world:newRectangleCollider(x, y, sprites.Holz_wand_vertic_mini:getWidth(), sprites.Holz_wand_vertic_mini:getHeight())
  testwall:setType('static')
  testwall:setCollisionClass('Solid')

  love.graphics.draw(sprites.Holz_wand_horiz_mid, 250, 250, nil, nil, nil, -115.5, 189)
  testwall = world:newRectangleCollider(x, y, sprites.Holz_wand_vertic_mini:getWidth(), sprites.Holz_wand_vertic_mini:getHeight())
  testwall:setType('static')
  testwall:setCollisionClass('Solid')

  love.graphics.draw(sprites.Holz_wand_vertic_mid, 250, 250, nil, nil, nil, -5, -200)
  testwall = world:newRectangleCollider(x, y, sprites.Holz_wand_vertic_mini:getWidth(), sprites.Holz_wand_vertic_mini:getHeight())
  testwall:setType('static')
  testwall:setCollisionClass('Solid')

  love.graphics.draw(sprites.Holz_wand_vertic_mid, 250, 250, nil, nil, nil, -157, 150)
  testwall = world:newRectangleCollider(x, y, sprites.Holz_wand_vertic_mini:getWidth(), sprites.Holz_wand_vertic_mini:getHeight())
  testwall:setType('static')
  testwall:setCollisionClass('Solid')

  love.graphics.draw(sprites.Holz_wand_horiz_mid, 250, 250, nil, nil, nil, -250, 105)
  testwall = world:newRectangleCollider(x, y, sprites.Holz_wand_vertic_mini:getWidth(), sprites.Holz_wand_vertic_mini:getHeight())
  testwall:setType('static')
  testwall:setCollisionClass('Solid')

  love.graphics.draw(sprites.Holz_wand_vertic_mini, 250, 250, nil, nil, nil, 140, -100)
  testwall = world:newRectangleCollider(x, y, sprites.Holz_wand_vertic_mini:getWidth(), sprites.Holz_wand_vertic_mini:getHeight())
  testwall:setType('static')
  testwall:setCollisionClass('Solid')

  love.graphics.draw(sprites.Holz_wand_vertic_mini, 250, 250, nil, nil, nil, 95, -100)
  testwall = world:newRectangleCollider(x, y, sprites.Holz_wand_vertic_mini:getWidth(), sprites.Holz_wand_vertic_mini:getHeight())
  testwall:setType('static')
  testwall:setCollisionClass('Solid')

  love.graphics.draw(sprites.Holz_wand_vertic_mini, 250, 250, nil, nil, nil, 83, -100)
  testwall = world:newRectangleCollider(x, y, sprites.Holz_wand_vertic_mini:getWidth(), sprites.Holz_wand_vertic_mini:getHeight())
  testwall:setType('static')
  testwall:setCollisionClass('Solid')

  love.graphics.draw(sprites.Holz_wand_vertic_mid, 250, 250, nil, nil, nil, -350, -300)
  testwall = world:newRectangleCollider(x, y, sprites.Holz_wand_vertic_mini:getWidth(), sprites.Holz_wand_vertic_mini:getHeight())
  testwall:setType('static')
  testwall:setCollisionClass('Solid')

  love.graphics.draw(sprites.Holz_wand_horiz_mid, 250, 250, nil, nil, nil, -325, -150)
  testwall = world:newRectangleCollider(x, y, sprites.Holz_wand_vertic_mini:getWidth(), sprites.Holz_wand_vertic_mini:getHeight())
  testwall:setType('static')
  testwall:setCollisionClass('Solid')

  love.graphics.draw(sprites.Holz_wand_horiz_mid, 250, 250, nil, nil, nil, -417, -70)
  testwall = world:newRectangleCollider(x, y, sprites.Holz_wand_vertic_mini:getWidth(), sprites.Holz_wand_vertic_mini:getHeight())
  testwall:setType('static')
  testwall:setCollisionClass('Solid')

  love.graphics.draw(sprites.Holz_wand_vertic_mini, 250, 250, nil, nil, nil, -460, -230)
  testwall = world:newRectangleCollider(x, y, sprites.Holz_wand_vertic_mini:getWidth(), sprites.Holz_wand_vertic_mini:getHeight())
  testwall:setType('static')
  testwall:setCollisionClass('Solid')

  love.graphics.draw(sprites.Holz_wand_vertic_mid, 250, 250, nil, nil, nil, -292.5, 50)
  testwall = world:newRectangleCollider(x, y, sprites.Holz_wand_vertic_mini:getWidth(), sprites.Holz_wand_vertic_mini:getHeight())
  testwall:setType('static')
  testwall:setCollisionClass('Solid')
  ]]
  --------------------------------------------------------------
end
