-- Kollider für Wände erstellen und die Wände platzieren
function create_wall_colliders(walls)
    for _, wall in ipairs(walls) do
        -- Erstellen eines neuen statischen Kolliders an der Position der Wand
        local collider = world:newRectangleCollider(wall.x, wall.y, wall.sprite:getWidth(), wall.sprite:getHeight())
        collider:setType('static')                   -- Setze den Kollider als statisch
        collider:setCollisionClass('Solid')          -- Setze die Kollisionsklasse auf "Solid"

        -- Speichere den Kollider als Teil des Wand-Objekts
        wall.collider = collider
    end
end

-- Zeichne die Wände an ihren definierten Positionen, außerhalb der Kamera-Transformation
function draw_walls(walls)
    for _, wall in ipairs(walls) do
        love.graphics.draw(wall.sprite, wall.x, wall.y) -- Direktes Zeichnen ohne Offset
    end
end

function wall_collider(y, x, sprites)
  love.graphics.draw(sprites.resized_Holz_wand_vertic_mini, 250, 250, nil, nil, nil, x, y)
  --blocquee
  testwall = world:newRectangleCollider(x, y, sprites.resized_Holz_wand_vertic_mini:getWidth(), sprites.resized_Holz_wand_vertic_mini:getHeight())
  testwall:setType('static')
  testwall:setCollisionClass('Solid')
end
