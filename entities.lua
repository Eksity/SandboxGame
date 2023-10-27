local world = require('world')
local settings = require('settings')
require('entities/circle')
require('entities/rectangle')
require('entities/triangle')
require('entities/boundarybox')
boundarybox()
local circle = createcircle()
entities = {circle}

--draws a line from center of object to mouse when clicked
local inshape = false
clicked = nil
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

--handles health per entity
function healthupdate()
  local index = 1
  while index <= #entities do
    if entities[index].health then
      if entities[index].health <= 0 then
        entities[index].fixture:destroy()
        table.remove(entities, index)
      else
        index = index + 1
      end
    else
      index = index + 1
    end
  end
end

--draws a net between centers of objects for kicks
function drawnet(objlst)
  for fr = 1, #objlst do
    frx, fry = objlst[fr].body:getWorldCenter()
    for to = 1, #objlst do
      tox, toy = objlst[to].body:getWorldCenter()
      love.graphics.setColor(1, 1, 1)
      love.graphics.line(frx, fry, tox, toy)
    end
  end
end

--draws each entity in entities table
function drawentities(objlst)
  for i = 1, #objlst do
    objlst[i]:draw()
  end
end