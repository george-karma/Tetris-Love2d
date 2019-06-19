--Master Game Object so all other game objects can inherit this one's attributes
local Tank = Piece:extend()

function Tank:new(interface,x,y,opts)
	Tank.super.new(self,interface,x,y,opts)
	self.shape =  {
					{"e","i","e","e"},
					{"e","i","i","e"},
					{"e","i","e","e"},
					{"e","e","e","e"}
					}
end

function Tank:update(dt)
Tank.super.update(self,dt)
end

function Tank:draw()
Tank.super.draw(self)
end

return Tank
