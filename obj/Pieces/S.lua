--Master Game Object so all other game objects can inherit this one's attributes
local S = Piece:extend()

function S:new(interface,x,y,opts)
	S.super.new(self,interface,x,y,opts)
	self.shape =  {
					{"e","e","e","e"},
					{"e","e","r","r"},
					{"e","r","r","e"},
					{"e","e","e","e"}
					}
end

function S:update(dt)
S.super.update(self,dt)
end

function S:draw()
S.super.draw(self)
end

return S
