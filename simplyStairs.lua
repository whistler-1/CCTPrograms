
-------- Turtle Helper functions --------

function TurnAround()
    turtle.turnRight()
    turtle.turnRight()
end

function DigIf(dir) --direction 
    --Detect, Dig in x direction
    --if L / R, turns back to original rotation

    if (dir == "up") then
        if(turtle.detectUp()) then return turtle.digUp() end

    elseif(dir == "dwn" or dir == "down") then
        if(turtle.detectDown()) then return turtle.digDown() end

    elseif(dir == "fwd" or dir == "forward") then
        if(turtle.detect()) then return turtle.dig() end

    elseif(dir == "L" or dir == "left") then
        turtle.turnLeft()
        if(turtle.detect()) then return turtle.dig() end
        turtle.turnRight()

    elseif(dir == "R" or dir == "right") then
        turtle.turnRight()
        if(turtle.detect()) then return turtle.dig() end
        turtle.turnLeft()

    elseif(dir == "behind") then
        TurnAround()
        if(turtle.detect()) then return turtle.dig() end
        TurnAround()

    else
        print("wrong param given to DigIf?")
        return false
    end
end


function Move(dir)
    --moves in direction dir, keeps new rotation
    if (dir == "up") then
        return turtle.up()

    elseif(dir == "dwn" or dir == "down") then
        return turtle.down()

    elseif(dir == "fwd" or dir == "forward") then
        return turtle.forward()

    elseif(dir == "L" or dir == "left") then
        turtle.turnLeft()
        return turtle.forward()

    elseif(dir == "R" or dir == "right") then
        turtle.turnRight()
        return turtle.forward()

    elseif(dir == "behind") then
        TurnAround()
        return turtle.forward()

    else print("wrong param given to Move?") return false
    end
end

function DigUntil(dir) --should dig until nothing is there
	repeat 
		DigIf(dir)
	until (not DigIf(dir))
end

function DigStairs(dir)
    --makes human walkable stairs. dir must be up, dwn or down
    DigUntil(dir)
    Move(dir)
    DigUntil(dir)
    DigUntil("fwd")
    Move("fwd")
end

function DigFancyStairs(dir) 
    --makes stairs one block taller. dir must be up, dwn or down
	DigUntil("down") 	
    DigUntil("up")
    Move(dir)
    DigUntil(dir)
    DigUntil("fwd")
    Move("fwd")
end

function Refuel(min)
    --refuel if less than min, takes fuel from slot 16
    if (turtle.getFuelLevel() < min) then
        local prevSlot = turtle.getSelectedSlot()
        turtle.select(16)
        local ok, err = turtle.refuel(2)
        turtle.select(prevSlot)
        return ok, err
    end
end


-------- Setup --------
function Setup()
    Running = true

turtle.select(16)
local fuelcheck = turtle.refuel(0)
if(fuelcheck == false) then 
    print("(Before continuing, please put some fuel in my bottom right inventory slot)") print()
end


print("Will I dig 'up' or 'down' ?  ")
Direction = read()    

print("How many blocks will I travel?  ")
local input
repeat
    print("Enter a number")
    input = tonumber(read())
until input
Distance = input 

Moved = 0			 

print("'normal' stairs, or 'fancy' ?")
Stairs = read()

turtle.select(16)
turtle.refuel(1)
turtle.select(1)
end

-------- Main --------

Setup()

while Running do
    Refuel(4)	 	   
	
	if(Stairs == "normal") then
		DigStairs(Direction)
	else 
    	DigFancyStairs(Direction)
    end
    
    Moved = Moved + 1    
    print("Dug "..Moved.." blocks "..Direction)

    if (Moved == Distance) then
        print("Distance reached!")
        Running = false
    end                  
end
