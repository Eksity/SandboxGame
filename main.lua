local world = require('world')
local settings = require('settings')
require('entities')

--map keys to function
keymap = {
  space = function()
    for i = 1,   entities do
      entities[i].body:applyLinearImpulse(math.random(-1000, 1000), math.random(-1000, 1000))
    end
  end,
  r = function()
    local r = createrectangle(love.mouse.getPosition())
    table.insert(entities, r)
  end,
  m = function()
    for i=2,  entities do
      entities[i].fixture:destroy()
    end
    entities = {circle}
  end,
  c = function()
    local c = createcircle(love.mouse.getPosition())
    table.insert(entities, c)
  end
}

function love.update(dt)
  if settings.health == true then
    healthupdate()
  end
  if not clicked then
    world:update(dt)
  else
    world:update(dt/settings.slowfactor)
  end
end


function love.draw() 
  --draw each object 
  drawentities(entities)
  drawline(entities)
  if settings.net == true then
    drawnet(entities)
  end
end


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
