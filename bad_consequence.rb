# encoding: UTF-8
# 
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
#
# Hecho por Braulio Vargas López
# Todos los derechos reservados, usa esto bajo tu propia responsabilidad.

require_relative 'treasure_kind.rb'
require_relative 'treasure.rb'

module NapakalakyGame
    class BadConsequence
      
        attr_accessor :text, :levels, :nVisibleTreasures, :nHiddenTreasures, :specificHiddenTreasures, :specificVisibleTreasures, :death

        def initialize(t, l = 0, nVisible = 0, nHidden = 0, v = Array.new, h = Array.new, d = false) 
            @text = t
            @levels = l 
            @nVisibleTreasures = nVisible
            @nHiddenTreasures = nHidden
            @specificVisibleTreasures = v
            @specificHiddenTreasures = h
            @death = d
        end

        def InterseccionTesoros(lista, tesoros_tipo)
            interseccion = Array.new
            lista.each do |t|
                interseccion << t.type
            end
            tipos_comunes = interseccion & tesoros_tipo
            return tipos_comunes
        end

        def myBadConsequeceIsDeath
            return @death
        end

        def isEmpty
            empty = false

            if(@levels == 0 and @nVisibleTreasures <= 0 and 
                @nHiddenTreasures <= 0 and (@specificVisibleTreasures == nil or @specificVisibleTreasures.empty?) and
                (@specificHiddenTreasures == nil or @specificHiddenTreasures.empty?) and @death == false)
                    empty = true
            end

            return empty

        end

        def substractVisibleTreasure(t)
            if @nVisibleTreasures != 0
              @nVisibleTreasures = @nVisibleTreasures - 1

            elsif !@specificVisibleTreasures.empty? or @specificVisibleTreasures != nil
                if @specificVisibleTreasures.include?(t.type)
                    @specificVisibleTreasures.delete(t.type)
                end
            end
        end

        def substractHiddenTreasure(t)
            if @nHiddenTreasures != 0
                @nHiddenTreasures = @nHiddenTreasures - 1

            elsif (!@specificHiddenTreasures.empty? or @specificHiddenTreasures != nil)
                if (@specificHiddenTreasures.include?(t.type))
                    @specificHiddenTreasures.delete(t.type)
                end
            end
        end

        def adjustToFitTreasureList(v, h)
            tesoros_visibles = Array.new
            tesoros_ocultos = Array.new
            nv = 0
            nh = 0
            bc = BadConsequence.newBadConsequenceN("",0,0,0)

            if @nHiddenTreasures <= 0 or @nVisibleTreasures <= 0
                if v.size <= @nVisibleTreasures
                    nv = v.size
                else
                    nv = @nVisibleTreasures
                end

                if h.size <= @nHiddenTreasures
                    nh = h.size
                else
                    nh = @nHiddenTreasures
                end

                bc = BadConsequence.newBadConsequenceN(@text,@levels,nv,nh)
              
            elsif @specificHiddenTreasures.empty? or @specificVisibleTreasures.empty?
                tesoros_visibles = InterseccionTesoros(v, @specificVisibleTreasures)
                tesoros_ocultos = InterseccionTesoros(h, @specificHiddenTreasures)
                bc = BadConsequence.newBadConsequenceS(@text,@levels,tesoros_visibles, tesoros_ocultos)
            end

            return bc

        end

        # "Sobrecarga" del constructor. Como en ruby solo existe un consructor
        # tenemos que llamar al método new, haciendo primero una llamada a self
        # el método new debe ser privado

        private_class_method :new

        def self.newBadConsequenceN(t,l,nVisible,nHidden)
            new(t,l,nVisible,nHidden,Array.new,Array.new,false)
        end

        def self.newBadConsequenceS(t,l,v,h)
            new(t,l,0,0,v,h,false)
        end

        def self.newBadConsequenceD(t,death)
            new(t,nil,0,0,Array.new,Array.new,death)
        end

        def to_s
            "text = #{@text} \nlost levels = #{@levels} \nnumber of visible treasures = #{@nVisibleTreasures} \nnumber of hiddenTreasures = #{@nHiddenTreasures}"
        end
   
    end
end
