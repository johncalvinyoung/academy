class PlayerUI
	attr_accessor :mode, :player
	def initialize(player)
		@player = player
	end

	def ask_for_input
		puts player.name+":"
		puts "\nWho do you want to ask for which card?\n"
		puts "Example: \"ask Matt for 3's\n"
		display_hand
		display_opponents
		command = gets.chomp.scan(/ask\s*(\w+)\s*for\s*([2-9JKQAjqka]|10)/i)
		if command[0].class != Array then error(3); return ask_for_input end
		opponent = player.mygame.players.find_index{|p| p.name == command[0][0]}
		if player.mygame.players[opponent] == self then
			error(1)
			return ask_for_input
		elsif player.hand.select{|c| c.rank == command[0][1]}.size == 0
			error(2)
			return ask_for_input
		end
		rank = command[0][1]
		return [opponent, rank]
	end

	def display_hand
		hand_dump = ""
		player.hand.sort{|a,b| a.value <=> b.value}.each{|c| hand_dump += " "+c.rank}
		print(hand_dump, "\n")
	end

	def display_opponents
		print("Opponents: ")
		opponents.each {|o| print(o.name, " ")}
		print "\n"
	end

	def ask(asker, giver, rank)
		if asker == self then asker_name = "You" else asker_name = asker.name end
		if giver == self then giver_name = "you" else giver_name = giver.name end
		print(asker_name, " asked ", giver_name, " for ", rank, "s\n")
	end

	def gave(giver, recipient, number_of_cards, rank)
		if giver == self then giver_name = "You" else giver_name = giver.name end
		if recipient == self then recipient_name = "you" else recipient_name = recipient.name end
		print(giver_name, " gave ", recipient_name, " ", number_of_cards, " ", command[1], "s\n")
	end

	def go_fish(recipient, rank)
		if recipient == self then recipient_name = "You" else recipient_name = recipient.name end
		print("GO FISH!: ", recipient_name, " received a ", rank, "!\n")
	end

	def error(code)
		if code == 1 then
			puts "You cannot ask yourself for cards!\n"
		elsif code == 2 then
			puts "You cannot ask for a rank you do not possess!\n"
		elsif code == 3 then
			puts "Your command could not be understood. Please try again."
		end
	end

	def game_end(agent)
		if agent.class == Deck then
			puts "The deck is out of cards and the game is over!\n"
		elsif agent == player then
			puts "You ran out of cards and the game is over!\n"
		else
			print(agent.name, " ran out of cards and the game is over!\n")
		end
	end

	def opponents
		@player.mygame.players.select{|p| p!=player}
	end

	def game
		player.mygame
	end

	def notify_book(rank)
		print("You got a book of ", command[1], "'s!\n")
		
	end
end

class RobotPlayerUI < PlayerUI



end
