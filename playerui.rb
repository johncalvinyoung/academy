class GoFishPlayerUI
     def initialize(player)
	  @player = player
	  player.ui = self
     end

     def ask_for_input
     end

     def ask(who, to, what)
	  print(who.name, " asked ", to.name, " for all their ", what, "s.\n")
     end

     def received(source, number, rank)
	  print(@player.name, " received ", number, " ", rank, "s from ", source.name, "!\n")
     end

     def go_fish(rank)
	  print("GO FISH!\n", @player.name, " drew from the deck.\n")
     end

     def got_books(rank)
	  print(@player.name, " got a book of ", rank, "s!\n")
     end

     def game_end
     end

     def take_turn	  
	  #pick_card_and_victim
	  #if successful
	  #    set for repeat
	  #else
	  #    go fish
	  #    if successful set for repeat
	  #end
	  #check for books
     end
end

class GoFishCLIPlayerUI < GoFishPlayerUI
     
     def ask_for_input
	  puts "Welcome, "+@player.name+"!\n"
	  puts "\nWho do you want to ask for which card?\n"
	  puts "Example: \"ask Matt for 3's\n"
	  #readout of current hand and opponents.
	  hand_dump = ""
	  @player.hand.sort{|a,b| a.value <=> b.value}.each{|c| hand_dump += " "+c.rank}
	  puts hand_dump+"\n"
	  @player.opponents.each{|o| puts o.name}
	  puts "\n"
	  #now, pick victim and card
	  command = gets.chomp.scan(/ask\s*(\w+)\s*for\s*([2-9JKQAjqka]|10)/i)
     	  if is_legal?(command) then
	       opponent = @player.mygame.players.find_index{|p| p.name == command[0][0]}
	       return [@player.mygame.players[opponent], command[0][1]]
	  else
	       return ask_for_input	       
	  end
     end
     
     def is_legal?(command)
	       opponent = @player.mygame.players.find_index{|p| p.name == command[0][0]}
	       if command[0].size != 2 then
		    puts "Your command cannot be understood!\n"
		    return false
	       elsif opponent == nil then
		    puts "That player does not exist\n"
		    return false
	       elsif @player.mygame.players[opponent].class == nil then
		    puts "That player does not exist\n"
		    return false
	       elsif @player.mygame.players[opponent] == self then
		    puts "You cannot ask yourself for cards!\n"
		    return false
	       elsif @player.hand.select{|c| c.rank == command[0][1]}.size == 0
		    puts "You cannot ask for a rank which you do not possess!\n"
		    return false
	       else
		    return true
	       end
     end

     def received(source, number, rank)
	  print("You received ", number, " ", rank, "s from ", source.name, "!\n")
     end
     
     def go_fish(rank)
	  print("GO FISH!\nYou drew a ", rank, " from the deck.\n")	  
     end

     def ask(who, to, what)
     end

     def take_turn
	  players_turn = true
	  players = @player.mygame.players
	  while players_turn == true do
	       #initial UI layout
	       puts "\nWho do you want to ask for which card?\n"
	       puts "Example: \"ask Matt for 3's\n"
	       #readout of current hand and opponents.
	       hand_dump = ""
	       @player.hand.sort{|a,b| a.value <=> b.value}.each{|c| hand_dump += " "+c.rank}
	       puts hand_dump+"\n"
	       @player.opponents.each{|o| puts o.name}
	       puts "\n"
	       #now, pick victim and card
	       command = gets.chomp.scan(/ask\s*(\w+)\s*for\s*([2-9JKQAjqka]|10)/i)
	       opponent = players.find_index{|p| p.name == command[0][0]}
	       #check for legality of command
	       if command[0].size != 2 then
		    puts "Your command cannot be understood!"
		    next
	       elsif players[opponent] == self then
		    puts "You cannot ask yourself for cards!\n"
		    next
	       elsif @player.hand.select{|c| c.rank == command[0][1]}.size == 0
		    puts "You cannot ask for a rank which you do not possess!\n"
		    next
	       end
	       #execute command
		    reply = players[opponent].give(command[0][1])
		    last_player_asked = players[opponent]

			if reply != [] then 
				print(players[opponent].name, " gave you ", reply.size, " ", command[0][1], "s\n")
				reply.each {|c| @player.hand << c}
			else 
				card = @player.mygame.deck.draw
				print(card)
				print("GO FISH:\n")
				print("You received a ", card.rank, "!\n")
				if card != nil then
					@player.hand << card
				else
					puts "The deck is out of cards and the game is over!\n"
				return end
				if card.rank != command[0][1] then
					players_turn = false
				   	break
				end
			end
			#check for books
			if @player.number_of_cards(command[0][1]) == 4 then 
				@player.books << Book.new(command[0][1])
				print("You got a book of ", command[0][1], "'s!\n")
				@player.hand.delete_if{|c| c.rank == command[0][1]}
				if @player.hand.size == 0 then
					print("You are out of cards, and the game is over!\n")
					return
				end
			end
		end
		return last_player_asked
     end

end

class GoFishRobotPlayerUI < GoFishPlayerUI
     def ask_for_input
	  print(@player.name, "'s turn now.\n")
	  top_rank = @player.search_for_top_rank
	  opponents = @player.opponents.shuffle!
	  ask(@player, opponents[0], top_rank)
	  return [opponents[0], top_rank]
     end

     def take_turn
     top_rank = @player.search_for_top_rank
     @player.opponents.shuffle! #this line randomizes first player to ask for a card
     last_player_asked = nil
     @player.opponents.each do |opponent|
	  last_player_asked = opponent
	  cards = opponent.give(top_rank)
	  if cards != [] then
	       cards.each {|c| @player.hand << c}
	  else 
#	       print("GO FISH:\n")
	       card = @player.mygame.deck.draw
	       print(card)
	       if card != nil then
		    #print(name, " received a ", card.rank, "!\n")
		    @player.hand << card
	       else
		    print("The deck is out of cards and the game is over!\n")
	  	    return 
	       end
	       break if card.rank != top_rank
	  end
	  if @player.number_of_cards(top_rank) == 4 then
	       @player.books << Book.new(top_rank)
	       #print(name, " got a book of ", top_rank, "'s!\n")
	       @player.hand.delete_if{|c| c.rank == top_rank}
	       if @player.hand.size != 0 then
		    top_rank = @player.search_for_top_rank 
	       else
		    print(player.name, " is out of cards and the game is over!\n")	
		    return 
	       end
	  end	
     end
     return last_player_asked
     end

end
