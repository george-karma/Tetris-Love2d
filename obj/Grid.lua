
local Grid = Class:extend()
Grid:implement(DrawBlock)

function Grid:new(interface,x,y,opts)
  x_location,y_location = x,y
	x_size = 10 -- number of cells from start
	y_size =18 -- number of cells from start
	block_distance = 40 -- scalar for the whole grid, distance between cells
	block_size = 20 -- size of individual cells

	inert_grid={} -- the matrix that stores pieces not moving, an array of arrays
	define_inert(x_size,y_size)

end

function Grid:update(dt)
end

function Grid:draw()
	draw_grid()
	draw_inert_grid()
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