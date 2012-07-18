class GoFishPlayerUI
     def initialize(player)
	  @player = player
	  player.ui = self
     end

     def ask_for_input
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

     def ask(who, to, what)
	  print(who.name, " asked ", to.name, " for all their ", what, "s.\n")
     end
     
     def received(source, number, rank)
	  print("#{@player.name} received #{number} #{rank}s from #{source.name}!\n")
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
	  puts "Your turn now, #{@player.name}\n"
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
     
     def received(source, number, rank)
	  print("You received #{number} #{rank}s from #{source.name}!\n")
     end
     
     def go_fish(rank)
	  print("GO FISH!\nYou drew a ", rank, " from the deck.\n")	  
     end

     def ask(who, to, what)
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
end
