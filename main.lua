local world = require('world')
love.keyboard.setKeyRepeat(true)
--define objects and boundary box
--local triangle = require('entities/triangle')
require('entities/circle')
require('entities/rect')
--r.fixture:destroy()
require('entities/boundarybox')
boundarybox()
circle = createcircle()
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
    for i=2, #objects do
      objects[i].fixture:destroy()
    end
    objects = {circle}
  end,
  c = function()
    local c = createcircle(love.mouse.getPosition())
    table.insert(objects, c)
  end
}

function drawobjects(objlst)
  for i = 1, #objlst do
    if objlst[i].shape:getType() == 'circle' then
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
  if not clicked then
    world:update(dt)
  else
    world:update(dt/4)
  end
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
