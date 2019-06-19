--Master Game Object so all other game objects can inherit this one's attributes
local Tall = Piece:extend()

function Tall:new(interface,x,y,opts)
	Tall.super.new(self,interface,x,y,opts)
	self.shape =  {
					{"e","i","e","e"},
					{"e","i","e","e"},
					{"e","i","e","e"},
					{"e","i","e","e"}
					}
end

function Tall:update(dt)
Tall.super.update(self,dt)
end

function Tall:draw()
Tall.super.draw(self)
end

return Tall
