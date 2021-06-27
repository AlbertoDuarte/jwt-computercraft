function clear()
    term.clear()
    term.setCursorPos(1,1)
end

TURTLE_ID = 14
rednet.open("back")

while true do
    clear()
    write("Digite quantidade de diamantes: ")
    local input = read()
     
    if tonumber(input) then
        clear()
        write("Aguarde...")
        rednet.send(TURTLE_ID, input)

        id = -1
        while id ~= TURTLE_ID do
            id, message = rednet.receive(10)
        end

        write("Operação concluída!")
    else
        write("Código invalido")
    end

    sleep(2)
     
end
