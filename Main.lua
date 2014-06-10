require("math")


function love.load()
    
    w = 1024
    h = 768
    
    love.window.setMode(w, h)
    love.graphics.setDefaultFilter("nearest", "nearest")
    
    texWidth = 64
    texHeight = 64
    
    mapWidth = 24
    mapHeight = 24

    posX = 23
    posY = 12.5
    
    dirX = -1
    dirY = 0
    
    planeX = 0
    planeY = 0.66
    
    texture = loadImages()
    
    map = {{4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,7,7,7,7,7,7,7,7},
           {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0,0,0,0,7},
           {4,0,1,0,0,0,0,0,0,0,0,0,3,3,0,0,0,0,0,0,0,0,0,7},
           {4,0,2,0,0,0,0,0,0,0,0,0,3,3,0,0,0,0,0,0,0,0,0,7},
           {4,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0,0,0,0,7},
           {4,0,4,0,0,0,0,5,5,5,5,5,5,5,5,5,7,7,0,7,7,7,7,7},
           {4,0,5,0,0,0,0,5,0,5,0,5,0,5,0,5,7,0,0,0,7,7,7,1},
           {4,0,6,0,0,0,0,5,0,0,0,0,0,0,0,5,7,0,0,0,0,0,0,8},
           {4,0,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,7,7,1},
           {4,0,8,0,0,0,0,5,0,0,0,0,0,0,0,5,7,0,0,0,0,0,0,8},
           {4,0,0,0,0,0,0,5,0,0,0,0,0,0,0,5,7,0,0,0,7,7,7,1},
           {4,0,0,0,0,0,0,5,5,5,5,0,5,5,5,5,7,7,7,7,7,7,7,1},
           {6,6,6,6,6,6,6,6,6,6,6,0,6,6,6,6,6,6,6,6,6,6,6,6},
           {8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
           {6,6,6,6,6,6,0,6,6,6,6,0,6,6,6,6,6,6,6,6,6,6,6,6},
           {4,4,4,4,4,4,0,4,4,4,6,0,6,2,2,2,2,2,2,2,3,3,3,3},
           {4,0,0,0,0,0,0,0,0,4,6,0,6,2,0,0,0,0,0,2,0,0,0,2},
           {4,0,0,0,0,0,0,0,0,0,0,0,6,2,0,0,5,0,0,2,0,0,0,2},
           {4,0,0,0,0,0,0,0,0,4,6,0,6,2,0,0,0,0,0,2,2,0,2,2},
           {4,0,6,0,6,0,0,0,0,4,6,0,0,0,0,0,5,0,0,0,0,0,0,2},
           {4,0,0,5,0,0,0,0,0,4,6,0,6,2,0,0,0,0,0,2,2,0,2,2},
           {4,0,6,0,6,0,0,0,0,4,6,0,6,2,0,0,5,0,0,2,0,0,0,2},
           {4,0,0,0,0,0,0,0,0,4,6,0,6,2,0,0,0,0,0,2,0,0,0,2},
           {4,4,4,4,4,4,4,4,4,4,1,1,1,2,2,2,2,2,2,3,3,3,3,3}}
end


function loadImages()
    local textures = {{},{},{},{},{},{},{},{}}
    textures[1] = love.graphics.newImage("pics/eagle.png")
    textures[2] = love.graphics.newImage("pics/redbrick.png")
    textures[3] = love.graphics.newImage("pics/purplestone.png")
    textures[4] = love.graphics.newImage("pics/greystone.png")
    textures[5] = love.graphics.newImage("pics/bluestone.png")
    textures[6] = love.graphics.newImage("pics/mossy.png")
    textures[7] = love.graphics.newImage("pics/wood.png")
    textures[8] = love.graphics.newImage("pics/colorstone.png")
    return textures
end


function love.update(dt)
    local moveSpeed = dt * 5
    local rotSpeed = dt * 3
    
    if love.keyboard.isDown("w") then
        if map[math.floor(posX + dirX * moveSpeed)][math.floor(posY)] == 0 then
            posX = posX + dirX * moveSpeed
        end
        if map[math.floor(posX)][math.floor(posY + dirY * moveSpeed)] == 0 then
            posY = posY + dirY * moveSpeed
        end
    end
    
    if love.keyboard.isDown("s") then
        if map[math.floor(posX - dirX * moveSpeed)][math.floor(posY)] == 0 then
            posX = posX - dirX * moveSpeed
        end
        if map[math.floor(posX)][math.floor(posY - dirY * moveSpeed)] == 0 then
            posY = posY - dirY * moveSpeed
        end
    end
    
    if love.keyboard.isDown("d") then
        oldDirX = dirX
        dirX = dirX * math.cos(-rotSpeed) - dirY * math.sin(-rotSpeed)
        dirY = oldDirX * math.sin(-rotSpeed) + dirY * math.cos(-rotSpeed)
        oldPlaneX = planeX
        planeX = planeX * math.cos(-rotSpeed) - planeY * math.sin(-rotSpeed)
        planeY = oldPlaneX * math.sin(-rotSpeed) + planeY * math.cos(-rotSpeed)
    end
    
    if love.keyboard.isDown("a") then
        oldDirX = dirX
        dirX = dirX * math.cos(rotSpeed) - dirY * math.sin(rotSpeed)
        dirY = oldDirX * math.sin(rotSpeed) + dirY * math.cos(rotSpeed)
        oldPlaneX = planeX
        planeX = planeX * math.cos(rotSpeed) - planeY * math.sin(rotSpeed)
        planeY = oldPlaneX * math.sin(rotSpeed) + planeY * math.cos(rotSpeed)
    end 
end


function love.draw()

    for x = 1, w do
        local cameraX = 2 * x / w - 1

        local rayPosX = posX
        local rayPosY = posY

        local rayDirX = dirX + planeX * cameraX
        local rayDirY = dirY + planeY * cameraX

        local mapX = math.floor(rayPosX)
        local mapY = math.floor(rayPosY)

        local deltaDistX = math.sqrt(1 + (rayDirY * rayDirY) / (rayDirX * rayDirX))
        local deltaDistY = math.sqrt(1 + (rayDirX * rayDirX) / (rayDirY * rayDirY))
        
        local stepX, sideDistX, stepY, sideDistY, wallX, sideShadow
        
        if rayDirX < 0 then
            stepX = -1
            sideDistX = (rayPosX - mapX) * deltaDistX
        else
            stepX = 1
            sideDistX = (mapX + 1 - rayPosX) * deltaDistX
        end
        
        if rayDirY < 0 then
            stepY = -1
            sideDistY = (rayPosY - mapY) * deltaDistY
        else
            stepY = 1
            sideDistY = (mapY + 1 - rayPosY) * deltaDistY
        end
        
        while map[mapX][mapY] == 0 do
            if sideDistX < sideDistY then
                sideDistX = sideDistX + deltaDistX
                mapX = mapX + stepX
                side = false
            else
                sideDistY = sideDistY + deltaDistY
                mapY = mapY + stepY
                side = true
            end
        end
          
        if side then
            perpWallDist = math.abs((mapY - rayPosY + (1 - stepY) / 2) / rayDirY)
        else
            perpWallDist = math.abs((mapX - rayPosX + (1 - stepX) / 2) / rayDirX)
        end
        
        local lineHeight = math.abs(math.floor(h / perpWallDist))
        local drawStart = -lineHeight / 2 + h / 2
        local drawEnd = lineHeight / 2 + h / 2
       
        if side then
            colorMod = {127, 127, 127, 255}
            wallX = rayPosX + ((mapY - rayPosY + (1 - stepY) / 2) / rayDirY) * rayDirX
        else
            colorMod = {255, 255, 255, 255}
            wallX = rayPosY + ((mapX - rayPosX + (1 - stepX) / 2) / rayDirX) * rayDirY
        end
        
        local wallX = wallX - math.floor(wallX)
        local texX = wallX * texWidth
		local wallQuad = love.graphics.newQuad(texX, 0, 1, texHeight, texWidth, texHeight)
		local texYScale = (drawEnd - drawStart) / texHeight
        love.graphics.setColor(colorMod)
		love.graphics.draw(texture[map[mapX][mapY]], wallQuad, x, drawStart, 0, 1, texYScale)
    end
    
    -- draw FPS
    love.graphics.setColor(50, 50, 50)
    love.graphics.rectangle("fill", 5, 5, 60, 25)
    love.graphics.setColor(255, 255, 255)
    love.graphics.print("FPS: "..tostring(love.timer.getFPS()), 10, 10)
end
