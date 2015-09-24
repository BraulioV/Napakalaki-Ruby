# encoding: utf-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
#
# Archivo proporcionado por el Departamento de Lenguajes y Sistemas Informáticos de la UGR
# Todos los derechos reservados, usa esto bajo tu propia responsabilidad.

require_relative 'napakalaky.rb'
require_relative 'player.rb'
require_relative 'game_tester.rb'

module Test

    class EjemploMain

        def prueba
        
            test = GameTester.instance
     
            game = NapakalakyGame::Napakalaky.instance

            #Se prueba el juego con 2 jugadores

            test.play(game, 2)
       
        end
      
    end
  
    e = EjemploMain.new
    e.prueba()

end
