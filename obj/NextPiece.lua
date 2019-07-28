local NextPiece = Class:extend() --we inherit from Piece so we can draw the piece objec that represents the next piece in the playarea
NextPiece:implement(DrawBlock)

function NextPiece:new(interface,x,y,opts)
  
  self.interface = interface
  self.type = "NextPiece"
  self.timer = Timer()
  self.dead = fase
  self.x,self.y = x,y
  self.orientation = opts.orientation or 0
  self.pieces = {"Tall","L","S","Square","Tank","Z","ReverseL"}
  self.piece_array = self:fill_table(3) --we fill a table with 2 pieces, can add more for future expansion
  self.sx = opts.sx or 1
  self.sy = opts.sy or 1 
  self.display_piece = nil
end

function NextPiece:update(dt)
   
end

function NextPiece:draw()
  love.graphics.setFont(font)
  love.graphics.setColor(colours_array["g"])
  love.graphics.print("Next piece:", self.x, self.y, self.orientation,  self.sx,  self.sy)
  if self.display_piece then
    self:draw_display_piece()
  end
end
  
function NextPiece:return_piece() --return the last piece in the array as a string
  local piece_to_return = self.piece_array[#self.piece_array] -- the last piece in the array
  self:refresh_table()
  self.display_piece= _G[self.piece_array[#self.piece_array]](self,x,y,{is_piece = false})
  return piece_to_return
end
function NextPiece:refresh_table() --slides the array to replace the piece we returned and replaces the fist piece in the array
  for i= #self.piece_array,2,-1 do--from the last element in the array to the second in units of -1 
    self.piece_array[i] = self.piece_array[i-1]
  end
  self.piece_array[1] = self:return_random_piece() 
end
function NextPiece:fill_table(piece_number) --fills and returns a table with  the requested number of pieces a sstrings
  local arr = {}
  for i = 1 , piece_number do 
    arr[i] = self:return_random_piece()
  end
  return arr
end
function NextPiece:return_random_piece() --return one random piece as a string
  local rand_number = love.math.random(#self.pieces) --chose a number based on how manny pieces there are
  return self.pieces[rand_number]
end
function NextPiece:draw_display_piece()
  for y = 1, piece_size do
    for x = 1, piece_size do
      if self.display_piece.shape[x][y] ~= "e" then
       self:draw_block_shortcut(self.display_piece.shape[x][y],x,y,"fill")
      end
    end
  end
end

function NextPiece:draw_block_shortcut(block,x,y,mode)
  self:draw_block(block,x,y,mode, 22, self.x-10,self.y+12,10)
end

return NextPiece