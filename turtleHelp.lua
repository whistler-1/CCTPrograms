
-------- Turtle Helper functions --------

function Turn(side) --Right handed turtle
    if side == "L" then turtle.turnLeft() else turtle.turnRight() end
end

function TurnReverse(side) --returns opposite of Turn
    if side == "L" then Turn("R") else Turn("L") end
end

function Detect(dir) --Defaults to fwd
    if dir == "up" then return turtle.detectUp()
    elseif dir == "dwn" then return turtle.detectDown()
    else return turtle.detect()
    end
end

function Dig(dir) --Defaults to fwd
    if dir == "up" then return turtle.digUp()
    elseif dir == "dwn" then return turtle.digDown()
    else return turtle.dig()
    end
end

function IfBlockDig(dir) --Defaults to fwd
    if Detect(dir) then return Dig(dir) end
end

function Move(dir) --defaults to fwd
    if dir == "up" then return turtle.up()
    elseif dir == "dwn" then return turtle.down()
    else return turtle.forward()
    end
end

function UntilClearDig(dir) --should dig until nothing is there
	repeat
		IfBlockDig(dir)
	until (not IfBlockDig(dir))
end

function Strafe(dir)
    Turn(dir) Move() TurnReverse(dir) 
end


FuelSlot = 16
DefaultSlot = 1

function TurtleRefuel(check)
    --refuel if levels are less than 'check'
    if (turtle.getFuelLevel() < check) then
        turtle.select(FuelSlot)
        local ok, err = turtle.refuel(1)
        turtle.select(DefaultSlot)
        return ok, err
    end
end


function Dig3x3() --assumes placed in upper left 

    --dig before each instruction
    local recipe = {
        "R", "R", "dwn",
        "L", "L", "dwn",
        "R", "R", "fwd"
    }

    for i=1,10,1 do
        UntilClearDig() Move(recipe[i]) 
    end
    for i=10,1,-1 do
        UntilClearDig() Move(recipe[i])
    end
end

function DigStairs(dir)
    --makes human walkable stairs. dir must be up, dwn or down
    UntilClearDig(dir)
    Move(dir)
    UntilClearDig(dir)
    UntilClearDig("fwd")
    Move("fwd")
end

function DigFancyStairs(dir) 
    --makes stairs one block taller. dir must be up, dwn or down
	UntilClearDig("down")
    UntilClearDig("up")
    Move(dir)
    UntilClearDig(dir)
    UntilClearDig("fwd")
    Move("fwd")
end