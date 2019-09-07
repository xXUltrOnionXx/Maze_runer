
require "camera"
require "draw"
require "mouse_pressed"
require "update"
require "player_mouse_angle"

function love.load()

    ----------------------Collider----------------
    wf = require 'windfield' --collider
    world = wf.newWorld(0, 0, false)
    world:addCollisionClass('Solid')
    ----------------------------------------------
    sprites ={}
    sprites.player = love.graphics.newImage('sprites/player.png')
    sprites.bullet = love.graphics.newImage('sprites/bullet.png')
	  sprites.fireball = love.graphics.newImage('sprites/fireball.png')
    sprites.zombie = love.graphics.newImage('sprites/zombie.png')
    sprites.background = love.graphics.newImage('sprites/background.png')
    sprites.Holz_wand_vertic = love.graphics.newImage('sprites/Holz_wand_vertic.png')
    sprites.Holz_wand_horiz = love.graphics.newImage('sprites/Holz_wand_horiz.png')
    sprites.Holz_wand_vertic_mid = love.graphics.newImage('sprites/Holz_wand_vertic_mid.png')
    sprites.Holz_wand_horiz_mid = love.graphics.newImage('sprites/Holz_wand_horiz_mid.png')
    sprites.Holz_wand_horiz_mini = love.graphics.newImage('sprites/Holz_wand_horiz_mini.png')
    sprites.Holz_wand_vertic_mini = love.graphics.newImage('sprites/Holz_wand_vertic_mini.png')


    player = {}
    player.x = love.graphics.getWidth()/2
    player.y = love.graphics.getHeight()/2
    player.speed = 100
    player.hp = 100

    zombies = {}
    bullets = {}
    Fireballs = {}
    Fireball_cost = 15

    gameState = 1
    maxTime = 2
    timer = maxTime
    score = 0

    myFont = love.graphics.newFont(40)

    player.collider = world:newRectangleCollider(385, 287,  sprites.player:getWidth(),  sprites.player:getHeight()) --newCircleCollider(COLLIDER.x, COLLIDER.y, 30)
    player.collider:setCollisionClass('Solid')

    --testwall = world:newRectangleCollider(0, 250, 400, 30)
    --testwall:setType('static')
    --testwall:setCollisionClass('Solid')

    sound = love.audio.newSource("hollow.ogg", "stream")

end


function love.keypressed(key, scancode, isrepeat)

  if key == "return" and gameState == 1 then
     gameState = 2
     maxTime = 2
     timer = maxTime
     score = 0
  end
  --if key == "space" then
    --spawnZombies()
  --end
end
