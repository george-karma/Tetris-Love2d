--Master Game Object so all other game objects can inherit this one's attributes
local Square = Piece:extend()

function Square:new(interface,x,y,opts)
	Square.super.new(self,interface,x,y,opts)
	self.shape =  {
					{"e","e","e","e"},
					{"e","i","i","e"},
					{"e","i","i","e"},
					{"e","e","e","e"}
					}
end

function Square:update(dt)
Square.super.update(self,dt)
end

function Square:draw()
Square.super.draw(self)
end

return Square
