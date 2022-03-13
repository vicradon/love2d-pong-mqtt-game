local threadCode = [[
mqtt = require "libraries/mqtt"

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
  mqtt.run_ioloop(client)
]]


function mqtt_connector()
  local thread = love.thread.newThread(threadCode)
  thread:start()
end
  