# encoding: utf-8
#
# Archivo proporcionado por el Departamento de Lenguajes y Sistemas Informáticos de la UGR 
# Todos los derechos reservados, usa esto bajo tu propia responsabilidad.




module Test

    module Command

        EXIT = :EXIT 
        GOBACK = :GOBACK 
        COMBAT = :COMBAT
        SHOWMONSTER = :SHOWMONSTER 
        SHOWVISIBLETREASURE = :SHOWVISIBLETREASURE
        SHOWHIDDENTREASURE  = :SHOWHIDDENTREASURE 
        DISCARDVISIBLETREASURE = :DISCARDVISIBLETREASURE 
        DISCARDHIDDENTREASURE = :DISCARDHIDDENTREASURE 
        MAKETREASUREVISIBLE = :MAKETREASUREVISIBLE 
        BUYLEVELS = :BUYLEVELS
        BUYWITHVISIBLES = :BUYWITHVISIBLES
        BUYWITHHIDDEN = :BUYWITHHIDDEN
        NEXTTURN = :NEXTTURN
        NEXTTURNALLOWED = :NEXTTURNALLOWED

        def Command.getText(aValue)
       
            case aValue 
            when :EXIT then 
                "Salir del juego"
            when :GOBACK then
                "Menu anterior"
            when :COMBAT then
                "A  C O M B A T I R !"
            when :SHOWMONSTER then
                "Mostrar monstruo"
            when :SHOWVISIBLETREASURE then
                "Mostrar tesoros visibles"
            when :SHOWHIDDENTREASURE then
                "Mostrar tesoros ocultos"
            when :DISCARDVISIBLETREASURE then
                "Descartar tesoro visible"
            when :DISCARDHIDDENTREASURE then
                "Descartar tesoro oculto"
            when :MAKETREASUREVISIBLE then
                "Equipar tesoro"
            when :BUYLEVELS then
                "Comprar niveles"
            when :BUYWITHVISIBLES then
                "Anadir visibles a la lista de la compra"
            when :BUYWITHHIDDEN then
                "Anadir ocultos a la lista de la compra"
            when :NEXTTURN then
                "Siguiente turno"
            when :NEXTTURNALLOWED then
                "Siguiente turno permitido"
            end
            
        end  
      
        def Command.getMenu(aValue)

            case aValue 
                when :EXIT then 
                    0
                when :GOBACK then
                    -1
                when :COMBAT then
                    69
                when :SHOWMONSTER then
                    10
                when :SHOWVISIBLETREASURE then
                    11
                when :SHOWHIDDENTREASURE then
                    12
                when :DISCARDVISIBLETREASURE then
                    21
                when :DISCARDHIDDENTREASURE then
                    22
                when :MAKETREASUREVISIBLE then
                    23
                when :BUYLEVELS then
                    33
                when :BUYWITHVISIBLES then
                    31
                when :BUYWITHHIDDEN then
                    32
                when :NEXTTURN then
                    1
                when :NEXTTURNALLOWED then
                    2
            end    
        end  
    end
end
