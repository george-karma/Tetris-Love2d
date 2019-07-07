local Score = Class:extend()

function Score:new(interface,x,y,opts)
  
  self.interface = interface
  self.timer = Timer()
  self.dead = fase
  self.x,self.y = x,y
  self.score = 0
  self.orientation = opts.orientation or 0 
  self.sx = opts.sx or 1
  self.sy = opts.sy or 1
  self.ox = opts.ox or 0 
  self.oy = opts.oy or 0 
  self.radius = 30
  self.multi = 1 --the multiplier applied to the score
  self.combo = 0
  self.time_to_combo = 1.5 --the time before the multiplier runs out
  self.visual = 10
  self.tween_visual = self.visual
  font = love.graphics.newFont("arial.ttf")
  font:setFilter("nearest", "nearest")
end

function Score:update()

end

function Score:draw()
  love.graphics.setFont(font)
  love.graphics.circle("line", self.x + self.radius/1.5, self.y + self.radius*2, self.radius, 10)
  love.graphics.print("Score " .. self.score, self.x, self.y, self.orientation,  self.sx,  self.sy, self.ox, self.oy )

end

function Score: restart_combo_timer()
  self.tween_visual = self.visual
  self.combo = 1
  self.timer:tween(self.time_to_combo, self, {tween_visual = 0},"linear", 
                  function() self.combo = 0 end)
end

function Score:trash()
  self.timer:destroy()
  if self.collider then 
    self.collider:destroy() 
    self.collider = nil
  end
  if self.sound then self.sound = nil end
end
return Score