# encoding: UTF-8
# 
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
#
# Hecho por Braulio Vargas López
# Todos los derechos reservados, usa esto bajo tu propia responsabilidad.

require_relative 'bad_consequence.rb'
require_relative 'monster.rb'
require_relative 'treasure.rb'
require_relative 'treasure_kind.rb'
require_relative 'dice.rb'


module NapakalakyGame
    class Player
      
        attr_accessor :name, :level, :pendingBadConsequence, :visibleTreasures, :hiddenTreasures, :dead

        def initialize(name)
            @name = name
            @level = 1
            @dead = true
            @visibleTreasures = Array.new
            @hiddenTreasures = Array.new
            @pendingBadConsequence = BadConsequence.newBadConsequenceN("", 0, -1, -1)
        end

        # => Constructor de copia

        def copia(p)
            @name = p.name
            @level = p.level
            @dead = p.dead
            @visibleTreasures = p.visibleTreasures
            @hiddenTreasures = p.hiddenTreasures
            @pendingBadConsequence = p.pendingBadConsequence
        end

        def getOponentLevel(m)
            return m.getBasicValue
        end

        def shouldConvert
            should = false

            dice = Dice.instance

            if dice.nextNumber == 6
                should = true
            end

            return should
        end
      
        def isDead
            return @dead
        end
      
        def combat(m)
            myLevel = getCombatLevel
            monsterLevel = getOponentLevel(m)
            return m.getBasicValue            
            if myLevel > monsterLevel
                applyPrize(m)
                if @level >= 10 
                    combatResult = CombatResult::WINANDWINGAME
                else
                    combatResult = CombatResult::WIN
                end
            else
                dice = Dice.instance
                escape = dice.nextNumber
                if escape < 5
                    amIDead = false
                    amIDead = m.kills
            
                    if amIDead
                        die
                        combatResult = CombatResult::LOSEANDDIE
                    else
                        bad = m.badConsequence
                        applyBadConsequence(bad)
                        combatResult = CombatResult::LOSE
                        if shouldConvert 
                            combatResult = CombatResult::LOSEANDCONVERT
                        end
                    end
                else
                    combatResult = CombatResult::LOSEANDESCAPE
                end
            end

            discardNecklaceIfVisible

            return combatResult

        end
      
        def makeTreasureVisible(t)
            canI = canMakeTreasureVisible(t)
        
            if canI
                @visibleTreasures << t
                @hiddenTreasures.delete(t)
            end
        
        end
      
        def discardVisibleTreasure(t)
            @visibleTreasures.delete(t)
            if (@pendingBadConsequence != nil && !@pendingBadConsequence.isEmpty)
                @pendingBadConsequence.substractVisibleTreasure(t)
            end
            dieIfNoTreasures
        end
      
        def discardHiddenTreasure(t)
            @hiddenTreasures.delete(t)
            if(@pendingBadConsequence != nil && !@pendingBadConsequence.isEmpty)
                @pendingBadConsequence.substractHiddenTreasure(t)
            end
            dieIfNoTreasures
        end
      
        def buyLevels(visible, hidden)
            levelsMayBought = computeGoldCoinsValue(visible)
            puts "computeGoldCoinsValue(visible) = #{levelsMayBought}"
            levelsMayBought = levelsMayBought + computeGoldCoinsValue(hidden)
            puts "computeGoldCoinsValue(hidden) += #{levelsMayBought}"
            levels = levelsMayBought/1000
            puts "level = #{levels}"
            
            canI = canIBuyLevels(levels)
            
            if canI
                incrementLevels(levels)
            end
            
            @visibleTreasures = @visibleTreasures - visible
            @hiddenTreasures = @hiddenTreasures - hidden
            
            dealer = CardDealer.instance
            
            visible.each do |t|
                dealer.giveTreasureBack(t)
            end
            
            hidden.each do |t|
                dealer.giveTreasureBack(t)
            end
        end
      
        def validState
            validState = false
        
            if @pendingBadConsequence.isEmpty && @hiddenTreasures.size <= 4
                validState = true
            end
        
            return validState      
        
        end
      
        def initTreasures
            dealer = CardDealer.instance
            dice = Dice.instance

            bringToLife

            treasure = dealer.nextTreasure

            @hiddenTreasures << treasure

            number = dice.nextNumber

            if number > 1 
                treasure = dealer.nextTreasure
                @hiddenTreasures << treasure
            end

            if number == 6
                treasure = dealer.nextTreasure
                @hiddenTreasures << treasure
            end
        end
      
        def hasVisibleTreasures
            hasVisible = false
        
            if @visibleTreasures.size > 0
                hasVisible = true
            end
        
            return hasVisible
        
        end
      
        def getVisibleTreasures
            return @visibleTreasures
        end
      
        def getHiddenTreasures
            return @hiddenTreasures
        end
      
        def to_s
            "Name: #{@name}\tLevel: #{@level}"
        end
      
    private
        
        def bringToLife
            @death = false
        end
        
        def getCombatLevel
            combatLevel = @level
            dice = Dice.instance
            tieneCollar = false
          
            @visibleTreasures.each do |t|
                if t.type == TreasureKind::NECKLACE
                    tieneCollar == true
                end
            end
          
            if tieneCollar
                for t in @visibleTreasures
                    combatLevel = combatLevel + t.maxBonus
                end
            
            else
                for t in @visibleTreasures
                    combatLevel = combatLevel + t.minBonus
                end          
            end
         
            return combatLevel
          
        end
        
        def incrementLevels(l)
            @level = @level + l
          
            if (@level > 10)
                @level = 10
            end
        end
        
        def decrementLevels(l)
            @level = @level - l
          
            if(@level < 1)
                @level = 1
            end
        end
        
        def setPendingBadConsequence(b)
            @pendingBadConsequence = b
        end
        
        def dieIfNoTreasures
            if @visibleTreasures.empty? && @hiddenTreasures.empty?
                @dead = true
            end
        end
        
        def discardNecklaceIfVisible()
            @visibleTreasures.each do |t|
                if(t.type == TreasureKind::NECKLACE)
                    cd = CardDealer.instance
                    cd.giveTreasureBack(t)
                    @visibleTreasures.delete(t)
                end
            end
        end
        
        def die
            @level = 1
            d = CardDealer.instance
              
            @visibleTreasures.each do |t|
                d.giveTreasureBack(t)
            end
              
            @hiddenTreasures.each do |t|
                d.giveTreasureBack(t)
            end
              
            @visibleTreasures.clear
            @hiddenTreasures.clear
              
            dieIfNoTreasures
          
        end
        
        def computeGoldCoinsValue(t)
          
            monedas = 0
          
            t.each do |tr|
                monedas = monedas + tr.goldCoins
            end
          
            return monedas
          
        end
        
        def canIBuyLevels(l)
          
            canI = false
          
            if (@level + l < 10)
                canI = true
            end
          
            return canI
          
        end
        
        def applyPrize(currentMonster)
            nLevels = currentMonster.getLevelsGained
            incrementLevels(nLevels)
            nTreasures = currentMonster.getTreasuresGained
          
            if nTreasures > 0
                dealer = CardDealer.instance
                i = 0
                while i < nTreasures
                    treasure = dealer.nextTreasure
                    @hiddenTreasures << treasure
                    i += 1
                end
            end
          
        end
        
        def applyBadConsequence(bad)
             nLevels = bad.levels
            decrementLevels(nLevels)
            pendingBad = bad.adjustToFitTreasureList(@visibleTreasures, @hiddenTreasures)
            @pendingBadConsequence = pendingBad

            @pendingBadConsequence.levels = 0
            
            if pendingBad.nVisibleTreasures >= @visibleTreasures.size
                @visibleTreasures.clear
                @pendingBadConsequence.nVisibleTreasures = 0
            end

            if pendingBad.nHiddenTreasures >= @hiddenTreasures.size
                @hiddenTreasures.clear
                @pendingBadConsequence.nHiddenTreasures = 0                
            end

            if (!@pendingBadConsequence.specificHiddenTreasures.empty?)
                for tk in @pendingBadConsequence.specificHiddenTreasures
                    for t in @hiddenTreasures
                        if (t.type == tk)
                            @hiddenTreasures.delete(t)
                            @pendingBadConsequence.specificHiddenTreasures.delete(tk)
                        end
                    end
                end
            end

            if(!@pendingBadConsequence.specificVisibleTreasures.empty?)
                for tk in @pendingBadConsequence.specificVisibleTreasures
                    for t in @visibleTreasures
                        if (t.type == tk)
                            @visibleTreasures.delete(t)
                            @pendingBadConsequence.specificVisibleTreasures.delete(tk)
                        end
                    end
                end
            end

        end
        
        def canMakeTreasureVisible(t)
            canI = false
          
            arm = 0
            sh = 0
            helm = 0
            oneH = 0
            bothH = 0
            neck = 0
          
            @visibleTreasures.each do |tr|  
                if(tr.type == TreasureKind::ARMOR)
                    arm = arm+1
                elsif(tr.type == TreasureKind::HELMET)
                    helm = helm+1
                elsif(tr.type == TreasureKind::ONEHAND)
                    oneH = oneH+1
                elsif(tr.type == TreasureKind::BOTHHAND)
                    bothH = bothH+1
                elsif(tr.type == TreasureKind::SHOE)
                    sh = sh+1
                elsif(tr.type == TreasureKind::NECKLACE)
                    neck = neck+1
                end
            end

            if(t.type == TreasureKind::ARMOR && arm == 0)
                canI = true
            elsif(t.type == TreasureKind::SHOE && sh == 0) 
                canI = true
            elsif(t.type == TreasureKind::HELMET && helm == 0)
                canI = true
            elsif(t.type == TreasureKind::BOTHHAND && bothH == 0 && oneH == 0)
                canI = true
            elsif(t.type == TreasureKind::ONEHAND && oneH < 2 && bothH == 0)
                canI = true
            elsif(t.type == TreasureKind::NECKLACE && neck == 0)
                canI = true
            end

            return canI
          
        end
        
        def howManyVisibleTreasures(tKind)
            nTreasures = 0

            for t in @visibleTreasures
                if t.type == tKind
                    nTresaures = nTreasures + 1
                end
            end

            return nTreasures
        end
      
    end
end
