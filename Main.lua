require("math")
require("os")


function love.load()
    
    w = 800
    h = 600
    
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


function bool2int(value)
    return value and 1 or 0
end


function loadImages()
    local textures = {{},{},{},{},{},{},{},{}}
    textures[1] = love.image.newImageData("pics/eagle.png")
    textures[2] = love.image.newImageData("pics/redbrick.png")
    textures[3] = love.image.newImageData("pics/purplestone.png")
    textures[4] = love.image.newImageData("pics/greystone.png")
    textures[5] = love.image.newImageData("pics/bluestone.png")
    textures[6] = love.image.newImageData("pics/mossy.png")
    textures[7] = love.image.newImageData("pics/wood.png")
    textures[8] = love.image.newImageData("pics/colorstone.png")
    return textures
end


function love.update(dt)
    moveSpeed = dt * 5
    rotSpeed = dt * 3
    
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
        cameraX = 2 * x / w - 1

        rayPosX = posX
        rayPosY = posY

        rayDirX = dirX + planeX * cameraX
        rayDirY = dirY + planeY * cameraX

        mapX = math.floor(rayPosX)
        mapY = math.floor(rayPosY)

        deltaDistX = math.sqrt(1 + (rayDirY * rayDirY) / (rayDirX * rayDirX))
        deltaDistY = math.sqrt(1 + (rayDirX * rayDirX) / (rayDirY * rayDirY))
        
        hit = 0
        
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
        
        while hit == 0 do
            if sideDistX < sideDistY then
                sideDistX = sideDistX + deltaDistX
                mapX = mapX + stepX
                side = 0
            else
                sideDistY = sideDistY + deltaDistY
                mapY = mapY + stepY
                side = 1
            end
            
            if map[mapX][mapY] > 0 then 
                hit = 1 
            end
        end
          
        if side == 0 then
            perpWallDist = math.abs((mapX - rayPosX + (1 - stepX) / 2) / rayDirX)
        else
            perpWallDist = math.abs((mapY - rayPosY + (1 - stepY) / 2) / rayDirY)
        end
        
        lineHeight = math.abs(math.floor(h / perpWallDist))
        
        drawStart = -lineHeight / 2 + h / 2
        
        if drawStart < 1 then
            drawStart = 1
        end
        
        drawEnd = lineHeight / 2 + h / 2
        
        if drawEnd >= h then
            drawEnd = h
        end
        
        texNum = map[mapX][mapY]
        
        if side == 1 then
            wallX = rayPosX + ((mapY - rayPosY + (1 - stepY) / 2) / rayDirY) * rayDirX
        else
            wallX = rayPosY + ((mapX - rayPosX + (1 - stepX) / 2) / rayDirX) * rayDirY
        end
        wallX = wallX - math.floor(wallX)
        
        texX = math.floor(wallX * texWidth)

        if (side == 0 and rayDirX > 0) or (side == 1 and rayDirY < 0) then
            texX = texWidth - texX - 1
        end
        
        for y = drawStart, drawEnd do
            d = y * 256 - h * 128 + lineHeight * 128
            texY = math.floor(((d * texHeight) / lineHeight) / 256)
            index = math.floor(texHeight * texY + texX)
            imgData = texture[texNum]
            
            xIndex = index % texWidth
            yIndex = math.floor(index / texHeight)
            
            if xIndex > texWidth then xIndex = texWidth end
            if xIndex < 1 then xIndex = 1 end
            if yIndex > texHeight then yIndex = texHeight end
            if yIndex < 1 then yIndex = 1 end
            
            r, g, b, a = imgData:getPixel(xIndex - 1, yIndex - 1)
            love.graphics.setColor(r, g, b, a)
            love.graphics.point(x, y)
        end
    end
end
