require 'libs/console'
require 'libs/math'

require 'libs/LUBE'
require 'libs/TSerial'

HC = require 'libs/HC'
suit = require "libs/suit"

require "menus"

players = {}
player_bodys = {}
atMMenu = true
-- NETWORKING --

function onConnect(id)
	-- we use two different tables for the body and coords, the voords one is what is sent back to the client, the player_bodys is for the serverside Collision detection
	player_bodys[id] = Collider:addRectangle(1,1, 32,32)
	players[id] = { x = 1, y = 1, name = "Anon"}
end

function onReceive(data, id)
	if string.find(data, "name") then
		local player_name = string.sub(data, "5")
		players[id].name = player_name
	end
	
local speed = 1
	--if players[id].name == "tyrone" and data == "left" then speed = 1.1 end

	if data == 'left' then
		player_bodys[id]:move( -speed, 0 )
	elseif data == 'right' then
		player_bodys[id]:move( speed, 0 )
	end

	if data == 'up' then
		player_bodys[id]:move( 0, -speed )
	elseif data == 'down' then
		player_bodys[id]:move( 0, speed )
	end

	if data == 'quit' then
		player_bodys[id] = nil
		players[id] = nil
	end
end

function onDisconnect(id)
end

function love.draw()
  love.graphics.setBackgroundColor(100, 100, 100)
end

-- COLLISION DETECTION --
function on_collision(dt, shape_one, shape_two, mtv_x, mtv_y)
    shape_one:move(mtv_x/2, mtv_y/2)
    shape_two:move(-mtv_x/2, -mtv_y/2)
end

function love.load()
	Collider = HC( 100, on_collision )
	love.graphics.setBackgroundColor( 50, 50, 50 )

	server = lube.server(18025)
	server:setCallback(onReceive, onConnect, onDisconnect)
	server:setHandshake("chillout")
end

function love.draw()
	love.graphics.print("hello", 100, 100)
	drawMessages()
	suit.draw()
end

function love.update( dt )
	if atMMenu == true then
		mainmenu()
	end
	Collider:update( dt )
	server:update(dt)

	-- update the values to be sent across the network, we do this so the collision detection system is seperate :D
	for k, v in pairs( players ) do
		v.x,v.y = player_bodys[k]:center()
	end

	server:send( TSerial.pack( players ) )
end

function love.keypressed( key )
end

function love.keyreleased( key )
end

function love.mousepressed( x, y, key )
end