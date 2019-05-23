local Circle = Class:extend()
function Circle:new(x,y,opts)
	self.x, self.y = x, y
end
function Circle:update(dt)
end

function Circle:draw()
end

return Circle