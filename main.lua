local world = require('world')
love.keyboard.setKeyRepeat(true)
--define objects and boundary box
--local triangle = require('entities/triangle')
local circle = require('entities/circle')
require('entities/rect')
--r.fixture:destroy()
require('entities/boundarybox')
boundarybox()
local objects = {circle}

--map keys to functions
keymap = {
  space = function()
    for i = 1,  #objects do
      objects[i].body:applyLinearImpulse(math.random(-1000, 1000), math.random(-1000, 1000))
    end
  end,
  r = function()
    local r = createrectangle(love.mouse.getPosition())
    table.insert(objects, r)
  end,
  m = function()
    for i=1, #objects do
      objects[i].fixture:destroy()
    end
    objects = {}
  end,
  c = function()
    c = {}
    c.body = love.physics.newBody(world, love.mouse.getX(), love.mouse.getY(), 'dynamic')
    c.body:setMass(1)
    c.body:setAngularDamping(1)
    c.body:setLinearDamping(0.5)
    c.shape = love.physics.newCircleShape(75/2)
    c.fixture = love.physics.newFixture(c.body, c.shape)
    c.fixture:setRestitution(1)
    c.body:setUserData(circle)
    table.insert(objects, c)
  end
}

function drawobjects(objlst)
  for i = 1, #objlst do
    if objlst[i].body:getUserData() == circle then
      love.graphics.setColor(0,1,0)
      local cx, cy = objlst[i].body:getWorldPoint(objlst[i].shape:getPoint())
      love.graphics.circle('fill', cx, cy, objlst[i].shape:getRadius())
    else
      love.graphics.setColor(1,0,0)
      love.graphics.polygon('fill', objlst[i].body:getWorldPoints(objlst[i].shape:getPoints()))
    end
  end
end

local inshape = false
local clicked = nil
function drawline(objls)
  if not clicked then
    for i = 1, #objls do
      local px, py = love.mouse.getPosition()
      if love.mouse.isDown(1) and objls[i].fixture:testPoint(px, py) then
        clicked = objls[i]
        inshape = true
      end
    end
  end
  if love.mouse.isDown(1) and inshape == true then
    local px, py = love.mouse.getPosition()
    local lx, ly = clicked.body:getWorldCenter()
    love.graphics.setColor(1,1,1)
    love.graphics.line(lx, ly, px, py)
  else
    inshape = false
  end
  
end

--update the world
love.update = function(dt)
  world:update(dt)
end

--draw
function love.draw() 
  --draw each object 
  drawobjects(objects)
  drawline(objects)
end

--when keys are pressed
function love.keypressed(key)
  if keymap[key] then
    keymap[key]()
  end
end

function love.mousereleased(x, y)
  if clicked then
    local lx, ly = clicked.body:getWorldCenter()
    clicked.body:setLinearVelocity(0, 0)
    clicked.body:applyLinearImpulse(10*(x-lx), 10*(y-ly))
    clicked = nil
  end
end

function love.resize(w, h)
  boundarybox(true)
  boundarybox()
end
