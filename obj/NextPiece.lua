local NextPiece = Piece:extend()

function NextPiece:new(interface,x,y,opts)
  
  self.interface = interface
  self.type = "NextPiece"
  self.timer = Timer()
  self.dead = fase
  self.x,self.y = x,y
  self.orientation = opts.orientation or 0
  self.sx = opts.sx or 1
  self.sy = opts.sy or 1 
  
  
end

function NextPiece:update(dt)
  self.timer:update(dt)

end

function NextPiece:draw()
  love.graphics.setFont(font)
  love.graphics.setColor(colours_array["g"])
  love.graphics.print("Next piece:", self.x, self.y, self.orientation,  self.sx,  self.sy)
  love.graphics.line(480,1,480,1000)
end

return NextPiece