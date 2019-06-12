--The interface clas scontrolls the following:
--Draw order
--Update order
--Garbage collection for dead Objects
--adding game objects to the screen
local Interface = Class:extend()

function Interface:new(screen) --an interface is needed for every screen in the game, the interface is trashed after its no longer needed(e.g. moving to a diffrent screen)
	self.screen = screen
	self.gameObjectArray = {}

end

function Interface:update(dt)
	--We update the physics world before we update game objects so we have update physics information.
	if self.world then self.world:update(dt) end
	--Update the gameObject inside of gameObjectArray and remove dead objects from the array.
	for i = #self.gameObjectArray, 1, -1 do
		local gameObject = self.gameObjectArray[i]
		if gameObject.dead then
			table.remove(self.gameObjectArray, i)
			gameObject:trash()

		end
		gameObject:update(dt)
	end
end

function Interface:draw()
	table.sort(self.gameObjectArray, function(a,b)
			if a.order and b.order then
				return a.order<b.order
			end
		end)

	for i, gameObject in ipairs(self.gameObjectArray) do
		gameObject:draw()
	end

end

function Interface:addGameObject(type,x,y,opts)
	local opts = opts or {}
	local gameObject = _G[type](self,x or 0, y or 0, opts)
	table.insert(self.gameObjectArray, gameObject)
	return gameObject
end

--not every Interface needs a physics world, just for expansion purposes
function Interface:addPhysicsWorld()
	self.world = Physics.newWorld(0,0,true)
end

--garbage collection
function Interface:trash()
	--Trashing all the gameobjects in this level
	for i = #self.gameObjectArray, 1, -1 do
		local gameObject = self.gameObjectArray[i]
		gameObject:trash()
		table.remove(self.gameObjectArray,i)
	end
	--trashing the array itself
	self.gameObjectArray = {}
	--trashing the physics world and the reference to it
	if self.world then
		self.world:destroy()
		self.world = nil
	end
end

return Interface
