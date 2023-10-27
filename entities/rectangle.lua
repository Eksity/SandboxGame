local world = require('world')
function createrectangle(x, y)
	local rect = {}
	rect.body = love.physics.newBody(world, 0, 0, 'dynamic')
	rect.body:setMass(1)
	rect.body:setAngularDamping(1)
	rect.body:setLinearDamping(0.5)
	if x and y then
		rect.shape = love.physics.newRectangleShape(x, y, 75, 75, 0)
	else
		rect.shape = love.physics.newRectangleShape(0, 0, 75, 75, 0)
	end
	rect.fixture = love.physics.newFixture(rect.body, rect.shape)
	rect.fixture:setRestitution(1)
	rect.fixture:setUserData(rect)
	rect.draw = function(self)
		love.graphics.setColor(1,0,0)
    	love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
	end
	rect.type = 'rectangle'
	rect.health = 10
	rect.end_contact = function(self)
    	self.health = self.health - 1
  	end
	return rect
end