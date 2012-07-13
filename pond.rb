class Pond < Array

#	def <<(y)
#		@cards << y
#	end
	def number_of_cards
		self.size
	end
	
	def go_fish
		self.shift
	end
end
