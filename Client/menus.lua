--require "libs/binser"
--require "libs/LUBE"
suit = require "libs/suit"
require "input"

--local creativeChk = {text = ""}
local ipInput = {text = ""}
--local mapLengthInput = {text = "100"}
--local mapIsFlatInput = {text = ""}
--local mapSeedInput = {text = tostring(os.time())}
local PlayerName = {text = ""}

--mapgen = {length = 100, depth = 50, generator = "normal", seed = os.time()}

function mainmenu()
playername = suit.Input(PlayerName, 125,150,200,30)
suit.Label("Player Name", {align="left"}, 50,150,75,30)
serverip = suit.Input(ipInput, 125,200,200,30)
suit.Label("Server IP", {align="left"}, 50,200,75,30)
if suit.Button("Join Server", 50,250, 150,30).hit then
atMMenu=false
local name = PlayerName.text
local ip = ipInput.text
playing( ip, name )
end
--suit.Input(mapLengthInput, 125,275,200,30)
--suit.Label("Map Length", {align="left"}, 50,275,75,30)
--mapgen.length = tonumber(mapLengthInput.text)
--suit.Input(mapSeedInput, 125, 325, 200, 30)
--suit.Label("Map Seed", 50, 325, 75, 30)
--mapgen.seed = tonumber(mapSeedInput.text)
--if suit.Button("Host Server", 50,375, 150,30).hit then
-- require "mapgen"
--atMMenu = false  
--end
end
