# encoding: UTF-8
# 
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
#
# Hecho por Braulio Vargas López
# Todos los derechos reservados, usa esto bajo tu propia responsabilidad.

module NapakalakyGame
    class Cultist < Card

        attr_reader :name, :gainedLevels

        def initialize (n, g)
            @name = n
            @gainedLevels = g
        end

        def getBasicValue
            return @minBonus
        end

        def getSpecialValue
            return @maxBonus
        end
    end
end
