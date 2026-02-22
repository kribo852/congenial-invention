--this is a comment, they are not executed as part of the program
-- a big part of the code is from the webpage for Love2D, but I have tried to add some interesting functionality as well
local utf8 = require("utf8")

function love.load()
	love.keyboard.setKeyRepeat(true)
	love.window.setTitle("Texteditor") -- set window title
    text = "" --initially, when the program loads, then the text is empty
end

function love.draw()
	--in this method, which the Love2D framework calls to draw to the screen
	--we draw the text that has accumulated in the text variable
    if text ~= "" then
    	local screen_width = love.graphics.getWidth()
		love.graphics.printf(text.."▒", 0, 0, screen_width, "left")--this is a hack to show a cursor, because it did not seem funny to calculate where the text ended
	else
		love.graphics.print("Welcome to the to the text editor, write something!", 0, 0)
	end
end

function love.keypressed(key)
    if key == "backspace" then
        -- get the byte offset to the last UTF-8 character in the string.
        local byteoffset = utf8.offset(text, -1)

        if byteoffset then
            -- remove the last UTF-8 character.
            -- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
            text = string.sub(text, 1, byteoffset - 1)
        end
    end
end

function love.textinput(t)
    text = text .. t
end

function love.update(delta_time)
	trySave()

end

function trySave()
	local ctrlDown = love.keyboard.isDown("lctrl")
	local sDown = love.keyboard.isDown("s")

	if ctrlDown and sDown then
		if not isSaved then -- hopefully this guard makes it, so that the file is just saved once per save action
			io.output("saved_text.txt")
			io.write(text)
			io.output():close()
			isSaved = true
		end
	else 
		isSaved = false
	end
end
