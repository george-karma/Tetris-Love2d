io.stdout:setvbuf("no")
Class = require 'Libraries/classic-master/classic'

function  love.load()
  love.window.setMode(540, 966)

  grid_x_start = 1--decides where the grid stats on the x axis
  grid_y_start = 200--decides where the grid starts on the y axis
  grid_x_size = 10-- number of cells from start
  grid_y_size = 18-- number of cells from start
  block_distance = 40 -- scalar for the whole grid, distance between cells
  block_size = 20 -- size of individual cells
  inert_grid_array ={} -- the matrix that stores pieces not moving, an array of arrays
  define_inert()
  colours_array = { --array for diffrent coloured blocks
    g ={0,255,0},
    e = {0,0,0},
    i = {47,76,94},
    j = {93,91,42},
    l = {49,85,76},
    o = {92,69,47},
    s = {83,54,93},
    t = {97,58,77},
    z = {66,83,46}
  }
  pieces_array = {
    {
      {"e","i","e"},
      {"e","i","e"},
      {"e","i","e"},
    }
  }



end

function love.update(dt)

end
--detecs keypresses
function  love.keypressed(key)
  if key == "x" then
    rotate_piece(current_piece)
  end
end


function  love.draw()
  draw_grid()
end


--draw the grid by creating circes at every x y pos
--color the each block in the grid according to what it needs to be
function draw_grid(size_x,size_y)
  --for every x and y position do the following
  for x = size_x , grid_x_size do
    for y = size_y, grid_y_size do
      --reset the colour and draw the grid outline
      love.graphics.setColor(255, 255,255)
      draw_block("g",x,y,"line")
      -- to figure out what color we should paint the current block, we look whats in the inert array at the current coordiantes and paint it that
      draw_block(inert_grid_array[x][y],x,y,"fill")
    end
  end
  for x = 1,3 do
    for y = 1, 3 do
      current_piece = pieces_array[1][y][x]
      if current_piece ~= "e" then
        draw_block(current_piece,x,y,"fill")
      end
    end
  end
end

--draw individual blocks based on their letter in the inert array
function draw_block(block,x,y,mode)
  --the local array block stores a letter that coresponds to a pre defined letter in the colour array defined on load
  --here we got a letter stored in the block variable, so we can look for the colour in the colours array and store the color in a local array
  local colour = colours_array[block]
  love.graphics.setColor(colour)
  love.graphics.circle(mode, x*block_distance + grid_x_start, y*block_distance+grid_y_start, block_size, block_size)
end

--define the grid array variable, every block is set to "e", for empty
function define_inert()
  for x = 1, grid_x_size do --create as manny matrixes inside the array as the number of cells we have on the y axis
    inert_grid_array[x] = {} -- create a new matrix inside the matrix
    for y =1, grid_y_size do --add items to the sub-array
      inert_grid_array[x][y] = "e"
    end
  end
end

function rotate_piece(table)
  local rotated_table = {}
  for i = 1,#table[1] do
    rotated_table[i] = {}
    local cell_no = 0
    for j=#table, 1,-1 do
      cell_no = cell_no+1
      rotated_table[i][cell_no] = tb[j][i]
    end
  end
  return rotated_table
end
