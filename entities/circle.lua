local world = require('world')
function createcircle(x, y)
	circle = {}
	circle.body = love.physics.newBody(world, 0, 0, 'dynamic')
	circle.body:setMass(1)
	circle.body:setLinearDamping(0.5)
	if x and y then
		circle.shape = love.physics.newCircleShape(x, y, 75/2)
	else
		circle.shape = love.physics.newCircleShape(640, 100, 75/2)
	end
	circle.fixture = love.physics.newFixture(circle.body, circle.shape)
	circle.fixture:setRestitution(1)
	circle.body:setUserData(circle)
	circle.draw = function(self)
		love.graphics.setColor(0,1,0)
        local cx, cy = self.body:getWorldPoint(self.shape:getPoint())
      	love.graphics.circle('fill', cx, cy, self.shape:getRadius())
	end
	return circle
end
