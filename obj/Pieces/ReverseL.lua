--Master Game Object so all other game objects can inherit this one's attributes
local ReverseL = Piece:extend()

function ReverseL:new(interface,x,y,opts)
	ReverseL.super.new(self,interface,x,y,opts)
	self.shape =  {
					{"e","e","e","e"},
					{"e","e","g","e"},
					{"e","e","g","e"},
					{"e","g","g","e"}
					}
end

function ReverseL:update(dt)
ReverseL.super.update(self,dt)
end

function ReverseL:draw()
ReverseL.super.draw(self)
end

return ReverseL
