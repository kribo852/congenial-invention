--this is a comment, they are not executed as part of the program

function love.load()
	rectangles = {}

	yellow = {red = 1, green = 1, blue = 0}
	red = {red = 1, green = 0, blue = 0}
	green = {red = 0, green = 1, blue = 0}
	blue = {red = 0, green = 0, blue = 1}
	white = {red = 1, green = 1, blue = 1}

	current_color = white

	love.window.setFullscreen(true)
end

function love.draw()
	for i,rectangle in ipairs(rectangles) do
		love.graphics.setColor(rectangle.color.red, rectangle.color.green, rectangle.color.blue)
		love.graphics.rectangle("fill", rectangle.x-10, rectangle.y-10, 20, 20) --draw all the placed rectangles
	end

	love.graphics.print("Number of objects on screen "..#rectangles, 50)
	love.graphics.print("Close the application by pressing escape ", 350)
	love.graphics.print("Use number keys to change color ", 700)

	local x = love.mouse.getX( )
	local y = love.mouse.getY( )

	love.graphics.setColor(current_color.red, current_color.green, current_color.blue)
	love.graphics.rectangle("line", x-10, y-10, 20, 20) -- draw the cursor
	
end

function love.update()
	if love.mouse.isDown(1) then
		local x = love.mouse.getX( )
		local y = love.mouse.getY( )
		if not love.keyboard.isDown("lctrl") then
			if #rectangles == 0 or rectangles[#rectangles].x ~= x or rectangles[#rectangles].y ~= y then
				table.insert(rectangles, {x=x, y=y, color=current_color})
			end
		else
			-- if control is pressed, we remove rectangles by overwriting them with other later rectangles
			remove_rectangles(x, y)
		end
	end
end

function love.keypressed(key, scancode, isrepeat)
   if key == "escape" then
      love.event.quit()
   end
   if key == "1" then
      current_color = white
   end
   if key == "2" then
      current_color = yellow
   end
   if key == "3" then
      current_color = red
   end
   if key == "4" then
      current_color = green
   end
   if key == "5" then
      current_color = blue
   end
end

-- a bit tricky, but this algorithm tries to remove rectangles by shifting over the rectangles that are to be removed
-- here, the rectangles removed are those that are close to the cursor
-- at the end, we insert nil into positions in the array, which are no longer filled
-- the garbage collector takes care of freeing the memory to be used again 
function remove_rectangles(mouse_x, mouse_y)
	local offset_removal = 0
	for i=1,#rectangles do
		while i + offset_removal <= #rectangles and 
			math.sqrt((mouse_x-rectangles[i+offset_removal].x)^2 + (mouse_y-rectangles[i+offset_removal].y)^2) < 10 do
			offset_removal = offset_removal + 1
		end

		if offset_removal > 0 then
			if i + offset_removal <= #rectangles then
				rectangles[i] = rectangles[i + offset_removal]
			else
				rectangles[i] = nil
			end
		end

	end
end

