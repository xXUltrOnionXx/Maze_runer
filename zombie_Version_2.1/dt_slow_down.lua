function love.run()
 	if love.load then love.load() end
	-- Main loop.
	local timepassed = 0
	while true do
		love.timer.step()
		timepassed = timepassed + love.timer.getDelta()
		if love.update and timepassed > 1 then timepassed = timepassed - 1 ; love.update() end
		love.graphics.clear()
		if love.draw then love.draw() end
 		-- Process events.
		for e,a,b,c in love.event.get() do
			if e == love.event_quit then return end
			love.handlers[e](a,b,c)
		end
		love.graphics.present()
	end
end
