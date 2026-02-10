function love.load()
    text = ""
end

function love.draw()
    love.graphics.printf(text, 0, 0, 600, "left")
end



function love.keypressed(key, scancode, isrepeat)
   	if key == "escape" then
      	love.event.quit()
   	end
   	if key == "space" then
   		text = text.." "
   		return
   	end
   	if key == "backspace" then
   		text = string.sub(text, 1, #text-1)
   		return
   	end

   	text = text..key
end