world = require('world')
circle = {}
circle.body = love.physics.newBody(world, 640, 100, 'dynamic')
circle.shape = love.physics.newCircleShape(75/2)
circle.fixture = love.physics.newFixture(circle.body, circle.shape)
circle.fixture:setRestitution(1)
circle.body:setUserData(circle)
return circle