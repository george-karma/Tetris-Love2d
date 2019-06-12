io.stdout:setvbuf("no")
print("Debugger active")
Class = require 'libs/classic-master/classic'
Input = require 'libs/boipushy-master/input'
Timer = require 'libs/chrono-master/Timer'

function  love.load()
  love.window.setMode(540, 966)
  compile_objects("obj") --automatically require all the objects and require them under the file name (they will be called with the same way as the file name), obj should be in obj folder
  input = Input() -- initialising the input library used
  grid_x_start = 1--decides where the grid stats on the x axis
  grid_y_start = 200--decides where the grid starts on the y axis
  grid_x_size = 10-- number of cells from start
  grid_y_size = 18-- number of cells from start
  block_distance = 40 -- scalar for the whole grid, distance between cells
  block_size = 20 -- size of individual cells
  piece_x_size = 3 --how big a piece is on the x axis/ how manny elements there are in each sub-subarray
  piece_y_size = 3 --how big a piece is in the y axis/ how manny sub arrays are there for each pice
  timer = 0
  inert_grid_array ={} -- the matrix that stores pieces not moving, an array of arrays
  define_inert(grid_x_size,grid_y_size)
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
  pieces_array = {"Tall"}
  current_piece = Tall(3,-1)

  input:bind("x", function() current_piece.shape= rotate_piece(current_piece.shape) end)

  input:bind("d", function()
    if can_piece_move_right() then
      current_piece:set_x(current_piece:get_x() +1)
    end
  end)

  input:bind("a", function()
    if can_piece_move_left() then
      current_piece:set_x(current_piece:get_x() -1)
    end
  end)
end

function love.update(dt)
  timer = timer + dt
  move_piece_down(0.5) --how fast should the piece move in seconds
end

function love.draw()
  draw_grid() --draw the outline of the grid
  draw_inert_grid() --fill the grid accordingly
  draw_moving_piece() --draw the piece that is currently moving
end
--draw the grid by creating circes at every x y pos
--color the each block in the grid according to what it needs to be
function draw_grid()
  --for every x and y position do the following
  for x = 1 , grid_x_size do
    for y = 1, grid_y_size do
      --reset the colour and draw the grid outline
      love.graphics.setColor(255, 255,255)
      draw_block("g",x,y,"line") --colour of block, size and style
    end
  end
end
function draw_inert_grid()
  --for every x and y position do the following
  for x = 1 , grid_x_size do
    for y = 1, grid_y_size do
      draw_block(inert_grid_array[x][y],x,y,"fill")-- to figure out what color we should paint the current block, we look whats in the inert array at the current coordiantes and paint it that
    end
  end
end
function draw_moving_piece()--drawing the moving piece
  for x = 1, piece_x_size do
    for y = 1, piece_y_size do
        draw_block(current_piece.shape[x][y],x+current_piece:get_x(),y+current_piece:get_y(),"fill")
    end
  end
end
function move_piece_down(piece_gravity)
  local timer_limit = piece_gravity --how long until when the piece moves again
  if timer >= timer_limit then
    timer = timer - timer_limit
    if can_piece_move_down() then
      current_piece:move_vertical(1)
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

function define_inert(local_grid_x_size,local_grid_y_size)--define the grid array variable, every block is set to "e", for empty
  for x = 1, local_grid_x_size do --create as manny matrixes inside the array as the number of cells we have on the y axis
    inert_grid_array[x] = {} -- create a new matrix inside the matrix
    for y =1, local_grid_y_size do --add items to the sub-array
      inert_grid_array[x][y] = "e"
    end
  end
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
function can_piece_move_right() -- testing each individual chell of a piece to see it it goes off grid or if there is a occupied cell net to it
  for x = 1, piece_x_size do
    for y = 1, piece_y_size do
      local cell_right_neighbor = current_piece:get_x() +1+x --adding the x coordinate of the piece to the x coordinate of the cell +1 to refer to the cell next to the current cell
      if current_piece.shape[x][y] ~= "e" and
        cell_right_neighbor > grid_x_size then
          return false
      end
    end
  end
  return true
end
function can_piece_move_left() -- testing each individual chell of a piece to see it it goes off grid or if there is a occupied cell net to it
  for x = 1, piece_x_size do
    for y = 1, piece_y_size do
      local cell_left_neighbor = current_piece:get_x() + (x -1) --adding the x coordinate of the piece to the x coordinate of the cell +1 to refer to the cell next to the current cell
      if current_piece.shape[x][y] ~= "e" and
        cell_left_neighbor < 1 then
          return  false
      end
    end
  end
  return true
end
function can_piece_move_down()--can the piece move down
  for x = 1, piece_x_size do
    for y = 1, piece_y_size do
      local cell_down_neighbor = current_piece:get_y() + y + 1 --adding the x coordinate of the piece to the x coordinate of the cell +1 to refer to the cell next to the current cell
      if current_piece.shape[x][y] ~= "e" and
        cell_down_neighbor > grid_y_size then
          return  false
      end
    end
  end
  return true
end
function compile_objects(path)--we first get all the file paths and store them, then we require each object/component using the file path
  local file_paths_to_require = {}
  local local_files = love.filesystem.getDirectoryItems("obj") --get the naems of all the files in the "Objects" folder
  if local_files then --only require the files if there are any in the Objects folder
    for i, file in ipairs(local_files) do --for evlery file
      local file_path = "obj/"..file --create a path to the file as a string by concotenating the folder with the file
      if love.filesystem.getInfo(file_path,"file") then --if the curreft file path is a file then
        table.insert(file_paths_to_require,file_path) --insert the file path leading to the file into a table
      elseif love.filesystem.getInfo(file_path,"folder") then
        compile_objects()
      end
    end
    for i, file_path in ipairs(file_paths_to_require) do
      local path,file_name,extension = split_filename(file_path)
      local file = file_path:sub(1,-5)
      file_name = file_name:sub(1,-5)
      _G[file_name] = require(file)
      print(file_name .." --Module succesfully loaded")
    end
  end
end
function split_filename(file_name)
	-- Returns the Path, Filename, and Extension as 3 values
	-- Uses some pattern recognition black magic
	return string.match(file_name, "(.-)([^\\/]-%.?([^%.\\/]*))$")
end
