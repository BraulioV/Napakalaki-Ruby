# encoding: UTF-8
# 
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
#
# Hecho por Braulio Vargas López
# Todos los derechos reservados, usa esto bajo tu propia responsabilidad.

module NapakalakyGame
    class Card
        
        public
        
        def getBasicValue
            raise NotImplementedError.new
        end

        def getSpecialValue
            raise NotImplementedError.new
        end
    end
end
