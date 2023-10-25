local world = require('world')
rect = {}
rect.body = love.physics.newBody(world, 640, 100, 'dynamic')
rect.body:setMass(1)
rect.body:setAngularDamping(1)
rect.body:setLinearDamping(0.5)
rect.shape = love.physics.newRectangleShape(0, 0, 75, 75, 0)
rect.fixture = love.physics.newFixture(rect.body, rect.shape)
rect.fixture:setRestitution(1)
rect.fixture:setUserData(rect)
return rect