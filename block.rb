class Book < Array
	attr_reader :rank
	def initialize(rank)
	@rank = rank
	end
end
