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
my_game.show_players
sleep(1)	
puts ""


# Debut de la partie
in_view

# Rounds
rounds = 0
while my_game.is_still_going? do # Test si le joueur et des adversaires sont présents
	rounds += 1 #permet de définir le numéro du round, nb total affiché à la fin de la partie.
	if rounds != 1 #permet de ne pas réafficher les stats au 1er tour (cf ligne 86)
		my_game.show_players	
		sleep(1)
		puts ""
	end
	my_game.new_players_in_sight
	puts ""
	action = my_game.menu #Appel le menu et conserve la valeur selectionnée
	sleep(0.5)
	puts ""
	my_game.menu_choice(action)
	my_game.kill_player # Demande la mise à jour de la liste d'ennemis après le coup porté
	sleep(1)
	puts ""
	if my_game.is_still_going? 
		mayday # Envoi l'animation d'attaque des ennemis
	end
	my_game.enemi_attack
	puts "Fin du round : #{rounds}"
# Scores du round
	if my_game.is_still_going?
		puts "     \n On y retourne?\n - press enter -\n   "
		gets.chomp
	end
end

# Scores finaux et fin de partie 
my_game.end
