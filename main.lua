-- 
-- Abstract: Physics sample project
-- 
-- Sample code is MIT licensed, see http://www.coronalabs.com/links/code/license
-- Copyright (C) 2014 Corona Labs Inc. All Rights Reserved.

local physics = require("physics")
local gameUI = require("gameUI")

physics.start()

local bkg = display.newImage( "night_sky.png" )
bkg.x = 160; bkg.y = 240

local ground = display.newImage("ground.png") -- physical ground object
ground.x = 160; ground.y = 415
physics.addBody( ground, "static", { friction=0.5, bounce=0.3 } )

local grass2 = display.newImage("grass2.png") -- non-physical decorative overlay
grass2.x = 160; grass2.y = 464

local function newCrate()	
	local rand = math.random( 100 )
	local crate

	if (rand < 45) then
		crate = display.newImage("crate.png");
		physics.addBody( crate, { density=0.9, friction=0.3, bounce=0.3 } )
	elseif (rand < 60) then
		crate = display.newImage("crateB.png");
		physics.addBody( crate, { density=1.4, friction=0.3, bounce=0.2 } )
	elseif (rand < 80) then
		crate = display.newImage("rock.png");
		physics.addBody( crate, { density=3.0, friction=0.3, bounce=0.1, radius=33 } )
	else
		crate = display.newImage("crateC.png");
		physics.addBody( crate, { density=0.3, friction=0.2, bounce=0.5 } )
	end

	crate.x = 60 + math.random( 160 )
	crate.y = -100
	crate:addEventListener( "touch", gameUI.dragBody ) -- gameUI library for touches
end

-- Drop 120 crates. One every 500ms (0.5s).
local dropCrates = timer.performWithDelay( 500, newCrate, 120 )

local label = display.newText( { text="Drag any object around", x=160, y=50, fontSize=16 } )
label:setFillColor( 1, 0.5 )