
-------- Turtle Helper functions --------
-- These have been compressed to take up less space, more readable versions can be found in turtleHelp.lua
function Turn(side) if side=="L" then turtle.turnLeft() else turtle.turnRight() end end
function TurnReverse(side) if side=="L" then Turn("R") else Turn("L") end end
function Check(dir)if dir=="up" then return turtle.detectUp()elseif dir=="dwn" then return turtle.detectDown()else return turtle.detect()end end
function Dig(dir)  if dir=="up" then return turtle.digUp()   elseif dir=="dwn" then return turtle.digDown()   else return turtle.dig()end end
function Move(dir) if dir=="up" then return turtle.up()      elseif dir=="dwn" then return turtle.down()      else return turtle.forward()end end
function IfBlockDig(dir) if Check(dir) then return Dig(dir) end end
function DigAll(dir) repeat IfBlockDig(dir) until not IfBlockDig(dir) end
function Strafe(dir) Turn(dir) Move() TurnReverse(dir) end

-------- Manage Fuel --------
FuelSlot = 16 DefaultSlot = 1
function Refuel(check)
    FuelLevel = turtle.getFuelLevel()
    if (FuelLevel < check) then turtle.select(FuelSlot)
        local ok, err = turtle.refuel(1)
        turtle.select(DefaultSlot)
        FuelLevel = turtle.getFuelLevel()
        return FuelLevel, ok, err
    end
end


-------- Dig --------
function DigStairs(dir) --dir must be up, dwn or down
	DigAll("dwn")
    DigAll("up")
    Move(dir)
    DigAll(dir)
    DigAll("fwd")
    Move("fwd")
end

function Dig1x2() --place at floor level
    DigAll("up") DigAll("fwd") Move("fwd")
end


-------- Setup --------
turtle.select(FuelSlot)
local fuelcheck = turtle.refuel(0)
if fuelcheck == false then
    local warning = "(First, please put fuel in my bottom right inventory slot)"
    print(warning.."\a".."\n")
end

print("Will I dig 'forward' 'up' or 'down' ?  ")
Direction = read()
if Direction == "down" then Direction = "dwn" end

print("How many blocks will I travel?  ")
local input
repeat
    print("Enter a number")
    input = tonumber(read())
until input
Distance = input

turtle.refuel(1) turtle.select(DefaultSlot)


-------- Main --------
Moved = 0
Running = true

while Running do
    Refuel(1)

	if Direction == "forward" then
		Dig1x2()
    else
    	DigStairs(Direction)
    end
    Moved = Moved + 1
    print("Moved "..Moved.." blocks "..Direction)

    if (Moved == Distance) then
        Running = false print("Distance reached!")
    end
end
