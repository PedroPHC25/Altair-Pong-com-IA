W,H = love.graphics.getDimensions()

function love.load()
    Player1 = {speed=300}
    Player1.height = 150
    Player1.width = 30
    Player1.x = 0
    Player1.y = H/2-Player1.height/2
    Player1.points = 0

    cpu = {speed=300}
    cpu.width = 30
    cpu.height = 150
    cpu.x = W - 30
    cpu.y = H/2-cpu.height/2
    cpu.points = 0
    
    Ball = {x=W/2, y=H/2, d=15, speed=0, xSpeed=1, ySpeed=1}
    Gamemode = {"Escolha o modo de jogo apertando 1, 2, 3, 4 ou 5"}
    d = 0

    t = 0
end

function love.update(dt)
    Random = love.math.random(1,1000)

    if love.keyboard.isDown('w') and Player1.y > 0 then
        Player1.y = Player1.y - Player1.speed * dt 
    end
    if love.keyboard.isDown('s') and Player1.y < H-Player1.height then
        Player1.y = Player1.y + Player1.speed * dt 
    end

    if t == 0 and love.keyboard.isDown('p') then
        Player1.speed = 600
        t = 1
    end

    if love.keyboard.isDown('1') then
        d = 24
        Player1.points = 0
        cpu.points = 0
        Ball.x = W/2
        Ball.y = H/2
        Ball.speed = 300
        Gamemode = {"Muito fácil"}
        Player1.speed = 300
    end

    if love.keyboard.isDown('2') then
        d = 12
        Player1.points = 0
        cpu.points = 0
        Ball.x = W/2
        Ball.y = H/2
        Ball.speed = 300
        Gamemode = {"Fácil"}
        Player1.speed = 300
    end

    if love.keyboard.isDown('3') then
        d = 6
        Player1.points = 0
        cpu.points = 0
        Ball.x = W/2
        Ball.y = H/2
        Ball.speed = 300
        Gamemode = {"Médio"}
        Player1.speed = 300
    end

    if love.keyboard.isDown('4') then
        d = 3
        Player1.points = 0
        cpu.points = 0
        Ball.x = W/2
        Ball.y = H/2
        Ball.speed = 300
        Gamemode = {"Difícil"}
        Player1.speed = 300
    end

    if love.keyboard.isDown('5') then
        d = 1
        Player1.points = 0
        cpu.points = 0
        Ball.x = W/2
        Ball.y = H/2
        Ball.speed = 300
        Gamemode = {"Muito difícil"}
        Player1.speed = 300
    end

    if Random <= d and Ball.x > 2*W/3 then
        cpu.speed = 0
    end

    if Ball.x < 2*W/3 then
        cpu.speed = 300
    end

    if cpu.y < Ball.y and cpu.y < H-cpu.height and Ball.y < H-cpu.height/2 and Ball.x > W/3 and Ball.ySpeed > 0 then
        cpu.y = cpu.y + cpu.speed * dt
    end

    if cpu.y + cpu.height/2 < Ball.y and cpu.y < H-cpu.height and Ball.y > H-cpu.height/2 and Ball.x > W - 4 * cpu.width then
        cpu.y = cpu.y + cpu.speed * dt
    end
    
    if  cpu.y < H-cpu.height and Ball.x < W/3 and cpu.y + cpu.height/2 < H/2 then
        cpu.y = cpu.y + cpu.speed * dt 
    end

    if cpu.y + cpu.height > Ball.y and cpu.y > 0 and Ball.y > cpu.height/2 and Ball.x > W/3 and Ball.ySpeed < 0 then
        cpu.y = cpu.y - cpu.speed * dt
    end

    if cpu.y + cpu.height/2 > Ball.y and cpu.y > 0 and Ball.y < cpu.height/2 and Ball.x > W - 4 * cpu.width then
        cpu.y = cpu.y - cpu.speed * dt
    end
    
    if  cpu.y < H-cpu.height and Ball.x < W/3 and cpu.y + cpu.height/2 > H/2 then
        cpu.y = cpu.y - cpu.speed * dt 
    end

    Ball.x = Ball.x + Ball.xSpeed * Ball.speed * dt
    Ball.y = Ball.y + Ball.ySpeed * Ball.speed * dt

    if Ball.y > H-1.5*Ball.d or Ball.y < 1.5*Ball.d then
        Ball.ySpeed = Ball.ySpeed * (-1)
    end

    if Ball.x > cpu.x and Ball.y > cpu.y and Ball.y < cpu.y+cpu.height then
        Ball.xSpeed = Ball.xSpeed * (-1)
        Ball.speed = Ball.speed + 10
        Player1.speed = 300
    end

    if Ball.x < Player1.x+Player1.width and Ball.y > Player1.y and Ball.y < Player1.y+Player1.height then
        Ball.xSpeed = Ball.xSpeed * (-1)
        Ball.speed = Ball.speed + 10
    end

    if Ball.x < 0 then
        Ball.x = W/2
        Ball.y = H/2
        Ball.xSpeed = Ball.xSpeed * (-1)
        cpu.points = cpu.points + 1
        Ball.speed = 300
        Player1.speed = 300
        t = 0
    end

    if Ball.x > W then
        Ball.x = W/2
        Ball.y = H/2
        Ball.xSpeed = Ball.xSpeed * (-1)
        Player1.points = Player1.points + 1
        Ball.speed = 300
        Player1.speed = 300
        t = 0
    end

    if love.keyboard.isDown('g') then
        Player1.points = 0
        cpu.points = 0
        Ball.x = W/2
        Ball.y = H/2
        Ball.speed = 300
        Player1.speed = 300
    end
end

function love.draw()
    love.graphics.rectangle('fill',Player1.x,Player1.y,Player1.width,Player1.height)
    love.graphics.rectangle('fill',cpu.x,cpu.y,cpu.width,cpu.height)
    love.graphics.circle('fill',Ball.x,Ball.y,Ball.d)
    love.graphics.print(Player1.points,50,50)
    love.graphics.print(cpu.points,W-50,50)
    love.graphics.print(Gamemode,W/2-50,50)
end