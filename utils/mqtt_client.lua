local mqtt = require("mqtt")

local client = mqtt.client{ 
    uri = "mqtt.ably.io", 
    username = "XWrECw.6f7r4Q", 
    password = "eO3rQBR313098EMjz-G7Aetpde8u_tensyTpB22n0og",
    clean = true
}
  
client:on{
    connect = function(connack)
        if connack.rc ~= 0 then
            print("connection to broker failed:", connack:reason_string(), connack)
            return
        end
        print("connected: ", connack)

        client:subscribe{ topic="input", qos=1, callback=function(msg)
          print("subscribed successfully" )
        end}
    end,

    message = function(msg)
        print("received message", msg.payload)
        table.insert(messages, msg)
        if msg.topic == "players" then
            table.insert(availablePlayers, msg.payload)
        end
    end,
}  

return client