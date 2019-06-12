--Master Game Object so all other game objects can inherit this one's attributes
local Piece = Class:extend()

function Piece:new(x,y,opts)
	self.x, self.y = x, y
	self.timer = Timer()
	if opts ~= nil then
		for k,v in pairs(opts) do self[k] = v end
	end

	self.id = createRandomId()
	self.dead = false
	self.creationTime = love.timer.getTime()

end

function Piece:update(dt)
	--only update the object if needed
	if self.timer then self.timer:update(dt) end
	--if the child object has a collider, then sync the x and y coorinates of the collider and the object
	if self.collider then self.x,self.y = self.collider:getPosition() end
	if self.sound then self.sound:update(dt) end
end

function Piece:draw()

end

--garbage collection, possibly not used, from older ptoject
function Piece:trash()
	self.timer:destroy()
	if self.collider then self.collider:destroy() end
	if self.sound then self.sound = nil end
end

function createRandomId()
    local fn = function(x)
        local r = love.math.random(16) - 1
        r = (x == "x") and (r + 1) or (r % 4) + 9
        return ("0123456789abcdef"):sub(r, r)
    end
    return (("xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"):gsub("[xy]", fn))
end
function Piece:move_vertical(y_change)
	self.y = self.y + y_change
end

function Piece:get_x()
	return self.x
end

function Piece:set_x(x_to_be_set)
	self.x = x_to_be_set
end

function Piece:get_y()
	return self.y
end

function Piece:set_y(y_to_be_set)
	self.y = y_to_be_set
end

return Piece
