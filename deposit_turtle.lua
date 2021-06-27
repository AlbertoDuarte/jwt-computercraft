function clear()
    term.clear()
    term.setCursorPos(1,1)
end

function pegarDiamante()
    all = 0
    for i=1, 16, 1 do
        turtle.select(i)
        local data = turtle.getItemDetail()
        if data ~= nil and data.name == "minecraft:diamond" then
            turtle.drop(data.count)
            all = all + data.count
        end
    end

    return all
end

PC_ID = 17
rednet.open("right")
clear()

while true do
    id, message = rednet.receive(10)
    if id == PC_ID and message ~= nil then
        sleep(2)
        quantity = pegarDiamante()

        write("diamantes: ")
        write(quantity)
        write("\n")
        sleep(2)
        clear()

        rednet.send(PC_ID, quantity)
    end
end
