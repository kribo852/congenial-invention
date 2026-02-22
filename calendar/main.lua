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
		if os.date("%a", current_time_as_seconds+i*(24*3600)) == "Sat" or 
			os.date("%a", current_time_as_seconds+i*(24*3600)) == "Sun" then
				love.graphics.setColor(0.3, 1.0, 0.4)
		else
				love.graphics.setColor(1.0, 0.6, 0.5)
		end


		love.graphics.printf(get_current_date_display(current_time_as_seconds, i), 
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

function get_current_date_display(current_time_as_seconds, offset_in_days) 
	
	local day_and_month = os.date("%d%m", current_time_as_seconds+offset_in_days*(24*3600))

	if day_and_month == "1403" then
		return os.date("%a %d %b %Y", current_time_as_seconds+offset_in_days*(24*3600)).." PI day"
	end

	return os.date("%a %d %b %Y", current_time_as_seconds+offset_in_days*(24*3600))
end




