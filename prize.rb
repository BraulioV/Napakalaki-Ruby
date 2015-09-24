# encoding: UTF-8
# 
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
#
# Hecho por Braulio Vargas López
# Todos los derechos reservados, usa esto bajo tu propia responsabilidad.

module NapakalakyGame
    class Prize

        attr_reader :treasures, :levels

        def initialize(t, l)
            @treasures = t
            @levels = l
        end

        def to_s
            "Number of treasures: #{@treasures}   Number of Levels: #{@level}"
        end

    end
end
