require 'pry'

class Player
	attr_accessor :name, :life_points
	@@all_players =[]

	def initialize(pseudo)
		@name = pseudo
		@life_points = 10
		@@all_players << self
		return @name, @life_points
	end
	
	def self.all
		return @@all_players
	end
	
	def show_state
		puts "#{self.name} a #{self.life_points} points de vie."
	end

	def gets_damage(number)
		self.life_points = self.life_points - number
		if self.life_points > 0
			return self.life_points
		else
			puts "Le joueur #{self.name} a été tué !"
		end
	end

	def attacks(player_n)
		if self.life_points >0
			puts "Le joueur #{self.name} attaque le joueur #{player_n.name}"
			damage = compute_damage
			puts "Il lui inflige #{damage} points de dommages"
			player_n.gets_damage(damage)
		end
	end

	def compute_damage
		return rand(1..6)
	end

end