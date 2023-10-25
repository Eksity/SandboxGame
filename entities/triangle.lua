local world = require('world')
triangle = {}
triangle.body = love.physics.newBody(world, 640, 0, 'dynamic')
triangle.body:setMass(128)
triangle.shape = love.physics.newPolygonShape(-50, 100, 50, 100, 50, 200)
triangle.fixture = love.physics.newFixture(triangle.body, triangle.shape)
triangle.fixture:setUserData(triangle)
return triangle