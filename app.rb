# Recuperer des gems requises
require 'bundler'
require 'pry'

Bundler.require

# Etablir les chemins relatifs des classes appelées
require_relative 'lib/player'

# Présentation des joueurs
player1 = Player.new("Josiane")
player2 = Player.new("José")
print "À ma droite #{player1.name}"
print "   <= o =>   "
puts "À ma gauche #{player2.name}"
puts "------------"

# Début de la partie
puts "Prêts à en découdre, voici l'état de chaque joueur :"
puts player1.show_state
puts player2.show_state
puts "------------"

puts "Passons à l'attaque : FIGHT!"
puts "------------"

# Rounds
rounds = 0
while player1.life_points > 0 && player2.life_points > 0 do # Test si aucun des joueurs n'est KO
	player1.attacks(player2)
	player2.attacks(player1)
	rounds += 1 #permet de définir le numéro du round, nb total affiché à la fin de la partie.
	puts "Fin du round : #{rounds}"
# Scores du round
	if player1.life_points > 0 # Test si le joueur est en vie
		player1.show_state
	else puts "#{player1.name} est KO."
	end
	if player2.life_points > 0 # Test si le joueur est en vie
		player2.show_state
	else puts "#{player2.name} est KO."
	end
	puts "------------"
end

# Scores finaux et fin de partie 
if player1.life_points > player2.life_points
	puts "Victoire de #{player1.name} en #{rounds} rounds."
elsif player1.life_points < player2.life_points
	puts "Victoire de #{player2.name} en #{rounds} rounds."
else
	puts "Match nul. #{player1.name} et #{player2.name} sont KO." # Normalement, n'arrivera jamais
end 

