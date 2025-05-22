function love.run()
    if love.load then love.load() end

    -- Target frame duration (1/60 for 60 FPS)
    local targetFrameDuration = 1 / 60
    local accumulatedTime = 0

    -- Main loop
    while true do
        -- Calculate time passed since last frame
        love.timer.step()
        local dt = love.timer.getDelta()
        accumulatedTime = accumulatedTime + dt

        -- Update once per target frame duration to maintain a stable frame rate
        while accumulatedTime >= targetFrameDuration do
            if love.update then
                love.update(targetFrameDuration)  -- Pass the fixed `dt`
            end
            accumulatedTime = accumulatedTime - targetFrameDuration
        end

        -- Clear the screen for the next frame
        love.graphics.clear()

        -- Draw if the function is defined
        if love.draw then
            love.draw()
        end

        -- Process all queued events
        for event, a, b, c in love.event.get() do
            if event == "quit" then
                if love.quit then
                    love.quit()
                end
                return
            end
            love.handlers[event](a, b, c)
        end

        -- Present the drawn frame
        love.graphics.present()
    end
end
