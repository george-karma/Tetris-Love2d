
local Grid = Class:extend()
Grid:implement(DrawBlock) --both the Grid and Piece obj needed this behaviour so i made it into a mixin

function Grid:new(interface,x,y,opts)
  x_location,y_location = x,y
  self.interface = interface
	x_size = 10 -- number of cells from start
  y_size =22 -- number of cells from start
  y_size_playable = 18
  y_size_playable_start = y_size - y_size_playable
	block_distance = 41 -- scalar for the whole grid, distance between cells
	block_size = 19 -- size of individual cells
  self.type = "grid"
  self.order = 1
  self.timer = Timer()
  --self.interface:addGameObject("ExplosionFX",100,100,{size = 50})
	inert_grid={} -- the matrix that stores pieces not moving, an array of arrays
  define_inert(x_size,y_size)
  --[[
  inert_grid[1][22] = "i"
  inert_grid[2][22] = "i"
  inert_grid[3][22] = "i"
  inert_grid[4][22] = "i"
  inert_grid[5][22] = "i"
  inert_grid[6][22] = "i"
  inert_grid[7][22] = "i"
  inert_grid[8][22] = "i"
  inert_grid[9][22] = "i"
  inert_grid[10][22] = "i"

  inert_grid[1][21] = "i"
  inert_grid[2][21] = "i"
  inert_grid[3][21] = "i"
  inert_grid[4][21] = "i"
  inert_grid[5][21] = "i"
  inert_grid[6][21] = "i"
  inert_grid[7][21] = "i"
  inert_grid[8][21] = "i"
  inert_grid[9][21] = "i"
  inert_grid[10][21] = "i"
  ]]--
end

function Grid:update(dt)
  self.timer:update(dt)
end

function Grid:draw()
  draw_inert_grid()
	draw_grid()
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
      if y <= 4 then
        love.graphics.setColor(255, 255,255)
        draw_block_shortcut("e",x,y,"line")
      else
        --reset the colour and draw the grid outline
        love.graphics.setColor(255, 255,255)
        draw_block_shortcut("g",x,y,"line") --colour of block, size and style
      end
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
  for y = y_size_playable_start, y_size , 1 do -- from the top most playable row (4) to the bototm most row (22)
    local row_completed = true -- check every row on the y axis
    for x = 1, x_size do 
      if inert_grid[x][y] == "e" then
        row_completed = false -- if a block on the x axis is empty, then  we return false and not remove the row
      end
    end
    if row_completed and y ~= y_size_playable_start then  --if the row is compolete and it is not the top most row
      self:clear_animaiton(y)
      for y_move = y, (y_size_playable_start - 1), -1 do  --from current y to secont top most row of plyabl earea (y to 4)
        for x = 1, x_size do
          inert_grid[x][y_move] = inert_grid[x][y_move-1]
        end
      end

    end
  end
end
function Grid:clear_animaiton(y_location)
  for x = 1, x_size do
    self.interface:addGameObject("ExplosionFX",
    get_block_location_on_screen(x,y_location)["x"],
    get_block_location_on_screen(x,y_location)["y"],
    {size = 50})
 end 
end
function Grid:alternate_clear_animaiton(y_location)
  print("function alternate_clear_animaiton not implemented")
end
function Grid:is_game_over()
  for y = 1, y_size_playable_start, 1 do
    for x = 1, x_size do 
      if inert_grid[x][y] ~= "e"  then 
        return true
      end
    end
  end 
  return false
end
function Grid:reset()
  self:trash()
  self.dead = true
end

function Grid:trash()
	if self.timer then self.timer:destroy() end
	if self.collider then self.collider:destroy() end
  if self.sound then self.sound = nil end
end

function get_block_location_on_screen(block_x, block_y)
  local x = block_x * block_distance + x_location
  local y = block_y * block_distance + y_location
  local location = { x = x, y = y}
  return location
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
