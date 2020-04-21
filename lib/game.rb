# Recuperer des gems requises
require 'bundler'
require 'pry'

Bundler.require

# Etablir les chemins relatifs des classes appelées
require_relative 'player'

# Definition de la classe partie
class Game
	attr_accessor :human_player, :enemies, :enemies_in_sight, :players_left
	@@enemies =["John", "Paul", "Georges", "Ringo", "Trotro", "Peppa", "Aristote", "Ninja(1)", "Ninja(-1)", "jaNin(e)"]

# Initialisation
	def initialize(pseudo)
		@human_player = HumanPlayer.new(pseudo)
		@enemies = []
		@players_left = 10
		@@enemies.each do |enemi|
			enemi_n = Player.new(enemi)
			@enemies << enemi_n
		end
		@enemies_in_sight = []
	end
	
# Met à jour la liste des ennemis
	def kill_player
		@enemies_in_sight = @enemies_in_sight.delete_if {|enemi| enemi.life_points <= 0}
		if (@enemies.length + @enemies_in_sight.length) < @players_left
			@players_left -= 1
		end
		return @ennemies
	end

# Détermine si les combats sont terminés ou continuent
	def is_still_going?
		return @players_left > 0 && @human_player.life_points > 0 
	end

# Recap des points et nombre d'ennemis restants
	def show_players
		@human_player.show_state
		if @enemies_in_sight.length > 1
			puts "#{@enemies_in_sight.length} ennemis restants."
		else puts "Allons voir un peu plus loin."
		end
		puts ""
	end

#
	def new_players_in_sight
		if @enemies_in_sight.length == @players_left
			puts "Tous les joueurs sont en vue."
		else
			new_attackers = rand(1..6)
			if new_attackers == 1
				puts "Pas de nouveaux ennemis à l'horizon"
			elsif new_attackers >= 2 && new_attackers<= 5
				@enemies_in_sight << @enemies[0]
				@enemies = @enemies[1..-1]
				puts "Un nouvel ennemi arrive "
			else
				@enemies_in_sight << @enemies[0]
				@enemies_in_sight << @enemies[1]
				@enemies = @enemies[2..-1]
				puts "Mayday!!! Deux nouveaux ennemis sont à tes trousses."
			end
		end
	end

# Affiche le menu de séléction des actions
	def menu
		puts "Quelle action veux-tu effectuer ?\n       a - chercher une meilleure arme.\n       s - chercher à se soigner. "
		puts "   attaquer un joueur en vue :"
		n = 0
		@enemies_in_sight.each do |enemi|
			if enemi.life_points > 0
				puts "      #{n} - #{enemi.show_state} "
			end
			n += 1 
		end
		print "> "
		return gets.chomp
	end

# Met en action le choix du menu
	def menu_choice(action)
		if action == "a"
			@human_player.search_weapon
		elsif action == "s"
			@human_player.search_health_pack
		elsif action.to_i <= @enemies_in_sight.length && action.to_i >= 0
			action = action.to_i
			@human_player.attacks(@enemies_in_sight[action])
			return 
		end
		puts ""		
	end

# Volée de coup des ennemis
	def enemi_attack
		@enemies_in_sight.each do |enemi|
			enemi.attacks(@human_player)
		end
	end

	def end
		# Scores finaux et fin de partie 
		puts ""
		puts "La partie est finie"
		if @human_player.life_points > 0
			puts "BRAVO ! Tu as gagné."
		else
			puts "PERDU! Tu t'es bien fait détruire." # Normalement, n'arrivera jamais
		end 
		puts ""
	end
end
