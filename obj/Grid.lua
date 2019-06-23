
local Grid = Class:extend()
Grid:implement(DrawBlock) --both the Grid and Piece obj needed this behaviour so i made it into a mixin

function Grid:new(interface,x,y,opts)
  x_location,y_location = x,y
	x_size = 10 -- number of cells from start
	y_size =18 -- number of cells from start
	block_distance = 44 -- scalar for the whole grid, distance between cells
	block_size = 20 -- size of individual cells
  self.order = 1
  
	inert_grid={} -- the matrix that stores pieces not moving, an array of arrays
  define_inert(x_size,y_size)
  
end

function Grid:update(dt)
end

function Grid:draw()
  draw_inert_grid()
	--draw_grid()
end
function define_inert(x_size,y_size)--define the grid array variable, every block is set to "e", for empty
  for x = 1, x_size do --create as manny matrixes inside the array as the number of cells we have on the y axis
    inert_grid[x] = {} -- create a new matrix inside the matrix
    for y =1, y_size do --add items to the sub-array
      inert_grid[x][y] = "e"
    end
  end
end
--draw the grid by creating circes at every x y pos
--color the each block in the grid according to what it needs to be

function draw_grid()
  --for every x and y position do the following
  for x = 1 , x_size do
    for y = 1, y_size do
      --reset the colour and draw the grid outline
      love.graphics.setColor(255, 255,255)
      draw_block_shortcut("g",x,y,"line") --colour of block, size and style
    end
  end
end
function draw_inert_grid()
  --for every x and y position do the following
  for x = 1 , x_size do
    for y = 1, y_size do
      draw_block_shortcut(inert_grid[x][y],x,y,"fill")-- to figure out what color we should paint the current block, we look whats in the inert array at the current coordiantes and paint it that
    end
  end
end
function Grid:check_for_completed_rows() 
  for y = 1, y_size do
    local row_completed = true -- check every row on the y axis
    for x = 1, x_size do 
      if inert_grid[x][y] == "e" then
        row_completed = false -- if a block on the x axis is empty, then  we return false and not remove the row
      end
    end
    if row_completed then 
      print(y)
      self:remove_row(y)
    end
  end
end

function Grid:remove_row(y_position) --we loop thorugh the grid and change every block to the block that is above it form the y position of the completed line
  for y = y_position, 2,-1 do  -- we loop here until 2 because if we lop untill 1 we will get an error as the top-most row does not have anything above it
    for x = 1, x_size do 
      inert_grid[x][y] = inert_grid[x][y-1]
    end
  end
  for x = 1, x_size do --here we clear the top most row of the grid
    inert_grid[x][1] = "e"
  end
end


function Grid: get_grid_at_location(x,y)
  return inert_grid[x][y]
end
function Grid: set_grid_at_location(block,x,y)
  inert_grid[x][y] = block
end
function draw_block_shortcut(block,x,y,mode)
  Grid:draw_block(block,x,y,mode,block_distance,x_location,y_location,block_size)
end
function Grid:get_x_size()
	return x_size
end
function Grid:get_y_size()
	return y_size
end
function Grid:get_inert_grid()
  return inert_grid
end
function Grid:get_block_distance()
  return block_distance
end
function Grid:get_X_start()
  return x_location
end
function Grid:get_y_start()
  return y_location
end
function Grid:get_block_size()
  return block_size
end
return Grid
