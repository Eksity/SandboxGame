local world = require('world')
function createtriangle(x, y)
	local triangle = {}
	triangle.body = love.physics.newBody(world, 0, 0, 'dynamic')
	triangle.body:setMass(1)
	triangle.body:setAngularDamping(1)
	triangle.body:setLinearDamping(0.5)
	if x and y then
		--triangle.shape = love.physics.newPolygonShape(x,y+((75*math.sqrt(3))/2), x+(75/2),y, x-(75/2),y)
		triangle.shape = love.physics.newPolygonShape(x,y+75, x+(43.30127019),y, x-(43.30127019),y)
	else
		triangle.shape = love.physics.newPolygonShape(75/2,0, (-75/2),(75/2), (-75/2),(-75/2))
	end
	triangle.fixture = love.physics.newFixture(triangle.body, triangle.shape)
	triangle.fixture:setRestitution(1)
	triangle.fixture:setUserData(triangle)
	triangle.draw = function(self)
		love.graphics.setColor(0,0,1)
    	love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
	end
	triangle.type = 'triangle'
	triangle.health = 10
	triangle.end_contact = function(self)
    	self.health = self.health - 1
  	end
	return triangle
end