# Recuperer des gems requises
require 'pry'

# Definition de la classe joueur générale
class Player
	attr_accessor :name, :life_points #attributs de la classe
	@@ennemis =[]

# Initialisation
	def initialize(pseudo)
		@name = pseudo
		@life_points = 10
		@@ennemis << self
	end
		
# Montre les points de vie
	def show_state
		return "#{self.name} a #{self.life_points} points de vie."
	end

# Résultats du coup reçu
	def gets_damage(number)
		self.life_points = self.life_points - number
		if self.life_points > 0
			return self.life_points
		else
			return "Le joueur #{self.name} a été tué !"
		end
	end

# Résultats du coup porté
	def attacks(player_n)
		if self.life_points >0
			puts "Le joueur #{self.name} attaque le joueur #{player_n.name}"
			damage = compute_damage
			puts "Il lui inflige #{damage} points de dommages"
			player_n.gets_damage(damage)
		end
	end

# Efficacité du coup porté
	def compute_damage
		return rand(1..6)
	end

	def show_ennemies
		return @@ennemis
	end
end

# Definition de la sous-classe des joueurs humains
class HumanPlayer < Player
	attr_accessor :weapon_level #nouvel attribut pour la classe

#Initialisation
	def initialize(pseudo)
		@name = pseudo
		@weapon_level = 1
		@life_points = 100
	end
	
# Montre les points de vie et d'arme
	def show_state
		puts "#{self.name} a #{self.life_points} points de vie et une arme de niveau #{self.weapon_level}."
	end
	
# Efficacité du coup porté
	def compute_damage
		return rand(1..6) * @weapon_level
	end

# Changement d'arme
	def search_weapon
		new_level = rand(1..6)
		puts "Tu as trouver une arme de niveau #{new_level}."
		if new_level > self.weapon_level
			self.weapon_level = new_level
			puts "Une aubaine, elle est meilleure que ton arme actuelle : tu la prends."
		else
			puts "Encore de la camelote..."
		end
	end

# Recuperation de points de vie
	def search_health_pack
		healing = rand(1..6)
		if healing == 1
			puts "Tu n'as rien trouvé... "
		elsif healing >= 2 && healing <= 5
			if self.life_points > 50 # Test si les points ajoutés feront passer au dessus de 100 pts
				self.life_points = 100
			else
				self.life_points += 50
			end
			puts "Bravo, tu as trouvé un pack de +50 points de vie !"
		elsif healing == 6
			if self.life_points > 20 # Test si les points ajoutés feront passer au dessus de 100 pts
				self.life_points = 100
			else
				self.life_points += 80
			end
			puts "Champagne! Tu as trouvé un pack de +80 points de vie !"
		end
		
	end

# Appliquer une action choisie
	def action_do(action)
		if action == "a"
			self.search_weapon
		elsif action == "s"
			self.search_health_pack
		elsif action == "0"
			self.attacks(@@ennemis[action.to_i])
		elsif action == "1"
			self.attacks(@@ennemis[action.to_i])
		end
		puts ""		
	end

end