# encoding: UTF-8
# 
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
#
# Hecho por Braulio Vargas López
# Todos los derechos reservados, usa esto bajo tu propia responsabilidad.

require 'singleton'

module NapakalakyGame
    class Dice
    
        include Singleton
    
        def nextNumber
            return 1 + rand(6)
        end
    end
end
