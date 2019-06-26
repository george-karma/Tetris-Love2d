local ExplosionFX = Class:extend()

function ExplosionFX:new(interface,x,y,opts)
	self.interface = interface
	self.x, self.y = x,y
	self.timer = Timer()
	self.order = 5
	self.colour = opts.colour or colours_array["b"]
	self.size = opts.size or love.math.random(2,3)
	
	self.timer:tween(opts.time or 0.5,self,{size = 0}, "linear",function() self.dead = true end)
							
end


function ExplosionFX:update(dt)
	self.timer:update(dt)
end


function ExplosionFX:draw()
	love.graphics.setLineWidth(5)
	love.graphics.circle("line", self.x, self.y, self.size)
	love.graphics.setLineWidth(1)
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
