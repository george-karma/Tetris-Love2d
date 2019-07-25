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
  self.radius_visual = 30.0
  self.radius_tween = 0.0
  self.multi = 1 --the multiplier applied to the score
  self.combo = 0
  self.max_multi = 6
  self.time_to_combo = 5 --the time before the multiplier runs out
  font = love.graphics.newFont("arial.ttf")
  font:setFilter("nearest", "nearest")
end

function Score:update(dt)
  self.timer:update(dt)
end

function Score:draw()
  love.graphics.setFont(font)
  love.graphics.circle("fill", self.x + self.radius_visual/1.5, self.y + self.radius_visual*2, self.radius_tween, 10)
  love.graphics.circle("line", self.x + self.radius_visual/1.5, self.y + self.radius_visual*2, self.radius_visual, 10)
  love.graphics.print("Score " .. self.score, self.x, self.y, self.orientation,  self.sx,  self.sy, self.ox, self.oy )
  love.graphics.setColor(colours_array["b"])
  love.graphics.print("x" .. self.multi, self.x + self.radius_visual/1.5, self.y + self.radius_visual*2, self.orientation,  self.sx,  self.sy, self.ox, self.oy )

end

function Score:restart_combo_timer()
  self.timer:cancel("combo")
  self.radius_tween = self.radius_visual
  self.timer:tween(self.time_to_combo, self, {radius_tween = 0},"linear", 
                  function() 
                    if self.multi > 1 then
                      self.multi = self.multi-1
                      self:restart_combo_timer()
                    end
                   end, "combo")
end
function Score:add_score(score_to_add)
  self.score = self.score + score_to_add*self.multi
end
function Score:reset_score()
  self.score = 0
  self.multi = 0
  self.radius_tween = 0
  self.timer:cancel("combo")
end
function Score:set_multi(multi_to_set)
  local check_multi = self.multi + multi_to_set
  if check_multi < 10 then 
    self.multi = self.multi + multi_to_set
    self:restart_combo_timer()
  else 
    self.multi = self.max_multi
  end
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