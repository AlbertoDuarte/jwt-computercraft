function clear()
    term.clear()
    term.setCursorPos(1,1)
end

PC_ID = 8
rednet.open("right")

function dropDiamonds(quantity)
    while quantity > 0 do
        for i=1, 16, 1 do
            if quantity == 0 then
                break
            end

            turtle.select(i)
            drop = math.min(quantity, turtle.getItemCount())
            drop = math.min(64, drop)

            quantity = quantity - drop
            turtle.drop(drop)

        end

        suckDiamond = true
        while suckDiamond do
            suckDiamond = turtle.suckUp(64)
        end
    end

end

while true do
    id, message = rednet.receive(10)
    if id == PC_ID and message ~= nil then
        write("Dropando ")
        write(message)
        write(" diamantes...\n")     
        dropDiamonds(tonumber(message))

        rednet.send(PC_ID, 0)
        sleep(0.5)
    end
    clear()
end
