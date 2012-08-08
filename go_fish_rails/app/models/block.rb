class Book < Array
	attr_reader :rank
	def initialize(rank)
	  @rank = rank
	end

	def as_json
	  return @rank
	end
	def to_json
	  return self.as_json.to_json
	end
end

