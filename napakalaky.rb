# encoding: UTF-8
# 
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
#
# Hecho por Braulio Vargas López
# Todos los derechos reservados, usa esto bajo tu propia responsabilidad.

require 'singleton'
require_relative 'combat_result.rb'
require_relative 'card_dealer.rb'
require_relative 'player.rb'
require_relative 'bad_consequence.rb'
require_relative 'prize.rb'

module NapakalakyGame
    class Napakalaky

        include Singleton

        attr_accessor :currentPlayer, :currentMonster, :players, :dealer, :currentPlayerIndex

        def initialize
            @players = Array.new
            @currentPlayer = nil
            @dealer = CardDealer.instance
            @currentMonster
            @currentPlayerIndex = -1
        end

        def developCombat
            combatResult = @currentPlayer.combat(@currentMonster)
            if combatResult == CombatResult::LOSEANDCONVERT 
                cultist = @dealer.nextCultist
                cultistPlayer = cultist.new(@currentPlayer, cultist)
                @players.insert(@currentPlayerIndex, cultistPlayer)
                @players.delete(@currentPlayer)
                @currentPlayer = cultistPlayer
            end
            @dealer.giveMonsterBack(@currentMonster)
            return combatResult
        end

        def discardVisibleTreasures(treasures)
            treasures.each do |treasure|
                @currentPlayer.discardVisibleTreasure(treasure)
                @dealer.giveTreasureBack(treasure)
            end
        end

        def discardHiddenTreasures(treasures)
            treasures.each do |treasure|
                @currentPlayer.discardHiddenTreasure(tresaure)
                @dealer.giveTreasureBack(treasure)
            end
        end

        def makeTreasuresVisible(treasures)
            treasures.each do |t|
                @currentPlayer.makeTreasureVisible(t)
            end
        end

        def buyLevels(visible, hidden)
            canI = @currentPlayer.buyLevels(visible, hidden)
        end

        def initGame(players)
            initPlayers(players)
            @dealer.initCards
            nextTurn
        end

        def nextTurn
            stateOK = nextTurnIsAllowed

            if stateOK
                @currentMonster = @dealer.nextMonster
                @currentPlayer = nextPlayer
                dead = @currentPlayer.isDead

                if dead
                  @currentPlayer.initTreasures
                end
            end

            return stateOK
          
        end

        def endOfGame(result)
            return result == CombatResult::WINANDWINGAME
        end

        def getCurrentPlayer
            return @currentPlayer
        end

        def getCurrentMonster
            return @currentMonster
        end

        private

        def initPlayers(names)
            names.each do |s|
                @players << Player.new(s)
            end
        end

        def nextPlayer()
            if @currenPlayerIndex == -1
                @currentPlayerIndex = rand(players.size)
            else
                @currentPlayerIndex = (@currentPlayerIndex + 1) % players.size
            end

            nextPlayer = @players.at(@currentPlayerIndex)
            @currentPlayer = nextPlayer
            return @currentPlayer
        end

        def nextTurnIsAllowed
          
            state = false
          
            if @currentPlayer == nil
                state = true
            else
                state = @currentPlayer.validState
            end
          
            return state
        end
    end
end
