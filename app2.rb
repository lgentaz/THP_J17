# Recuperer des gems requises
require 'bundler'
require 'pry'

Bundler.require

# Etablir les chemins relatifs des classes appelées
require_relative 'lib/player'

# Petite def pour choisir une action
def choose_action(player1, player2)
		puts "Quelle action veux-tu effectuer ?\n       a - chercher une meilleure arme\n       s - chercher à se soigner "
		puts "   attaquer un joueur en vue :"
		if player1.life_points > 0 
			puts "      0 - #{player1.show_state} "
		else puts "      #{player1.name} est KO, aucun action possible"
		end
		if player2.life_points > 0 
			puts "      1 - #{player2.show_state}"
		else puts "      #{player2.name} est KO, aucun action possible"
		end
		print "> "
		return gets.chomp
end

# Petite def pour choisir un nom au joueur humain
def choose_name
	print "Choisis ton pseudo:"
	print ">"
	pseudo = gets.chomp
	player_h = HumanPlayer.new(pseudo)
	puts ""
	puts "Prêt #{player_h.name} ?"
	puts ""
	return player_h
end

# Animation de début de partie
def in_view
		print "Des ennemis sont en vue ."
	3.times do
		sleep(0.2)
		print "."
	end
	print "Passons à l'attaque"
	3.times do
		sleep(0.2)
		print "."
	end
	puts "FIGHT!" 
	sleep(0.5)
	puts ""
end 

# Animation d'attaque des ennemis
def mayday
	print "Les ennemis attaquent "
		3.times do
		sleep(0.2)
		print "."
	end
	print "POW!"
	3.times do
		sleep(0.2)
		print "."
	end
	puts "THUMP..." 
	sleep(0.5)
	puts ""
end

# Rappel d'affichage du score
def round_score(player)
	if player.life_points > 0 # Test si le joueur est en vie
		puts player.show_state
	else puts "Tu es KO."
	end
	player.show_ennemies.each do |ennemi|
		if ennemi.life_points > 0
			puts ennemi.show_state
		else puts "#{ennemi.name} est KO."
		end
	end
end


# Présentation
puts "-" * 50
puts "|    Bienvenue sur 'ARCADE FIGHT SUPER FUN' !    |"
puts "|         Le but du jeu est : DON'T DIE !        |"
puts "-" * 50
puts ""

# Les joueurs
# Creation de l'avatar pour le joueur
player_h = choose_name
# Creation des ennemis
player1 = Player.new("Josiane")
player2 = Player.new("José")

# Debut de la partie
in_view

# Rounds
rounds = 0
while player_h.life_points > 0 && (player1.life_points > 0 || player2.life_points > 0) do # Test si aucun des joueurs n'est KO
	rounds += 1 #permet de définir le numéro du round, nb total affiché à la fin de la partie.
	player_h.show_state	
	sleep(1.5)
	puts ""
	action = choose_action(player1, player2)
	puts ""
	player_h.action_do(action)
	mayday
	player_h.show_ennemies.each do |ennemi|
		if ennemi.life_points > 0
			ennemi.attacks(player_h)
		end
	end
	puts "Fin du round : #{rounds}"
# Scores du round
	round_score(player_h)
	player_h.show_ennemies #met a jour l'array ennemies
	sleep(1.5)
	puts "     \n ----------------\n   "
end

# Scores finaux et fin de partie 
puts "La partie est finie"
puts ""
if player_h.life_points > 0
	puts "BRAVO ! Tu as gagné en #{rounds} rounds."
else
	puts "PERDU! Tu t'es bien fait détruire." # Normalement, n'arrivera jamais
end 
puts ""
