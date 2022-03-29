local readFile = require("utils.read_file")
local splitString = require("utils.split_string")

local envContent = readFile(".env")[1]
local API_KEY = splitString(envContent, "=")[2]

local username = splitString(API_KEY, ":")[1]
local password = splitString(API_KEY, ":")[2]

return {username = username, password = password}