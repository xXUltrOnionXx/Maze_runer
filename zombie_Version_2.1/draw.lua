require "zombie_player_angle"
require "draw_map"

function love.draw()
------------------- Statische Objekte -------------------
   -- Zeichne die Wände, die sich nicht mit der Kamera bewegen sollen, außerhalb des Kamera-Blocks
   --draw_walls(walls)

   ------------------- Dynamische Objekte -----------------
   -- Setze die Kamera, um bewegliche Objekte und den Hintergrund zu zeichnen
   camera:set()

   -- Zeichne die Karte oder den Hintergrund, der sich mit der Kamera bewegen soll
   draw_map()

   -- Zeichne die Wände, die sich nicht mit der Kamera bewegen sollen, außerhalb des Kamera-Blocks
   draw_walls(walls)



   -- Spielstart-Nachricht, wenn das Spiel pausiert ist
   if gameState == 1 then
       love.graphics.setFont(myFont)
       love.graphics.printf("Press enter to Start the Game", 0, 50, love.graphics.getWidth(), "center")
   end

   -- Spezialaktion bei Score >= 15
   if score >= 15 then
       Fireball_On()
   end

   -- Zeichne den Spieler
   love.graphics.draw(
       sprites.player,
       player.x,
       player.y,
       player_mouse_angle(),
       nil, nil,
       sprites.player:getWidth() / 2,
       sprites.player:getHeight() / 2
   )

   -- Zeichne Zombies
   for i, z in ipairs(zombies) do
       love.graphics.draw(
           sprites.zombie,
           z.x,
           z.y,
           zombie_player_angle(z),
           nil, nil,
           sprites.zombie:getWidth() / 2,
           sprites.zombie:getHeight() / 2
       )
   end

   -- Zeichne Kugeln
   for i, b in ipairs(bullets) do
       love.graphics.draw(
           sprites.bullet,
           b.x,
           b.y,
           nil,
           0.5, 0.5,
           sprites.bullet:getWidth() / 3,
           sprites.bullet:getHeight() / 3
       )
   end

   -- Zeichne Feuerbälle
   for i, f in ipairs(Fireballs) do
       love.graphics.draw(
           sprites.fireball,
           f.x,
           f.y,
           nil,
           2, 2,
           sprites.fireball:getWidth() / 3,
           sprites.fireball:getHeight() / 3
       )
   end

   -- Zeichne die physikalischen Welt-Elemente (falls benötigt)
   world:draw()

   -- Kamera zurücksetzen, um statische UI-Elemente zu zeichnen
   camera:unset()

   ------------------- HUD / UI Elemente -------------------
   -- Zeichne das HP- und Nachrichtensystem
   drawHPConsole(score, player.hp, systemMsg)
end


-- Score and hp
function drawHPConsole(score, hp, systemMsg)

    ---------Player Info Score-------------------------------------
    -- Set background color and draw rectangle for score
    love.graphics.setColor(0, 0, 0, 0.7) -- Semi-transparent black for the background
    love.graphics.rectangle("fill",0, 0, love.graphics.getWidth(), 30) -- Smaller box for a single line

    -- Set text color for score
    love.graphics.setColor(1, 1, 1) -- White text for the debug message

    -- Set font size (e.g., 16) and apply it for score
    local font = love.graphics.newFont(20)
    love.graphics.setFont(font)

    -- Print score
    love.graphics.print("Score: " .. score, 250, 0)

    ---------Player Info Score-------------------------------------




    ---------Player Info HP-------------------------------------
    -- Set text color for hp
    love.graphics.setColor(1, 1, 1) -- White text for the debug message

    -- Set font size (e.g., 16) and apply it for hp
    local font = love.graphics.newFont(20)
    love.graphics.setFont(font)

    -- Print hp
    love.graphics.print("HP: " .. hp, 0, 0)
    ---------Player Info HP-------------------------------------

    ---------System Info-------------------------------------
    -- Set background color and draw rectangle for score
    love.graphics.setColor(0, 0, 0, 0.7) -- Semi-transparent black for the background
    love.graphics.rectangle("fill",0, 567, love.graphics.getWidth(), 30) -- Smaller box for a single line

    -- Set text color
    love.graphics.setColor(1, 1, 1) -- White text for the debug message

    -- Set font size (e.g., 16) and apply it
    local font = love.graphics.newFont(20)
    love.graphics.setFont(font)

    -- Print the debug message at specified position
    love.graphics.print(systemMsg, 525, 567)
    ---------System Info-------------------------------------
end

function Fireball_On()
  love.graphics.printf("FireBall On", 0, love.graphics.getHeight() - 100, love.graphics.getWidth(), "right")
end
