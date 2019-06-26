local ExplosionFX = Class:extend()

function ExplosionFX:new(interface,x,y,opts)
	self.interface = interface
	self.x, self.y = x,y
	self.timer = Timer()
	self.order = 5
	self.colour = opts.colour or colours_array["b"]
	self.rotation = opts.rotation or love.math.random(0,2*math.pi)
	self.size = opts.size or love.math.random(2,3)
	self.velocity = opts.size or love.math.random(75,150)
	self.line_width = opts.line_width or love.math.random(2,4)
	self.collider = self.interface.world:newCircleCollider(self.x, self.y,1)
	self.collider:setObject(self)
	self.collider:setLinearVelocity(self.velocity*math.cos(self.rotation), self.velocity*math.sin(self.rotation))
	
	self.timer:tween(opts.time or love.math.random(0.3,0.5), self,{size = 0, velocity = 0, line_width = 0},
						"linear", function()
							self.dead = true
							end)
							
end


function ExplosionFX:update(dt)
	self.timer:update(dt)
end


function ExplosionFX:draw()
	localRotation(self.x,self.y,rotation)
end

function localRotation(xLocation,yLocation,rotation)
	love.graphics.push()
	love.graphics.translate(xLocation,yLocation)
	love.graphics.rotate(rotation or 0)
	love.graphics.translate(-xLocation, -yLocation)
	love.graphics.pop()
end

function random(a,b)
	return love.math.random(a,b)
end

function ExplosionFX:trash()
	self.timer:destroy()
	if self.collider then self.collider:destroy() end
	self.collider = nil
	self.sound = nil
end

return ExplosionFX
