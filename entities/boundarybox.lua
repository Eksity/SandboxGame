boundarybox = function(r)
	if not r then
		local world = require('world')
		local x, y = love.graphics.getDimensions()

		floor = {}
		floor.body = love.physics.newBody(world, x/2, y+1, 'static')
		floor.shape = love.physics.newRectangleShape(x, 1)
		floor.fixture = love.physics.newFixture(floor.body, floor.shape)
		floor.fixture:setUserData(floor)
		floor.type = 'wall'

		walll = {}
		walll.body = love.physics.newBody(world, -1, y/2, 'static')
		walll.shape = love.physics.newRectangleShape(1, y)
		walll.fixture = love.physics.newFixture(walll.body, walll.shape)
		walll.fixture:setUserData(walll)
		walll.type = 'wall'

		wallr = {}
		wallr.body = love.physics.newBody(world, x+1, y/2, 'static')
		wallr.shape = love.physics.newRectangleShape(1, y)
		wallr.fixture = love.physics.newFixture(wallr.body, wallr.shape)
		wallr.fixture:setUserData(wallr)
		wallr.type = 'wall'

		ceil = {}
		ceil.body = love.physics.newBody(world, x/2, -1, 'static')
		ceil.shape = love.physics.newRectangleShape(x, 1)
		ceil.fixture = love.physics.newFixture(ceil.body, ceil.shape)
		ceil.fixture:setUserData(ceil)
		ceil.type = 'wall'
	else
		floor.body:destroy()
		walll.body:destroy()
		wallr.body:destroy()
		ceil.body:destroy()
	end
end
return boundarybox