mqtt = require "mqtt"

local client = mqtt.client{ 
    uri = "mqtt.ably.io", 
    username = "XWrECw.6f7r4Q", 
    password = "eO3rQBR313098EMjz-G7Aetpde8u_tensyTpB22n0og",
    clean = true
    -- port = 8883
}
  
client:on{
    connect = function(connack)
        if connack.rc ~= 0 then
            print("connection to broker failed:", connack:reason_string(), connack)
            return
        end

        print("connected: ", connack)

        -- assert(client:publish{
        --     topic = "input",
        --     payload = "hello from lua",
        --     qos = 1
        -- })

        -- connection established, now subscribe to test topic and publish a message after
        assert(client:subscribe{ topic="input", qos=1, callback=function()
              print("Hi")
            --assert(client:publish{ topic = "luamqtt/simpletest", payload = "hello" })
        end})
    end,

    message = function(msg)
        assert(client:acknowledge(msg))

        -- receive one message and disconnect
        print("received message", msg)
        client:disconnect()
    end,
}


  
function love.load()
  didItWork = client:start_connecting()
  print(didItWork)
  players = { -- init individual player controls
    { up = function() return love.keyboard.isDown("w") end,
      down = function() return love.keyboard.isDown("s") end,},
    { up = function() return love.keyboard.isDown("up") end,
      down = function() return love.keyboard.isDown("down") end}
  }
  for _,v in pairs(players) do -- init player vars
    v.y = love.graphics.getHeight()/2 -- half way on the screen vertically
    v.score = 0
  end
  paddle = { -- object for paddle config
    width = 20, -- total width
    height = 100, -- total height
    speed = 300 -- 300px/second
  }
  ball = { -- object for ball config
    -- normally, this would be the speed according to delta time (dt), so it would be 10px/s,
    -- but to ensure accuracy of the paddle, we use 10px/frame.
    -- The issue is that the speed may not exceed the paddle width, otherwise the ball
    -- may skip over the paddle for large enough sizes of dt.
    speed = 10, -- 10px/frame at ~60frames/second gives 600px/second
    init = function() -- re-init the ball when player scores
      ball.x = love.graphics.getWidth()/2 -- half way on the screen horizontally
      ball.y = love.graphics.getHeight()/2 -- half way on the screen vertically
      ball.vy = 0 -- velocity of the ball vertically
      -- on reset, send the ball to the victor. If new game randomly choose a direction.
      ball.direction = ball.direction and -ball.direction or math.random(0,1)*2-1
      ball.wait = 1 -- amount of time to wait before serving the ball
    end,
    paddleCollide = function(player) -- when the ball is in the paddle section
      if ball.y < player.y + paddle.height/2 and -- if ball is below the top of the paddle
        ball.y > player.y - paddle.height/2 then -- and the ball is above the bottom of the paddle
        ball.direction = ball.direction * -1 -- reverse the direction
        -- use the difference of the center to amend the velocity of the ball vertically
        ball.vy = ball.vy + (ball.y - player.y)/paddle.height*4
      end
    end,
    playerScore = function(player) -- when the ball is in the score area
      player.score = player.score + 1 -- increment player's score
      ball.init() -- reset game
    end
  }
  ball.init() -- new game
end

function love.draw()
  love.graphics.print("mqtt", 100, 100)
  for i,v in pairs(players) do -- for each player
    love.graphics.rectangle("fill", -- draw the player's paddle
      -- start x on the side determined by the index of the player
      -- with the paddle's width as padding 
      (i-1)*(love.graphics.getWidth()-paddle.width),
      v.y-paddle.height/2, -- start y above the current y by half the paddle height
      paddle.width,paddle.height) -- draw the paddle width and height
  end
  love.graphics.circle("fill",ball.x,ball.y,4) -- draw the ball
  love.graphics.printf(players[1].score..":"..players[2].score, -- draw the two scores
    0,0,-- draw the score from the upper left
    love.graphics.getWidth(),"center") -- define the width as the screen width and center it
end

function love.update(dt)
  for i,v in pairs(players) do -- for each player
    if v.up() then -- if the up button is pressed for current player
      
      v.y = v.y - paddle.speed*dt -- move paddle up by paddle speed over dt (px/second)
    end  
    if v.down() then -- if the down button is pressed for current player
      v.y = v.y + paddle.speed*dt -- move paddle down by paddle speed over dt (px/second)
    end
     -- Clamp the top and bottom paddle movement, respectively.
    if v.y < 0 then v.y = 0 end
    if v.y > love.graphics.getHeight() then v.y = love.graphics.getHeight() end
  end
  if ball.wait then -- while waiting for the ball
    ball.wait = ball.wait - dt -- subtract dt from waiting time
    if ball.wait <= 0 then ball.wait = nil end -- clear wait when done
  else -- not waiting for the ball
    ball.x = ball.x + ball.speed*ball.direction -- move the ball's x by it's speed in it's direction
    ball.y = ball.y + ball.vy -- move the ball's y by it's vertical velocity
    if ball.y < 0 then -- if the ball hits the top
      ball.y = -ball.y -- mirror the ball across the top
      ball.vy = -ball.vy -- reverse the vertical velocity
    elseif ball.y > love.graphics.getHeight() then -- if the ball hits the bottom
      ball.y = ball.y - (ball.y - love.graphics.getHeight()) -- mirror across the bottom
      ball.vy = -ball.vy -- reverse the vertical velocity
    end
    if ball.x > love.graphics.getWidth() then -- if ball in player 2 score area
      ball.playerScore(players[1]) -- check player 1 score
    elseif ball.x > love.graphics.getWidth() - paddle.width then -- if ball in player 2 paddle area
      ball.paddleCollide(players[2]) -- check player 2 collision
    elseif ball.x < 0  then -- if ball in player 1 score area
      ball.playerScore(players[2]) -- check player 2 score
    elseif ball.x < paddle.width then -- if ball in player 2 paddle area
      ball.paddleCollide(players[1]) -- check player 1 collision
    end
  end
end