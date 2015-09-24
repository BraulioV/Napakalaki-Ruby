# encoding: UTF-8
# 
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
#
# Hecho por Braulio Vargas López
# Todos los derechos reservados, usa esto bajo tu propia responsabilidad.

require 'singleton'
require_relative 'treasure.rb'
require_relative 'treasure_kind.rb'
require_relative 'prize.rb'
require_relative 'monster.rb'
require_relative 'cultist.rb'

module NapakalakyGame
    class CardDealer

        include Singleton

        attr_accessor :unusedMonsters, :usedMonsters, :usedTreasures, :unusedTreasures, :unusedCultists, :usedCultists

        def nextTreasure
            if @unusedTreasures.empty?
                @usedTreasures.each do |t|
                    @unusedTreasures << t
                end
                shuffleTreasures
                @usedTreasures.clear
            end
                treasure = @unusedTreasures.at(0)
                @usedTreasures << treasure
                @unusedTreasures.delete(treasure)

            return treasure
        end

        def nextMonster
            if @unusedMonsters.empty?
                @usedMonsters.each do |t|
                @unusedMonsters << t
            end
                shuffleMonsters
                @usedMonsters.clear
            end
            monster = @unusedMonsters.at(0)
            @unusedMonsters.delete(monster)
            @usedMonsters << monster
            return monster
        end

        def nextCultist
            if @unusedCultists.empty?
                @usedCultists.each do |c|
                @unusedCultists << c
            end
                shuffleCultists
                @usedCultists.clear
            end
            cultist = @unusedCultists.at(0)
            @unusedCultists.delete(cultist)
            @usedCultists << cultist
            return cultist
        end

        def giveTreasureBack(t)
            if !@usedTreasures.include?(t)
                @usedTreasure << t
            end
        end

        def giveMonsterBack(m)
            if !@usedMonsters.include?(m)
                @usedMonsters << m
            end
        end

        def initCards
            initTreasureCardDeck
            initMonsterCardDeck
            initCultistsCardDeck
        end

        private

        def initialize
            @usedMonsters = Array.new
            @unusedMonsters = Array.new
            @usedTreasures = Array.new
            @unusedTreasures = Array.new
            @usedCultists = Array.new
            @unusedCultists = Array.new
        end

        def initTreasureCardDeck
            @unusedTreasures << Treasure.new('¡Si mi amo!',0,4,7,TreasureKind::HELMET)
            @unusedTreasures << Treasure.new('Capucha de Cthulhu',500,3,5,TreasureKind::HELMET)
            @unusedTreasures << Treasure.new('Botas de lluvia acida',800,1,1,TreasureKind::BOTHHAND)
            @unusedTreasures << Treasure.new('Ametralladora Thompson',600,4,8,TreasureKind::BOTHHAND)
            @unusedTreasures << Treasure.new('Clavo de rail ferroviario',400,3,6,TreasureKind::ONEHAND)
            @unusedTreasures << Treasure.new('Fez alopodo',700,3,5,TreasureKind::HELMET)
            @unusedTreasures << Treasure.new('El aparato de Pr. Tesla',900,4,8,TreasureKind::ARMOR)
            @unusedTreasures << Treasure.new('Insecticida',300,2,3,TreasureKind::ONEHAND)
            @unusedTreasures << Treasure.new('Garabato mistico',300,2,2,TreasureKind::ONEHAND)
            @unusedTreasures << Treasure.new('La rebeca metalica',400,2,3,TreasureKind::ARMOR)
            @unusedTreasures << Treasure.new('Necroplayboycon',300,3,5,TreasureKind::ONEHAND)
            @unusedTreasures << Treasure.new('Necrocomicon',100,1,1,TreasureKind::ONEHAND)
            @unusedTreasures << Treasure.new('Linterna a dos manos',400,3,6,TreasureKind::BOTHHAND)
            @unusedTreasures << Treasure.new('Necrotelecom',300,2,3,TreasureKind::HELMET)
            @unusedTreasures << Treasure.new('Tentaculo de pega',200,0,1,TreasureKind::HELMET)
            @unusedTreasures << Treasure.new('Shogulador',600,1,1,TreasureKind::BOTHHAND)
            @unusedTreasures << Treasure.new('Varita de atizamiento',400,3,4,TreasureKind::ONEHAND)
            @unusedTreasures << Treasure.new('Botas de investigación', 600, 3, 4, TreasureKind::SHOE)
            @unusedTreasures << Treasure.new('A prueba de babas', 400, 2, 5, TreasureKind::ARMOR)
            @unusedTreasures << Treasure.new('Casco minero', 400, 2, 4, TreasureKind::HELMET)
            @unusedTreasures << Treasure.new('Camiseta de la UGR', 100, 1, 7, TreasureKind::ARMOR)
            @unusedTreasures << Treasure.new('Cuchillo de sushi arcano', 300, 2, 3, TreasureKind::ONEHAND)
            @unusedTreasures << Treasure.new('Hacha prehistorica', 500, 2, 5, TreasureKind::ONEHAND)
            @unusedTreasures << Treasure.new('Gaita', 500, 4, 5, TreasureKind::BOTHHAND)
            @unusedTreasures << Treasure.new('Escopeta de 3 cañones', 700, 4, 6, TreasureKind::BOTHHAND)
            @unusedTreasures << Treasure.new('La fuerza de Mr.T', 1000, 0, 0, TreasureKind::NECKLACE)
            @unusedTreasures << Treasure.new('Mazo de los antiguos', 200, 3, 4, TreasureKind::ONEHAND)
            @unusedTreasures << Treasure.new('Lanzallamas', 800, 4, 8, TreasureKind::BOTHHAND)
            @unusedTreasures << Treasure.new('Necronomicón', 800, 5, 7, TreasureKind::BOTHHAND)
            @unusedTreasures << Treasure.new('Necro-gnomicón', 200, 2, 4, TreasureKind::ONEHAND)
            @unusedTreasures << Treasure.new('Porra preternatural', 200, 2, 3, TreasureKind::ONEHAND)
            @unusedTreasures << Treasure.new('Zapato deja-amigos', 500, 0, 1, TreasureKind::SHOE)
            shuffleTreasures
        end

        def initMonsterCardDeck
            price = Prize.new(2, 1)
            badConsequence = BadConsequence.newBadConsequenceS('Pierdes tu armadura visible y otra oculta', 0, [TreasureKind::ARMOR], [TreasureKind::ARMOR])
            @unusedMonsters << Monster.new('3 Byakhees de bonanza', 8, price, badConsequence)

            price = Prize.new(1, 1)
            badConsequence = BadConsequence.newBadConsequenceS('Embobados con el lindo primigenio te descartas de tu casco invisible', 0, [TreasureKind::HELMET], [])
            @unusedMonsters << Monster.new('Chibithulhu', 2, price, badConsequence)

            price= Prize.new(1, 1)
            badConsequence = BadConsequence.newBadConsequenceS('El primordial bostezo contagioso. Pierdes el calzado visible', 0, [TreasureKind::SHOE], [])
            @unusedMonsters << Monster.new('El sopor de Dunwich', 2, price, badConsequence)

            price = Prize.new(4, 1)
            badConsequence = BadConsequence.newBadConsequenceS('Te atrapan para llevarte de fiesta y te dean caer en mitad del vuelo. Descarta 1 mano visible y otra oculta.', 0, [TreasureKind::ONEHAND], [TreasureKind::ONEHAND])
            @unusedMonsters << Monster.new('Ángeles de la noche ibicenca', 14, price, badConsequence)

            price = Prize.new(3, 1)
            badConsequence = BadConsequence.newBadConsequenceN('Pierdes todos tus tesoros visibles', 0, 10, 0)
            @unusedMonsters << Monster.new('El gorrón en el umbral', 10, price, badConsequence)

            price = Prize.new(2, 1)
            badConsequence = BadConsequence.newBadConsequenceS('Pierdes la armadura visible', 0, [TreasureKind::ARMOR], [])
            @unusedMonsters << Monster.new('H.P. Munchcraft', 6, price, badConsequence)

            price = Prize.new(1, 1)
            badConsequence = BadConsequence.newBadConsequenceS('Sientes bichos bajo la ropa. Descarta la armadura visible', 0, [TreasureKind::ARMOR], [])
            @unusedMonsters << Monster.new('Bichgooth', 2, price, badConsequence)

            price = Prize.new(4, 2)
            badConsequence = BadConsequence.newBadConsequenceN('Pierdes 5 niveles y 3 tesoros visibles', 5, 3, 0)
            @unusedMonsters << Monster.new('El rey de rosa', 13, price, badConsequence)

            price = Prize.new(1,1)
            badConsequence = BadConsequence.newBadConsequenceN('Toses los pulmones y pierdes 2 niveles',2,0,0)
            @unusedMonsters << Monster.new('La que redacta en las tinieblas',2,price,badConsequence)

            price = Prize.new(2,1)
            badConsequence = BadConsequence.newBadConsequenceD('Estos monstruos resultan bastante superficiales y te aburren mortalmente. Estas muerto', true)
            @unusedMonsters << Monster.new('Los hondos',8,price,badConsequence)

            price = Prize.new(2,1)
            badConsequence = BadConsequence.newBadConsequenceN('Pierdes 2 niveles y 2 tesoros ocultos',2,0,2)
            @unusedMonsters << Monster.new('Semillas Cthulhu',4,price,badConsequence)

            price = Prize.new(2,1)
            badConsequence = BadConsequence.newBadConsequenceS('Te intentas escaquear. Pierdes una mano visible',0,[TreasureKind::ONEHAND],[])
            @unusedMonsters << Monster.new('Dameargo',1,price,badConsequence)

            price = Prize.new(1,1)
            badConsequence = BadConsequence.newBadConsequenceN('Da mucho asquito. Pierdes 3 niveles', 3, 0, 0)
            @unusedMonsters << Monster.new('Pollipolipo volante',3,price,badConsequence)

            price = Prize.new(3,1)
            badConsequence = BadConsequence.newBadConsequenceD('No le hace gracia que pronuncien mal su nombre. Estas muerto',true)
            @unusedMonsters << Monster.new('Yskhtihyssg-Goth',12,price,badConsequence)

            price = Prize.new(4,1)
            badConsequence = BadConsequence.newBadConsequenceD('La familia te atrapa. Estas muerto',true)
            @unusedMonsters << Monster.new('Familia feliz',1,price,badConsequence)

            price = Prize.new(2,1)
            badConsequence = BadConsequence.newBadConsequenceS('La quinta directiva primaria te obliga a perder 2 niveles y un tesoro 2 manos visibles', 2,[TreasureKind::BOTHHAND],[])
            @unusedMonsters << Monster.new('Roboggoth',8,price,badConsequence)

            price = Prize.new(1,1)
            badConsequence = BadConsequence.newBadConsequenceS('Te asusta en la noche. Pierdes un casco visible',0,[TreasureKind::HELMET],[])
            @unusedMonsters << Monster.new('El espia',5,price,badConsequence)

            price = Prize.new(1,1)
            badConsequence = BadConsequence.newBadConsequenceN('Menudo susto te llevas. Pierdes 2 niveles y 5 tesoros visibles', 2, 5, 0)
            @unusedMonsters << Monster.new('El lenguas',20,price,badConsequence)

            price = Prize.new(1,1)
            badConsequence = BadConsequence.newBadConsequenceN('Te faltan manos para tanta cabeza. Pierdes 3 niveles y tus tesoros visibles de las manos',3,10,0)
            @unusedMonsters << Monster.new('Bicefalo',20,price,badConsequence)

            #############################################################################################################################################################################
            ## => Monstruos con sectarios
            #############################################################################################################################################################################

            price = Prize.new(3,1)
            badConsequence = BadConsequence.newBadConsequenceS('Pierdes una mano visible', 0, [TreasureKind::ONEHAND], nil)
            @unusedMonsters << Monster.new('El mal indecible impronunciable', 10, price, badConsequence, -2)

            price = Prize.new(2,1)
            badConsequence = BadConsequence.newBadConsequenceN('Pierdes tus tesoros visibles. Ja ja ja', 0, 10, nil)
            @unusedMonsters << Monster.new('Testigos oculares', 6, price, badConsequence, 2)

            price = Prize.new(2,5)
            badConsequence = BadConsequence.newBadConsequenceD('Hoy no es tu día de suerte. Mueres', true)
            @unusedMonsters << Monster.new('El gran Cthulhu', 20,price, badConsequence, 4)

            price = Prize.new(2,1)
            badConsequence = BadConsequence.newBadConsequenceN('Tu gobierno te recorta dos niveles',2,0,0)
            @unusedMonsters << Monster.new('Serpiente político', 8, price, badConsequence, -2)

            price = Prize.new(1,1)
            badConsequence = BadConsequence.newBadConsequenceS('Pierdes tu casco y tu armadura visible. Pierdes tus manos ocultas', 0, [TreasureKind::HELMET, TreasureKind::ARMOR],
            [TreasureKind::ONEHAND, TreasureKind::BOTHHAND])
            @unusedMonsters << Monster.new('Felpuggoth', 2, price, badConsequence, 5)

            price = Prize.new(4,2)
            badConsequence = BadConsequence.newBadConsequenceN('Pierdes 2 niveles', 2, 0, 0,)
            @unusedMonsters << Monster.new('Shoggoth',16, price, badConsequence, -4)

            price = Prize.new(1,1)
            badConsequence = BadConsequence.newBadConsequenceS('Pintalabios negro. Pierdes 2 niveles',2,0,0)
            @unusedMonsters << Monster.new('Lolitagooth', 2, price, badConsequence, 3)
          
            shuffleMonsters
        end

        def initCultistsCardDeck
            @unusedCultists << Cultist.new('Sectario: +1 por cada sectario en juego. No puedes dejar de ser sectario', 1)
            @unusedCultists << Cultist.new('Sectario: +2 por cada sectario en juego. No puedes dejar de ser sectario', 2)
            @unusedCultists << Cultist.new('Sectario: +1 por cada sectario en juego. No puedes dejar de ser sectario', 1)
            @unusedCultists << Cultist.new('Sectario: +2 por cada sectario en juego. No puedes dejar de ser sectario', 2)
            @unusedCultists << Cultist.new('Sectario: +1 por cada sectario en juego. No puedes dejar de ser sectario', 1)
            @unusedCultists << Cultist.new('Sectario: +1 por cada sectario en juego. No puedes dejar de ser sectario', 1)
        end

        def shuffleTreasures
            @unusedTreasures.shuffle!
        end

        def shuffleMonsters
            @unusedMonsters.shuffle!
        end

        def shuffleCultists
            @unusedCultists.shuffle!
        end

    end
end
