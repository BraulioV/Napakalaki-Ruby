# encoding: UTF-8
# 
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
#
# Hecho por Braulio Vargas López
# Todos los derechos reservados, usa esto bajo tu propia responsabilidad.

module NapakalakyGame
    class CultistPlayer < Player

        attr_accessor :myCultistCard, :totalCultistPlayer

        @@totalCultistPlayer = 0

        # => p es el player y c el card
        def initialize(p, c)
            super(p.name)
            copia(p)
            @myCultistCard = c
            @@totalCultistPlayer += 1
        end

        def getCombatLevel
            level = super
            level += @myCultistCard.getSpecialValue
            return level
        end

        def getOponentLevel(m)
            return m.getSpecialValue
        end

        def shouldConvert
            return false
        end

        def computeGoldCoinsValue(t)
          
            monedas = 0
          
            t.each do |tr|
                monedas = monedas + tr.goldCoins
            end

            monedas *= 2
          
            return monedas
          
        end
    end
end