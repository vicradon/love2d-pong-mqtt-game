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

        client:subscribe{ topic="playerPosition", qos=1, callback=function(msg)
          print("Successfully subscribed to playerPosition topic" )
        end}

        client:subscribe{topic = "players", qos=1, callback=function(msg)
            print("Successfully subscribed to players topic")
          end}
    end,

    message = function(msg)
        if msg.topic == "players" then
            table.insert(availablePlayers, msg.payload)
        end
        if msg.topic == "playerPosition" then
            otherPlayerLastPosition = msg.payload
        end
    end,
}  

return client