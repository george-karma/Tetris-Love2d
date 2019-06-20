--Master Game Object so all other game objects can inherit this one's attributes
local Z = Piece:extend()

function Z:new(interface,x,y,opts)
	Z.super.new(self,interface,x,y,opts)
	self.shape =  {
					{"e","e","e","e"},
					{"i","i","e","e"},
					{"e","i","i","e"},
					{"e","e","e","e"}
					}
end

function Z:update(dt)
Z.super.update(self,dt)
end

function Z:draw()
Z.super.draw(self)
end

return Z
