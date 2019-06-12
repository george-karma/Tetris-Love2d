--Master Game Object so all other game objects can inherit this one's attributes
local Piece = Class:extend()

function Piece:new(x,y,opts)
	self.x, self.y = x, y
	self.timer = Timer()
	self.shape = nil
	self.id = createRandomId()
	self.dead = false
	self.creationTime = love.timer.getTime()
	piece_size = 4 --how big a piece is on the x/y axis/ how manny elements there are in each sub-subarray

	input:bind("x", function() current_piece.shape= rotate_piece(current_piece.shape) end)

	input:bind("d", function()
		if self:can_piece_move_right() then
			current_piece:set_x(current_piece:get_x() +1)
		end
	end)

	input:bind("a", function()
		if self:can_piece_move_left() then
			current_piece:set_x(current_piece:get_x() -1)
		end
	end)

end

function Piece:update(dt)
	timer = timer + dt
	self:move_piece_down(0.5) --how fast should the piece move in seconds
	--only update the object if needed
	if self.timer then self.timer:update(dt) end
	--if the child object has a collider, then sync the x and y coorinates of the collider and the object
	if self.collider then self.x,self.y = self.collider:getPosition() end
	if self.sound then self.sound:update(dt) end
end

function Piece:draw()
	self:draw_moving_piece()
end

--garbage collection, possibly not used, from older ptoject
function Piece:trash()
	self.timer:destroy()
	if self.collider then self.collider:destroy() end
	if self.sound then self.sound = nil end
end

function createRandomId()
    local fn = function(x)
        local r = love.math.random(16) - 1
        r = (x == "x") and (r + 1) or (r % 4) + 9
        return ("0123456789abcdef"):sub(r, r)
    end
    return (("xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"):gsub("[xy]", fn))
end
function Piece:move_vertical(y_change)
	self.y = self.y + y_change
end

function Piece:get_x()
	return self.x
end

function Piece:set_x(x_to_be_set)
	self.x = x_to_be_set
end

function Piece:get_y()
	return self.y
end

function Piece:set_y(y_to_be_set)
	self.y = y_to_be_set
end
function rotate_piece(table)--rotates any table given by 90 degrees and returns it
  local rotated_table = {}
  for i = 1,#table[1] do
    rotated_table[i] = {}
    local cell_no = 0
    for j=#table, 1,-1 do
      cell_no = cell_no+1
      rotated_table[i][cell_no] = table[j][i]
    end
  end
  return rotated_table
end

function Piece:move_piece_down(piece_gravity)
  local timer_limit = piece_gravity --how long until when the piece moves again
  if timer >= timer_limit then
    timer = timer - timer_limit
    if self:can_piece_move_down() then
      self:move_vertical(1)
    end
  end
end

function Piece:can_piece_move_right() -- testing each individual chell of a piece to see it it goes off grid or if there is a occupied cell net to it
  for local_x = 1, piece_size do
    for local_y = 1, piece_size do
      local cell_right_neighbor = self.x + 1 + local_x --adding the x coordinate of the piece to the x coordinate of the cell +1 to refer to the cell next to the current cell
      if self.shape[local_x][local_y] ~= "e" and
        cell_right_neighbor > self.screenObject.grid:get_x_size() then
          return false
      end
    end
  end
  return true
end
function Piece:can_piece_move_left() -- testing each individual chell of a piece to see it it goes off grid or if there is a occupied cell net to it
  for x = 1, piece_size do
    for y = 1, piece_size do
      local cell_left_neighbor = self.x + (x -1) --adding the x coordinate of the piece to the x coordinate of the cell +1 to refer to the cell next to the current cell
      if self.shape[x][y] ~= "e" and
        cell_left_neighbor < 1 then
          return  false
      end
    end
  end
  return true
end
function Piece:can_piece_move_down()--can the piece move down
  for x = 1, piece_size do
    for y = 1, piece_size do
      local cell_down_neighbor = self.y + y + 1 --adding the x coordinate of the piece to the x coordinate of the cell +1 to refer to the cell next to the current cell
      if self.shape and self.shape[x][y] ~= "e" and
        cell_down_neighbor > self.screenObject.grid:get_y() then
          return  false
      end
    end
  end
  return true
end
function Piece:draw_moving_piece()--drawing the moving piece
  for x = 1, piece_size do
    for y = 1, piece_size do
        draw_block(self.shape[x][y],x+self.x,y+self.y,"fill")
    end
  end
end
function draw_block(block,x,y,mode)--draw individual blocks based on their letter in the inert array
  --the local array block stores a letter that coresponds to a pre defined letter in the colour array defined on load
  --here we got a letter stored in the block variable, so we can look for the colour in the colours array and store the color in a local array
  local colour = colours_array[block]
  love.graphics.setColor(colour)
  love.graphics.circle(mode, x*block_distance + grid_x_start, y*block_distance+grid_y_start, block_size, block_size)
end
return Piece
