local mqtt = require("mqtt")
local authDetails = require("utils.auth_agent")

local client = mqtt.client{ 
    uri = "mqtt.ably.io",
    username = authDetails.username,
    password = authDetails.password,
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

        client:subscribe{topic = "playerScores", qos=1, callback=function(msg)
            print("Successfully subscribed to playerScores topic")
        end}
    end,

    message = function(msg)
        if msg.topic == "players" then
            table.insert(availablePlayers, msg.payload)
        end
        if msg.topic == "playerPosition" then
            otherPlayerLastPosition = msg.payload
        end
        if msg.topic == "playerScores" then
            lastPlayerScore = msg.payload
        end
    end,
}  

return client