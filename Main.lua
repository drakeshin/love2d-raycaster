require("math")
require("os")

function love.load()
    
    w = 800
    h = 600
    
    mapWidth = 24
    mapHeight = 24

    posX = 22
    posY = 12
    
    dirX = -1
    dirY = 0
    
    planeX = 0
    planeY = 0.66

    map = {{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
           {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
           {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
           {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
           {1,0,0,0,0,0,2,2,2,2,2,0,0,0,0,3,0,3,0,3,0,0,0,1},
           {1,0,0,0,0,0,2,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,1},
           {1,0,0,0,0,0,2,0,0,0,2,0,0,0,0,3,0,0,0,3,0,0,0,1},
           {1,0,0,0,0,0,2,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,1},
           {1,0,0,0,0,0,2,2,0,2,2,0,0,0,0,3,0,3,0,3,0,0,0,1},
           {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
           {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
           {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
           {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
           {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
           {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
           {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
           {1,4,4,4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
           {1,4,0,4,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
           {1,4,0,0,0,0,5,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
           {1,4,0,4,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
           {1,4,0,4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
           {1,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
           {1,4,4,4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
           {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}}
    
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
        
        if drawStart < 0 then
            drawStart = 0
        end
        
        drawEnd = lineHeight / 2 + h / 2
        
        if drawEnd >= h then
            drawEnd = h
        end
        
        if side == 1 then
            sideMod = 0.5
        else
            sideMod = 1
        end
        
        if map[mapX][mapY] == 1 then
            love.graphics.setColor(255 * sideMod, 0, 0)
        elseif map[mapX][mapY] == 2 then
            love.graphics.setColor(0, 255 * sideMod, 0)
        elseif map[mapX][mapY] == 3 then
            love.graphics.setColor(0, 0, 255 * sideMod)
        elseif map[mapX][mapY] == 4 then
            local c = 255 * sideMod
            love.graphics.setColor(c, c, c)
        else
            love.graphics.setColor(255 * sideMod, 255 * sideMod, 0)
        end
        
        love.graphics.line(x, drawStart, x, drawEnd)
    end
end
