# Recuperer des gems requises
require 'bundler'
require 'pry'

Bundler.require

# Etablir les chemins relatifs des classes appelées
require_relative 'player'

# Definition de la classe partie
class Game
	attr_accessor :human_player, :ennemies
	@@ennemies =["John", "Paul", "Georges", "Ringo"]

# Initialisation
	def initialize(pseudo)
		@human_player = HumanPlayer.new(pseudo)
		@ennemies = []
		@@ennemies.each do |ennemi|
			ennemi_n = Player.new(ennemi)
			@ennemies << ennemi_n
		end
	end
	
	def kill_player
		@ennemies = @ennemies.delete_if {|ennemi| ennemi.life_points <= 0}
		return @ennemies
	end

	def is_still_going?
		n = 0
		@ennemies.each do |ennemi|
			if ennemi.life_points > 0
				n += 1
			end
		end
		return n >= 1 && @human_player.life_points > 0 
	end

	def show_players
		@human_player.show_state
		if @ennemies.length > 1
			puts "#{@ennemies.length} ennemis restants."
		else puts "#{@ennemies.length} ennemi restant."
		end
	end

	def menu
		puts "Quelle action veux-tu effectuer ?\n       a - chercher une meilleure arme.\n       s - chercher à se soigner. "
		puts "   attaquer un joueur en vue :"
		n = 0
		@ennemies.each do |ennemi|
			if ennemi.life_points > 0
				puts "      #{n} - #{ennemi.show_state} "
			else  
				puts "      #{ennemi.name} est KO, aucun action possible"
			end
			n += 1 
		end
		print "> "
		return gets.chomp
	end

	def menu_choice(action)
		if action == "a"
			@human_player.search_weapon
		elsif action == "s"
			@human_player.search_health_pack
		elsif action == "0" || action == "1" || action == "2" || action == "3"
			action = action.to_i
			@human_player.attacks(@ennemies[action])
			return 
		end
		puts ""		
	end

	def ennemi_attack
		@ennemies.each do |ennemi|
			ennemi.attacks(@human_player)
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
