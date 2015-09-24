# encoding: UTF-8
# 
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
#
# Hecho por Braulio Vargas López
# Todos los derechos reservados, usa esto bajo tu propia responsabilidad.

require_relative 'bad_consequence.rb'
require_relative 'prize.rb'

module NapakalakyGame
    class Monster < Card
        attr_accessor :name, :combatLevel, :badConsequence, :prize, :levelChangeAgainstCultistPlayer

        def initialize(n, l, p, b, lcacp = 0)
            
            @name = n
            @combatLevel = l
            @badConsequence = b
            @prize = p
            @levelChangeAgainstCultistPlayer = lcacp
        end

        def kills
            return @badConsequence.myBadConsequeceIsDeath
        end

        def getLevelsGained
            return @prize.levels
        end

        def getTreasuresGained
            return @prize.treasures
        end

        def getCombatLevel
            return @combatLevel
        end

        def getBasicValue
            return getCombatLevel
        end

        def getSpecialValue
            return @combatLevel + @levelChangeAgainstCultistPlayer
        end
            
        def to_s
            "Name: #{@name}      Combat level: #{@combatLevel}"
        end
    end
end
