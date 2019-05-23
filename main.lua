
io.stdout:setvbuf("no")
Class = require 'Libraries/classic-master/classic'
Input = require 'Libraries/boipushy-master/input'
Timer = require 'Libraries/chrono-master/Timer'
Physics = require "Libraries/windfield"
Camera = require "Libraries/STALKER-X-master/Camera"
audio = require "Libraries/wave-master/wave"

function love.load()
--Getting all objects and libraries
	timer = Timer()
	input = Input()
	camera = Camera()


	objectFiles = {}
	getFileList("Objects", objectFiles)
	requireFiles(objectFiles)
--Getting all objects and libraries
	
	
	input:bind("a", "A")

	gridX = 10
	gridY = 18
	inertBlockArray = {}

	for y = 1, gridY do 	--for every row
		inertBlockArray[y] = {}
		for x = 1, gridX do --for every colum
			inertBlockArray[y][x] = " " -- make the blocks inert before using the array, i.e. fill them with " "
		end
	end

	love.window.setMode(400,800)
	mainCanvas = love.graphics.newCanvas(200,380)
	mainCanvas:setFilter("nearest","nearest")
	love.graphics.setLineStyle("rough")
	--bgc to white
	love.graphics.setBackgroundColor(255, 255, 255)

end



function love.update(dt)
	




end



function love.draw(dt)
	love.graphics.setCanvas(mainCanvas)
	love.graphics.clear()
		for y = 1, gridY do --y of row for 18 rows
			for x = 1, gridX do --x of block for 10 block per row
				local colours = {
                [' '] = {.87, .87, .87},
                i = {.47, .76, .94},
                j = {.93, .91, .42},
                l = {.49, .85, .76},
                o = {.92, .69, .47},
                s = {.83, .54, .93},
                t = {.97, .58, .77},
                z = {.66, .83, .46},
           		}
           		local block = inertBlockArray [y][x]
           		local colour = colours [block]
				love.graphics.setColor(colour)
				local blockSize = 20
				local blockDrawSize = blockSize-1
				love.graphics.rectangle("fill", (x-1)*blockSize, (y-1)*blockSize, blockDrawSize, blockDrawSize)
			end
		end 
	love.graphics.setCanvas()

	love.graphics.draw(mainCanvas,0,0,0,2,2)
end
 





-- *******FUNCTIONS CALLED ON LOAD********
function getFileList (folder, filePathList)
	local files = love.filesystem.getDirectoryItems(folder)

	--here i is the key and item is the actual item
	--we iterate the directory items and add them to the filePathList
	for i, file in ipairs(files) do
		local filePath = folder .."/".. file
		if  love.filesystem.isFile(filePath) then
			--insert the file path into the path list
			table.insert(filePathList,filePath)
				elseif love.filesystem.isDirectory(filePath) then
				getFileList(filePath, filePathList)	
		end
	end
end
--[[
	This function iterates through the objects we got from GetObjectList
	and makes it so the project requieres them, thus saving time and automatically adding all 
	required objects.
	Also worh mentionsing is that all requiered objects are defined as local in the other file
	 (i.e. circle.lua), but global in the current construct.
--]]
function requireFiles(files)
	for i,file in ipairs(files) do
		local path,fileName,extension = SplitFilename(file)
		local file = file:sub(1,-5)	
		fileName = fileName:sub(1,-5)	
		--local typeName = file:sub(9)
		--#parts is the size of parts for lists
		--_G is all global variables defined in the scope
		_G[fileName] = require(file)	
	end
end
function SplitFilename(strFilename)
	-- Returns the Path, Filename, and Extension as 3 values
	-- Uses some pattern recognition magic i should probably look into to do it
	return string.match(strFilename, "(.-)([^\\/]-%.?([^%.\\/]*))$")
end
-- *******FUNCTIONS CALLED ON LOAD********



function lerp (a,b,t)
	return a+(b-a)*t
end