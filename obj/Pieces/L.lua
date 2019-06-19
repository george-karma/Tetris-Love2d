--Master Game Object so all other game objects can inherit this one's attributes
local L = Piece:extend()

function L:new(interface,x,y,opts)
	L.super.new(self,interface,x,y,opts)
	self.shape =  {
					{"e","e","e","e"},
					{"e","i","e","e"},
					{"e","i","e","e"},
					{"e","i","i","e"}
					}
end

function L:update(dt)
L.super.update(self,dt)
end

function L:draw()
L.super.draw(self)
end

return L
