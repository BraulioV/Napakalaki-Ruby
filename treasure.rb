# encoding: UTF-8
# 
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
#
# Hecho por Braulio Vargas López
# Todos los derechos reservados, usa esto bajo tu propia responsabilidad.

require_relative 'treasure_kind.rb'
require_relative 'card.rb'

module NapakalakyGame
    
    class Treasure < Card

        attr_reader :name, :goldCoins, :minBonus, :maxBonus, :type

        def initialize (n, g, min, max, t)
            @name = n
            @goldCoins = g
            @minBonus = min
            @maxBonus = max
            @type = t
        end

        def getBasicValue
            return @minBonus
        end

        def getSpecialValue
            return @maxBonus
        end

        def to_s
          "Name = #{@name} \nGold coins = #{@goldCoins} \nMin Bonus = #{@minBonus} \nMax Bonus = #{@maxBonus} \nType = #{@type.to_s}"
        end

    end
end
