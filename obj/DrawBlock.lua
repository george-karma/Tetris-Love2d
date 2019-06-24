DrawBlock = Class:extend()
function DrawBlock: draw_block(block,x,y,mode,block_distance,grid_x_start,grid_y_start,block_size)--draw individual blocks based on their letter in the inert array
  --the local array block stores a letter that coresponds to a pre defined letter in the colour array defined on load
  --here we got a letter stored in the block variable, so we can look for the colour in the colours array and store the color in a local array
  colour = colours_array[block]
  love.graphics.setColor(colour)
  love.graphics.circle(mode, x*block_distance + grid_x_start, y*block_distance+grid_y_start, block_size, block_size)
end

function DrawBlock: draw_block(block,x,y,mode,block_distance,grid_x_start,grid_y_start,block_size,x_previous, y_previous)--draw individual blocks based on their letter in the inert array
  --the local array block stores a letter that coresponds to a pre defined letter in the colour array defined on load
  --here we got a letter stored in the block variable, so we can look for the colour in the colours array and store the color in a local array
  
  colour = colours_array[block]
  love.graphics.setColor(colour)
  love.graphics.circle(mode, x*block_distance + grid_x_start, y*block_distance+grid_y_start, block_size, block_size)
end
return DrawBlock