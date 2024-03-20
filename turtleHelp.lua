
-------- Turtle Helper functions --------

function Turn(side) --Right handed turtle
    if side == "L" then turtle.turnLeft() else turtle.turnRight() end
end

function TurnReverse(side) --returns opposite of Turn
    if side == "L" then Turn("R") else Turn("L") end
end

function Check(dir) --Defaults to fwd
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
    if Check(dir) then return Dig(dir) end
end

function Move(dir) --defaults to fwd
    if dir == "up" then return turtle.up()
    elseif dir == "dwn" then return turtle.down()
    else return turtle.forward()
    end
end

function DigAll(dir) --should dig until nothing is there
	repeat IfBlockDig(dir) until (not IfBlockDig(dir))
end

function Strafe(dir) 
    Turn(dir) Move() TurnReverse(dir)
end


----- compressed version of movement code above for pasting into top of programs -----

--
function Turn(side) if side=="L" then turtle.turnLeft() else turtle.turnRight() end end
function TurnReverse(side) if side=="L" then Turn("R") else Turn("L") end end

function Check(dir)if dir=="up" then return turtle.detectUp()elseif dir=="dwn" then return turtle.detectDown()else return turtle.detect()end end
function Dig(dir)  if dir=="up" then return turtle.digUp()   elseif dir=="dwn" then return turtle.digDown()   else return turtle.dig()end end
function Move(dir) if dir=="up" then return turtle.up()      elseif dir=="dwn" then return turtle.down()      else return turtle.forward()end end

function IfBlockDig(dir) if Check(dir) then return Dig(dir) end end
function DigAll(dir) repeat IfBlockDig(dir) until not IfBlockDig(dir) end
function Strafe(dir) Turn(dir) Move() TurnReverse(dir) end

FuelSlot = 16 DefaultSlot = 1
function Refuel(check)
    if (turtle.getFuelLevel() < check) then
        turtle.select(FuelSlot) local ok, err = turtle.refuel(1) turtle.select(DefaultSlot) return ok, err
    end
end


FuelSlot = 16
DefaultSlot = 1
function Refuel(check) --refuel if levels are less than 'check'
    if (turtle.getFuelLevel() < check) then
        turtle.select(FuelSlot)
        local ok, err = turtle.refuel(1)
        turtle.select(DefaultSlot)
        return ok, err
    end
end


function Dig3x3() --assumes placed in upper left (untested)
    local recipe = {
        "R", "R", "dwn",
        "L", "L", "dwn",
        "R", "R", "fwd" }
        --dig then move. go in reverse after
    for i=1,10,1 do DigAll() Move(recipe[i]) end
    for i=10,1,-1 do DigAll() Move(recipe[i]) end
end

function Dig1x2() --place at floor level
    DigAll("up") DigAll() Move("fwd")
end

function DigStairs(dir)
    --makes human walkable stairs. dir must be up or dwn
    DigAll(dir)
    Move(dir)
    DigAll(dir)
    DigAll("fwd")
    Move("fwd")
end

function DigFancyStairs(dir) 
    --makes stairs one block taller. dir must be up or dwn
	DigAll("down")
    DigAll("up")
    Move(dir)
    DigAll(dir)
    DigAll("fwd")
    Move("fwd")
end

--[[ todo 
    Inventory management
    Placing blocks, list of which blocks are acceptable to place 
    cycle through inventory, check each slot
]]