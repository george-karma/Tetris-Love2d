--Controlls things scpecific to the current screen that are not components of other objects
local Stage = Class:extend()

function Stage:new(opts)
-----------self.director = Director(self)---------------------------
	self.interface = Interface(self)--passign the current screen as an argument so we can acces the interafece
	grid_x_start = 1--decides where the grid stats on the x axis
	grid_y_start = 150--decides where the grid starts on the y axis
	self.interface:addPhysicsWorld()
	self.grid = self.interface:addGameObject("Grid",grid_x_start,grid_y_start)
	pieces_array = {"Tall","L","S","Square","Tank","Z"}
	self.current_piece = nil
	self.current_piece = self:next_piece()
	
	
end

function Stage:update(dt)
	self.interface:update(dt)
	self.interface:addGameObject("ExplosionFX", 100,100)
	
	--self.director:update(dt)------------------------------------------------
end

function Stage:draw()
	self.interface:draw()
end
function Stage:next_piece()
	local rand_number = love.math.random(6)
	print(pieces_array[rand_number])
	local current_piece = self.interface:addGameObject(pieces_array[rand_number],4,0)
	return current_piece
end


return Stage
