
local Grid = Piece:extend()

function Grid:new(x,y,opts)
	Grid.super.new(self,x,y,opts)
	x_size = 10 -- number of cells from start
	y_size =18 -- number of cells from start
	block_distance = 40 -- scalar for the whole grid, distance between cells
	block_size = 20 -- size of individual cells

	inert_grid={} -- the matrix that stores pieces not moving, an array of arrays
	define_inert(x_size,y_size)
	colours_array = { --array for diffrent coloured blocks
		g = {0,255,0},
		e = {0,0,0},
		i = {47,76,94},
		j = {93,91,42},
		l = {49,85,76},
		o = {92,69,47},
		s = {83,54,93},
		t = {97,58,77},
		z = {66,83,46}
	}
end

function Grid:update(dt)
Grid.super.update(self,dt)
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
      draw_block("g",x,y,"line") --colour of block, size and style
    end
  end
end
function draw_inert_grid()
  --for every x and y position do the following
  for x = 1 , x_size do
    for y = 1, y_size do
      draw_block(inert_grid[x][y],x,y,"fill")-- to figure out what color we should paint the current block, we look whats in the inert array at the current coordiantes and paint it that
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
function Grid:get_x_size()
	return x_size
end
function Grid:get_y_size()
	return y_size
end
return Grid
