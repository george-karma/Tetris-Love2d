--Master Game Object so all other game objects can inherit this one's attributes
local Tall = Piece:extend()

function Tall:new(x,y,opts)
	Tall.super.new(self,x,y,opts)
	self.shape =  {
								{"e","i","e"},
								{"e","i","e"},
								{"e","i","e"}
								}
end

function Tall:update(dt)
Tall.super.update(self,dt)
end

function Tall:draw()
end

return Tall
