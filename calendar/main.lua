--this is a comment, they are not executed as part of the program

function love.load()
   animation_function = function() return 0 end
   cur_date = os.date("*t")
   entry_height = 19
end

function love.draw()
	local width = love.graphics.getWidth()
	
	local animation_offset = animation_function()
	local current_time_as_seconds = os.time(cur_date)
	for i=0,120 do
		love.graphics.printf(os.date("%a %d %b %Y", current_time_as_seconds+i*(24*3600)), 
			10+math.floor(i/30)*200, 19*(i%30)+animation_offset, width, "left")
	end
	love.graphics.print("Use up/down to navigate", 25, love.graphics.getHeight() - 15)
end


function love.keypressed(key, scancode, isrepeat)

	if key == "up" then
		animation_function = prev_day_animation()
	end
	if key == "down" then
		animation_function = next_day_animation()
	end
   	
end

function prev_day_animation()
	local animation = 1

	return function()
		if animation > 0 then
			animation = animation + 1
			if animation == entry_height then
				animation=0
				local current_time_as_seconds = os.time(cur_date)
				cur_date = os.date("*t", current_time_as_seconds-(24*3600)) 
			end
		end
		return animation
	end
end	

function next_day_animation()
	local animation = -1

	return function()
		if animation < 0 then
			animation = animation - 1
			if animation ==- entry_height then
				animation = 0
				local current_time_as_seconds = os.time(cur_date)
				cur_date = os.date("*t", current_time_as_seconds+(24*3600)) 
			end
		end
		return animation
	end
end




