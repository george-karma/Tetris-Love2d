--Controlls things scpecific to the current screen that are not components of other objects
local Stage = Class:extend()

function Stage:new(opts)
-----------self.director = Director(self)---------------------------
	self.interface = Interface(self)--passign the current screen as an argument so we can acces the interafece
	self.type = "Screen"
	grid_x_start = 1--decides where the grid stats on the x axis
	grid_y_start = 1--decides where the grid starts on the y axis
	self.grid = self.interface:addGameObject("Grid",grid_x_start,grid_y_start)
	--pieces_array = {"Tall","L","S","Square","Tank","Z"}
	pieces_array = {"Tall"}
	self.current_piece = self:next_piece()
	input:bind("r", function()
		self:reset()
	end)
	input:bind("g", function() self.interface:display_update_que() end)
	
	
	
end

function Stage:update(dt)
	self.interface:update(dt)
	--self.director:update(dt)------------------------------------------------
end

function Stage:draw()
	self.interface:draw()
end
function Stage:next_piece()
	local rand_number = love.math.random(1)
	print(pieces_array[rand_number])
	local current_piece = self.interface:addGameObject(pieces_array[rand_number],4,0)
	return current_piece
end
function Stage:reset()
	self.grid:reset()
	self.grid = nil
	self.grid = self.interface:addGameObject("Grid",grid_x_start,grid_y_start)
	--[[
	self.current_piece:reset()
	self.current_piece = nil
	self.current_piece = self:next_piece()
	]]
end


return Stage
