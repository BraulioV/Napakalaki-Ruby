# encoding: utf-8

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
#
# Archivo proporcionado por el Departamento de Lenguajes y Sistemas Informáticos de la UGR.
# Todos los derechos reservados, usa esto bajo tu propia responsabilidad.

require_relative 'napakalaky.rb'
require_relative 'command.rb'
require_relative 'combat_result.rb'
require_relative 'bad_consequence.rb'

require "singleton"

module Test

    class GameTester

        include Singleton  
     
        def play(aGame, numberOfPlayers)
        
            @game = aGame
            names = getPlayerNames(numberOfPlayers)
            @game.initGame(names) 
            
            begin #Mientras dure la partida
                begin #Mientras el jugador se decide a conocer al monstruo
                    puts "******* ******* ******* ******* ******* ******* *******"
                    puts "\n\n Turno de: " + @game.getCurrentPlayer().to_s() 
                    command = getCommandBeforeKnowingMonster()
                    command = processCommand(command)        
                end while (command != Command::EXIT && command != Command::SHOWMONSTER)
                if (command == Command::SHOWMONSTER) then
                    begin #Mientras el jugador se decida a combatir 
                          puts "******* ******* ******* ******* ******* ******* *******"
                          puts "\n\n Turno de: " + @game.getCurrentPlayer().to_s()
                          command = getCommandBeforeFighting()
                          command = processCommand(command)
                    end while (command != Command::EXIT && command != Command::COMBAT)
                    if (command == Command::COMBAT) then
                        combatResult = @game.developCombat()
                        case combatResult
                            when NapakalakyGame::CombatResult::WINANDWINGAME then 
                                puts "\n\n       " + @game.getCurrentPlayer().name + "\n\n HAS GANADO LA PARTIDA"
                                #break está implícito            
                            when NapakalakyGame::CombatResult::WIN then
                                puts "\n\n Ganaste el combate"
                            when NapakalakyGame::CombatResult::LOSE then
                                puts "\n\n Has perdido el combate, te toca cumplir con el siguiente mal rollo"
                                puts @game.getCurrentPlayer().pendingBadConsequence.to_s
                            when NapakalakyGame::CombatResult::LOSEANDESCAPE then
                                puts "\n\n Perdiste el combate pero has logrado escapar"
                            when NapakalakyGame::CombatResult::LOSEANDDIE then
                                puts "\n\n Perdiste el combate y ademas estas muerto"
                        end #case
                        if (combatResult != NapakalakyGame::CombatResult::WINANDWINGAME) then
                            begin #Hasta que se avance de turno 
                                puts "******* ******* ******* ******* ******* ******* *******"
                                puts "\n\n Turno de: " + @game.getCurrentPlayer().to_s()
                                command = getCommandAfterFighting()
                                command = processCommand(command)
                            end while (command != Command::EXIT && command != Command::NEXTTURNALLOWED)
                        else 
                            command = Command::EXIT
                        end #if Command::WINANDWINGAME  
                    end #if COMBAT
                end  #if SHOWMOnSTER
            end while (command != Command::EXIT) #mientras dure la partida

        end
      
        private
      
        def getCommandAfterFighting()
            commands = [Command::SHOWMONSTER, Command::SHOWVISIBLETREASURE, Command::SHOWHIDDENTREASURE, 
            Command::DISCARDVISIBLETREASURE, Command::DISCARDHIDDENTREASURE, Command::MAKETREASUREVISIBLE, 
            Command::NEXTTURN, Command::EXIT]
            manageMenu("Opciones antes de pasar turno", commands)
        end
      
        def getCommandBeforeFighting ()
            commands = [Command::SHOWMONSTER, Command::SHOWVISIBLETREASURE, Command::SHOWHIDDENTREASURE, 
            Command::COMBAT, Command::EXIT]
            manageMenu("Opciones antes de combatir", commands)
        end
      
        def getCommandBeforeKnowingMonster () 
            commands = [Command::SHOWMONSTER,Command::SHOWVISIBLETREASURE, Command::SHOWHIDDENTREASURE, 
            Command::MAKETREASUREVISIBLE,  Command::BUYLEVELS, Command::EXIT]      
            manageMenu("Opciones antes de conocer al monstruo", commands)
        end
      
        def getPlayerNames (numberOfPlayers) 
            names = Array.new
            for i in 1..numberOfPlayers
                puts "Escribe el nombre del jugador #{i}: "
                names << gets.chomp
            end
            names;
        end

        def getTreasure (howMany) 
        
            begin #Hasta que la entrada sea válida
                validInput = true
                option = -1
                puts "\n Elige un tesoro: "
                capture = gets.chomp
          
                begin #tratar la excepción
                    option = Integer(capture)
                    rescue Exception => e  
                    validInput = false
                end
          
                if validInput then
                    if (option < -1 || option > howMany) then #no se ha escrito un entero en el rango permitido
                    validInput = false
                    end
                end  
                if (! validInput) then
                    inputErrorMessage() 
                end
            end while (! validInput)
            
            option
        end
      
        def inputErrorMessage () 
            puts "\n\n ERROR !!! \n\n Selección errónea. Inténtalo de nuevo.\n\n"
        end
      
        def manageBuyLevels (aPlayer) 
            commands = [Command::BUYWITHVISIBLES, Command::BUYWITHHIDDEN, Command::BUYLEVELS]
        
            visibleTreasuresToBuyLevels = Array.new (aPlayer.getVisibleTreasures())
            hiddenTreasuresToBuyLevels = Array.new (aPlayer.getHiddenTreasures())
            visibleShoppingCart = Array.new
            hiddenShoppingCart = Array.new

            begin #Hasta que se llene el carrito de la compra y se decida comprar niveles
                command = manageMenu("Opciones para comprar niveles", commands)
                case command 
                    when Command::BUYWITHVISIBLES then
                        manageTreasuresToBuyLevels(visibleShoppingCart, visibleTreasuresToBuyLevels)
                    when Command::BUYWITHHIDDEN then
                        manageTreasuresToBuyLevels(hiddenShoppingCart, hiddenTreasuresToBuyLevels)
                end 
            end while (command != Command::BUYLEVELS)
            aPlayer.buyLevels(visibleShoppingCart, hiddenShoppingCart)
        end
      
        def manageDiscardTreasures (visible, aPlayer)
         
            begin #Se descartan tesoros hasta que se vuelve al menú anterior
                if visible then
                    howMany = showTreasures("Elige tesoros visibles para descartar", aPlayer.getVisibleTreasures(), true)
                else 
                    howMany = showTreasures("Elige tesoros ocultos para descartar", aPlayer.getHiddenTreasures(), true)
                end
                option = getTreasure (howMany)
                if (option > -1) then 
                    if visible then
                        aPlayer.discardVisibleTreasure (aPlayer.getVisibleTreasures()[option])
                    else
                        aPlayer.discardHiddenTreasure (aPlayer.getHiddenTreasures()[option])          
                    end
                end
            end while (option != -1)  
        end
      
        def manageMakeTreasureVisible (aPlayer)
           
            begin #Se hacen tesoros visibles hasta que se vuelve al menÃº anterior
                howMany = showTreasures("Elige tesoros para intentar hacerlos visibles", aPlayer.getHiddenTreasures(), true)
                option = getTreasure (howMany);
                if (option > -1) then
                    aPlayer.makeTreasureVisible (aPlayer.getHiddenTreasures()[option])
                end
            end while (option != -1)
        end
      
        def manageMenu (message, menu) 
            menuCheck = Hash.new #Para comprobar que se hace una selecciÃ³n vÃ¡lida
            menu.each do |c|
                menuCheck [Command.getMenu(c)] = c
            end    
            begin #Hasta que se hace una selecciÃ³n vÃ¡lida
                validInput = true
                option = -1
                puts ("\n\n------- ------ ------ ------ ------ ------ ------")
                puts "**** " + message + " ****\n"
                menu.each do |c| #se muestran las opciones del menÃº
                    puts "#{Command.getMenu(c)}" + " : " + Command.getText(c)
                end
                puts "\n Elige una opción: "
                capture = gets.chomp
                begin
                    option = Integer(capture)
                    rescue Exception => e  #No se ha introducido un entero
                    validInput = false
                end  
          
                if validInput then
                    if (! menuCheck.has_key?(option)) #No es un entero entre los vÃ¡lidos
                        validInput = false
                    end
                end
                if (! validInput) then
                    inputErrorMessage()
                end
            end while (! validInput)
            
            menuCheck[option]    
        end
          
        def manageTreasuresToBuyLevels (shoppingCart, treasuresToBuyLevels) 
           
            begin #Mientras se aÃ±adan tesoros al carrito de la compra
                howMany = showTreasures("Elige tesoros para comprar niveles", treasuresToBuyLevels, true)
                option = getTreasure (howMany)
                if (option > -1) then
                    shoppingCart << treasuresToBuyLevels[option]
                    treasuresToBuyLevels.delete_at(option)
                end
            end while (option != -1)
        end
      
        def processCommand (command) 
            currentPlayer = @game.getCurrentPlayer()
            case command 
                when Command::EXIT then 
                    puts "exit"
                    puts "pulsa enter para seguir"
                    gets
                when Command::COMBAT then
                    puts "combat"
                    puts "pulsa enter para seguir"
                    gets
                when  Command::SHOWMONSTER then 
                    puts "\n------- ------- ------- ------- ------- ------- ------- "
                    puts "El monstruo actual es:\n\n" + @game.getCurrentMonster().to_s()
                    puts "pulsa enter para seguir"
                    gets
                when Command::SHOWVISIBLETREASURE then
                    showTreasures("Esta es tu lista de tesoros visibles", currentPlayer.getVisibleTreasures(), false)
                    puts "pulsa enter para seguir"
                    gets
                when Command::SHOWHIDDENTREASURE then
                    showTreasures("Esta es tu lista de tesoros ocultos", currentPlayer.getHiddenTreasures(), false)
                    puts "pulsa enter para seguir"
                    gets
                when Command::MAKETREASUREVISIBLE then
                    manageMakeTreasureVisible (currentPlayer)
                    puts "pulsa enter para seguir"
                    gets
                when Command::DISCARDVISIBLETREASURE then
                    manageDiscardTreasures(true, currentPlayer)
                    puts "pulsa enter para seguir"
                    gets
                when Command::DISCARDHIDDENTREASURE then
                    manageDiscardTreasures(false, currentPlayer)
                    puts "pulsa enter para seguir"
                    gets
                when Command::BUYLEVELS then
                    manageBuyLevels (currentPlayer)
                    puts "pulsa enter para seguir"
                    gets
                when Command::NEXTTURN then
                    if (!@game.nextTurn()) then
                        puts "\n\n ERROR \n"  
                        puts "No cumples las condiciones para pasar de turno."
                        puts "O bien tienes más de 4 tesoros ocultos"
                        puts "O bien te queda mal rollo por cumplir"          
                        puts "tu mal rollos es:"
                        puts currentPlayer.pendingBadConsequence.to_s
                        puts "pulsa enter para seguir"
                        gets
                    else 
                        command = Command::NEXTTURNALLOWED
                        puts "pulsa enter para seguir"
                        gets
                    end
                else puts "ERROR" 
            end
            command
        end
      
        def showTreasures (message, treasures, menu)
            optionMenu = -1

            puts "\n------- ------- ------- ------- ------- ------- -------"
            puts message 
            if menu then
                puts "\n" + Command.getMenu(Command::GOBACK).to_s() + " : " + Command.getText(Command::GOBACK)
            end
            treasures.each do |t|
                optionMenu = optionMenu + 1
                if (menu)
                    puts "\n" + optionMenu.to_s() + ":" + t.to_s()
                else 
                    puts "\n" + t.to_s()
                end
         
            end
            optionMenu
        end
     
    end #clase
end #modulo
