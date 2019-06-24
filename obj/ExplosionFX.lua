local ExplosionFX = Class:extend()

function ExplosionFX:new(interface,x,y,opts)
	self.interface = interface
	self.x, self.y = x,yLocation
	self.timer = Timer()
	colour = opts.colour or colours_array["b"]
	rotation = opts.rotation or love.math.random(0,2*math.pi)
	size = opts.size or love.math.random(2,3)
	velocity = opts.size or love.math.random(75,150)
	line_width = opts.line_width or love.math.random(2,4)
	collider = self.interface.world:newCircleCollider(self.x, self.y,1)
	collider:setObject(self)
	collider:setLinearVelocity(velocity*math.cos(rotation), velocity*math.sin(rotation))
	self.timer
end


function ExplosionFX:update(dt)
	ExplosionFX.super.update(self,dt)

end


function ExplosionFX:draw()
	
end

function localRotation(xLocation,yLocation,rotation)
	love.graphics.push()
	love.graphics.translate(xLocation,yLocation)
	love.graphics.rotate(rotation or 0)
	love.graphics.translate(-xLocation, -yLocation)
end

function random(a,b)
	return love.math.random(a,b)
end
return ExplosionFX
