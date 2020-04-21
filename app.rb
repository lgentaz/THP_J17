require 'bundler'
require 'pry'

Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

# présentation des joueurs
player1 = Player.new("Josiane")
player2 = Player.new("José")
print "À ma droite #{player1.name}"
print "   <= o =>   "
puts "À ma gauche #{player2.name}"
puts "------------"

puts "Prêts à en découdre, voici l'état de chaque joueur :"
player1.show_state
player2.show_state
puts "------------"

puts "Passons à l'attaque : FIGHT!"
puts "------------"
# rounds
rounds = 0
while player1.life_points > 0 && player2.life_points > 0 do
	player1.attacks(player2)
	player2.attacks(player1)
	rounds += 1
	puts "Fin du round : #{rounds}"
	if player1.life_points > 0
		player1.show_state
	else puts "#{player1.name} est KO."
	end
	if player2.life_points > 0
		player2.show_state
	else puts "#{player2.name} est KO."
	end
	puts "------------"
end

if player1.life_points > player2.life_points
	puts "Victoire de #{player1.name} en #{rounds} rounds."
elsif player1.life_points < player2.life_points
	puts "Victoire de #{player2.name} en #{rounds} rounds."
else
	puts "Match nul. #{player1.name} et #{player2.name} sont KO."
#binding.pry
end 

