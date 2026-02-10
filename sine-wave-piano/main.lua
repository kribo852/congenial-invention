--this is a comment, they are not executed as part of the program

function love.load()
    notes = {} --notes, that can be activated when a key is pressed
    notes.z = beep(440)
    notes.x = beep(440*2^(1/8))
    notes.c = beep(440*2^(2/8))
    notes.v = beep(440*2^(3/8))
    notes.b = beep(440*2^(4/8))
    notes.n = beep(440*2^(5/8))
    notes.m = beep(440*2^(6/8))
    notes[","] = beep(440*2^(7/8))
    notes["."] = beep(440*2^(8/8)) -- these tones already exist, i just wanted to make them easy to reach
    notes["-"] = beep(440*2^(9/8))

    notes["l"] = beep(440*2^(15/16)) -- this is a half tone, should probably add more of those
    notes["k"] = beep(440*2^(13/16)) -- this is a half tone
    notes["j"] = beep(440*2^(11/16)) -- this is a half tone
    notes["h"] = beep(440*2^(9/16)) -- this is a half tone 
    notes["g"] = beep(440*2^(7/16)) -- this is a half tone 

    notes.upoctave = {} 

    notes.upoctave.z = beep(880) -- one octave up, from 440 hz
    notes.upoctave.x = beep(880*2^(1/8))
    notes.upoctave.c = beep(880*2^(2/8))
    notes.upoctave.v = beep(880*2^(3/8))
    notes.upoctave.b = beep(880*2^(4/8))
    notes.upoctave.n = beep(880*2^(5/8))
    notes.upoctave.m = beep(880*2^(6/8))
    notes.upoctave[","] = beep(880*2^(7/8))
    notes.upoctave["l"] = beep(880*2^(15/16)) -- this is a half tone
end

function love.draw()
	
end



function love.keypressed(key, scancode, isrepeat)
	upoctave = love.keyboard.isDown("lshift")

	if upoctave then
		if notes.upoctave[key] then
   			notes.upoctave[key]:play()
   		end
		return
	end

   	if notes[key] then
   		notes[key]:play()
   	end
end


function beep(tone) --tone in hz as parameter, this function gererates all the tones
	local rate      = 44100 -- samples per second
	local length    = 1/8  -- 1/8 seconds
	local p         = math.floor(rate/tone) -- 100 (wave length in samples)
	local soundData = love.sound.newSoundData(math.floor(length*rate), rate, 16, 1)
	for i=0, soundData:getSampleCount() - 1 do
		soundData:setSample(i, math.sin(2*math.pi*i/p)) -- sine wave.
	end
	
	return love.audio.newSource(soundData) 
end

