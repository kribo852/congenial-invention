--this is a comment, they are not executed as part of the program

function love.load()
    text = "" --initially, when the program loads, then the text is empty
end

function love.draw()
	--in this method, which the Love2D framework calls to draw to the screen
	--we draw the text that has accumulated in the text variable
    if text ~= "" then
    	local width = love.graphics.getWidth()
		love.graphics.printf(text, 0, 0, width, "left")
	else
		love.graphics.print("Welcome to the to the text editor, write something!", 0, 0)
	end
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
   	-- here, it would be nice th have a key, which saves the written text to a file
   	-- maybe that is not so easy, but see if you can figure out how to do that
   	text = text..key
end