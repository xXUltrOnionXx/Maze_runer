require "camera"
require "draw"
require "mouse_pressed"
require "update"
require "player_mouse_angle"
require "object_collider"

systemMsg = ""

function terminalPrint(message)
   systemMsg = message
end

function love.load()
    terminalPrint("Konsole gestartet.")
    wf = require 'windfield'
    world = wf.newWorld(0, 0, false)
    world:addCollisionClass('Solid')

    sprites = {}
    sprites.background = love.graphics.newImage('sprites/background_with_walls.png')
    sprites.player = love.graphics.newImage('sprites/player.png')
    sprites.bullet = love.graphics.newImage('sprites/bullet.png')
    sprites.fireball = love.graphics.newImage('sprites/fireball.png')
    sprites.zombie = love.graphics.newImage('sprites/zombie.png')
    sprites.resized_Holz_wand_vertic_mini = love.graphics.newImage('sprites/resized_Holz_wand_vertic_mini.png')

    local Grid = require("libs.jumper.grid")
    local Pathfinder = require("libs.jumper.pathfinder")
    local map = require("map")

    local grid = Grid(map)
    pathfinder = Pathfinder(grid, 'ASTAR', 0)
    pathfinder:setMode('ORTHOGONAL')

    walls = {
      -- left wall
      {x = 0, y = 96, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 0, y = 128, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 0, y = 160, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 0, y = 192, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 0, y = 224, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 0, y = 256, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 0, y = 288, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 0, y = 320, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 0, y = 352, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 0, y = 384, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 0, y = 416, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 0, y = 448, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 0, y = 480, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 0, y = 512, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 0, y = 544, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 0, y = 576, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 0, y = 608, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 0, y = 640, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 0, y = 672, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 0, y = 704, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 0, y = 736, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 0, y = 768, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 0, y = 800, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 0, y = 832, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 0, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},

      --top walls
      {x = 0, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 33, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 66, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 99, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 132, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 165, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 198, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 231, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 264, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 297, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 330, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 363, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 396, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 429, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 462, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 495, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 528, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 561, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 594, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 627, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 660, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 693, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 726, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 759, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 792, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 825, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 858, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 891, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},

      --bot walls
      {x = 0, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 33, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 66, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 99, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 132, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 165, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 198, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 231, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 264, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 297, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 330, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 363, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 396, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 429, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 462, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 495, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 528, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 561, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 594, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 627, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 660, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 693, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 726, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 759, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 792, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 825, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 858, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 891, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},

      --right walls
      {x = 861, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 861, y = 32, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 861, y = 64, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 861, y = 96, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 861, y = 128, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 861, y = 160, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 861, y = 192, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 861, y = 224, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 861, y = 256, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 861, y = 288, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 861, y = 320, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 861, y = 352, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 861, y = 384, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 861, y = 416, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 861, y = 448, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 861, y = 480, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 861, y = 512, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 861, y = 544, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 861, y = 576, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 861, y = 608, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 861, y = 640, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 861, y = 672, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 861, y = 704, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 861, y = 736, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 861, y = 768, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 861, y = 800, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 861, y = 832, sprite = sprites.resized_Holz_wand_vertic_mini},
      {x = 861, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini}
    }

    create_wall_colliders(walls)

    player = {
        x = love.graphics.getWidth() / 2,
        y = love.graphics.getHeight() / 2,
        speed = 200,
        hp = 100,
        collider = world:newRectangleCollider(385, 287, sprites.player:getWidth(), sprites.player:getHeight())
    }

    zombies, bullets, Fireballs = {}, {}, {}
    Fireball_cost, gameState = 15, 1
    maxTime, timer, score = 2, 2, 0
    myFont, logFont = love.graphics.newFont(40), love.graphics.newFont(12)
end

function love.keypressed(key)
  if key == "return" and gameState == 1 then
    gameState = 2
    timer = maxTime
    score = 0
  end
end
--
-- require "camera"
-- require "draw"
-- require "mouse_pressed"
-- require "update"
-- require "player_mouse_angle"
-- require "object_collider"
--
-- --- Terminal ---
-- systemMsg = ""  -- Speichert nur die aktuelle Debug-Nachricht
--
-- -- Funktion zum Setzen der Debug-Nachricht
-- function terminalPrint(message)
--    systemMsg = message
-- end
-- --- Terminal ---
--
-- function love.load()
--     terminalPrint("Konsole gestartet.")
--
--     -- Windfield einbinden und Welt erstellen
--     wf = require 'windfield'
--     world = wf.newWorld(0, 0, false)
--     world:addCollisionClass('Solid')
--
--     -- Sprites laden
--     sprites = {}
--     sprites.background = love.graphics.newImage('sprites/background_with_walls.png')
--     sprites.player = love.graphics.newImage('sprites/player.png')
--     sprites.bullet = love.graphics.newImage('sprites/bullet.png')
--     sprites.fireball = love.graphics.newImage('sprites/fireball.png')
--     sprites.zombie = love.graphics.newImage('sprites/zombie.png')
--     -- sprites.resized_Holz_wand_vertic = love.graphics.newImage('sprites/resized_Holz_wand_vertic.png')
--     -- sprites.resized_Holz_wand_horiz = love.graphics.newImage('sprites/resized_Holz_wand_horiz.png')
--     -- sprites.resized_Holz_wand_vertic_mid = love.graphics.newImage('sprites/resized_Holz_wand_vertic_mid.png')
--     -- sprites.resized_Holz_wand_horiz_mid = love.graphics.newImage('sprites/resized_Holz_wand_horiz_mid.png')
--     -- sprites.resized_Holz_wand_vertic_mini = love.graphics.newImage('sprites/resized_Holz_wand_vertic_mini.png')
--     sprites.resized_Holz_wand_vertic_mini = love.graphics.newImage('sprites/resized_Holz_wand_vertic_mini.png')
--
--     -- Am Anfang ergänzen:
--     local Grid = require("libs.jumper.grid")
--     local Pathfinder = require("libs.jumper.pathfinder")
--     local map = require("map") -- unsere Map
--
--     -- Jumper vorbereiten
--     local grid = Grid(map)
--     pathfinder = Pathfinder(grid, 'ASTAR', 0)
--     pathfinder:setMode('ORTHOGONAL')
--
--     -- Wand-Objekte mit Positionen hinzufügen
--     walls = {
--       -- left wall
--       {x = 0, y = 96, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 0, y = 128, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 0, y = 160, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 0, y = 192, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 0, y = 224, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 0, y = 256, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 0, y = 288, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 0, y = 320, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 0, y = 352, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 0, y = 384, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 0, y = 416, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 0, y = 448, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 0, y = 480, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 0, y = 512, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 0, y = 544, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 0, y = 576, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 0, y = 608, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 0, y = 640, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 0, y = 672, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 0, y = 704, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 0, y = 736, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 0, y = 768, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 0, y = 800, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 0, y = 832, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 0, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
--
--       --top walls
--       {x = 0, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 33, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 66, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 99, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 132, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 165, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 198, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 231, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 264, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 297, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 330, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 363, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 396, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 429, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 462, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 495, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 528, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 561, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 594, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 627, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 660, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 693, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 726, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 759, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 792, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 825, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 858, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 891, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
--
--       --bot walls
--       {x = 0, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 33, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 66, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 99, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 132, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 165, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 198, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 231, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 264, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 297, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 330, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 363, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 396, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 429, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 462, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 495, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 528, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 561, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 594, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 627, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 660, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 693, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 726, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 759, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 792, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 825, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 858, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 891, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini},
--
--       --right walls
--       {x = 861, y = 0, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 861, y = 32, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 861, y = 64, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 861, y = 96, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 861, y = 128, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 861, y = 160, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 861, y = 192, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 861, y = 224, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 861, y = 256, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 861, y = 288, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 861, y = 320, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 861, y = 352, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 861, y = 384, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 861, y = 416, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 861, y = 448, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 861, y = 480, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 861, y = 512, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 861, y = 544, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 861, y = 576, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 861, y = 608, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 861, y = 640, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 861, y = 672, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 861, y = 704, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 861, y = 736, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 861, y = 768, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 861, y = 800, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 861, y = 832, sprite = sprites.resized_Holz_wand_vertic_mini},
--       {x = 861, y = 864, sprite = sprites.resized_Holz_wand_vertic_mini}
--     }
--
--
--     ------------------- Statische Objekte -------------------
--     -- Zeichne die Wände, die sich nicht mit der Kamera bewegen sollen
--     --draw_walls(walls)
--
--     -- Kollider für alle Wände erstellen
--     create_wall_colliders(walls)
--
--     -- Spieler-Parameter und Collider
--     player = {
--         x = love.graphics.getWidth() / 2,
--         y = love.graphics.getHeight() / 2,
--         speed = 200,
--         hp = 100,
--         collider = world:newRectangleCollider(385, 287, sprites.player:getWidth(), sprites.player:getHeight())
--     }
--
--     -- Listen für verschiedene Spielobjekte
--     zombies = {}
--     bullets = {}
--     Fireballs = {}
--     Fireball_cost = 15
--
--     -- Spielstatus und UI
--     gameState = 1
--     maxTime = 2
--     timer = maxTime
--     score = 0
--     myFont = love.graphics.newFont(40)
--
--     -- Sound laden
--     sound = love.audio.newSource("hollow.ogg", "stream")
--
--     map_drawn = false
--     timepassed = 0
--
--     print("Das Spiel wurde geladen.")
-- end
--
--
-- function love.keypressed(key, scancode, isrepeat)
--
--   if key == "return" and gameState == 1 then
--      gameState = 2
--      maxTime = 2
--      timer = maxTime
--      score = 0
--   end
--   --if key == "space" then
--     --spawnZombies()
--   --end
-- end
