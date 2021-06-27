function clear()
    term.clear()
    term.setCursorPos(1,1)
end

TURTLE_ID = 20
rednet.open("back")

while true do
     clear()
     write("Digite o seu código: ")
     local input = read()
    
     rednet.send(TURTLE_ID, "vai garoto")
     id = -1
     while id ~= TURTLE_ID do
        id, message = rednet.receive(10)
     end

     write("Depositado ")
     write(message)
     write(" diamantes!")
     sleep(2)
end
