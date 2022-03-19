local socket = require("socket")  -- gettime() has higher precision than os.time()
local uuid = require("libraries.uuid")
-- see also example at uuid.seed()
uuid.randomseed(socket.gettime()*10000)
return uuid