io.stdout:setvbuf("no")
print("Debugger active")
Class = require 'libs/classic-master/classic'
Input = require 'libs/boipushy-master/input'
Timer = require 'libs/chrono-master/Timer'

function  love.load()
  love.window.setMode(540, 966)
  compile_objects("obj") --automatically require all the objects and require them under the file name (they will be called with the same way as the file name), obj should be in obj folder
  input = Input() -- initialising the input library used

  timer = 0
  current_screen = nil
  go_to_room("Stage")
end

function love.update(dt)
  if current_screen then current_screen:update(dt)end
end

function love.draw()
  if current_screen then current_screen:draw()end
end


function compile_objects(path)--we first get all the file paths and store them, then we require each object/component using the file path
  local file_paths_to_require = {}
  local local_files = love.filesystem.getDirectoryItems(path) --get the naems of all the files in the "Objects" folder
  if local_files then --only require the files if there are any in the Objects folder
    for i, file in ipairs(local_files) do --for evlery file
      local file_path = path.."/"..file --create a path to the file as a string by concotenating the folder with the file
      if love.filesystem.getInfo(file_path,"file") then --if the curreft file path is a file then
        table.insert(file_paths_to_require,file_path) --insert the file path leading to the file into a table
      elseif love.filesystem.getInfo(file_path,"directory") then --if the current path is a directory
        compile_objects(file_path) --then require all the files inside that directory
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
function go_to_room(room_type)
  if current_screen then current_screen:trash() end
  current_screen = _G[room_type]()
end
