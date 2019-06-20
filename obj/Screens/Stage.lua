--Controlls things scpecific to the current screen that are not components of other objects
local Stage = Class:extend()

function Stage:new(opts)
-----------self.director = Director(self)---------------------------
	self.interface = Interface(self)--passign the current screen as an argument so we can acces the interafece
	if opts ~= nil then
		for k,v in pairs(opts) do self[k] = v end
	end
	grid_x_start = 1--decides where the grid stats on the x axis
	grid_y_start = 200--decides where the grid starts on the y axis

	self.grid = self.interface:addGameObject("Grid",grid_x_start,grid_y_start)
	self.pieces_array = {"Tall"}
	self.current_piece = nil
	--self.current_piece = self.interface:addGameObject("Tall",3,3)
	self.current_piece = self.interface:addGameObject("S",6,6)
end

function Stage:update(dt)
	self.interface:update(dt)
	--self.director:update(dt)------------------------------------------------
end

function Stage:draw()
	self.interface:draw()
end

return Stage
