# Recuperer des gems requises
require 'bundler'
require 'pry'

Bundler.require

# Etablir les chemins relatifs des classes appelées
require_relative 'lib/player'
require_relative 'lib/game'


# Animation de début de partie
def top
	puts "-" * 50
	puts "|    Bienvenue sur 'ARCADE FIGHT SUPER FUN' !    |"
	puts "|         Le but du jeu est : DON'T DIE !        |"
	puts "-" * 50
	puts ""
end

# Petite def pour choisir un nom du joueur
def choose_name
	print "Choisis ton pseudo:"
	print ">"
	pseudo = gets.chomp
	puts ""
	puts "Prêt #{pseudo} ?"
	puts ""
	return pseudo
end

# Here we go ... lancement de la partie
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
top

# Les joueurs
my_game = Game.new(choose_name)


# Debut de la partie
in_view

# Rounds
rounds = 0
while my_game.is_still_going? do # Test si le joueur et des adversaires sont présents
	rounds += 1 #permet de définir le numéro du round, nb total affiché à la fin de la partie.
	my_game.show_players	
	sleep(1.5)
	puts ""
	action = my_game.menu
	puts ""
	my_game.menu_choice(action)
	my_game.kill_player
	mayday
	my_game.ennemi_attack
	puts "Fin du round : #{rounds}"
# Scores du round
#	round_score(my_game.human_player)
#	player_h.show_ennemies #met a jour l'array ennemies
	sleep(1.5)
	puts "     \n ----------------\n   "
end

# Scores finaux et fin de partie 
my_game.end







