class OptimumMemoryArray < Object
	def initialize
		@data = Array.new(0)
	end

	def shift(*num)
		if num != [] then 
			shifted = []
			num[0].times do
			shifted << shift
			end
			return shifted
		end

		datum = @data[0]
		val=0
		while val < size 
			@data[val] = @data[val+1]
			val += 1
		end
		@data.delete_at(size-1)
		return datum

	end
	
	def unshift val
		c = size-1
		while c > 0
			@data[c+1] = @data[c]
			c =- 1
		end
		@data[0] = val
		return @data
	end

	def pop
		datum = @data[size-1]
		@data.delete_at(size-1)
		return datum
	end

	def push val
		@data[size]=val
		return @data
	end

	def concat other_array
		other_array.each {|x| @data << x}
		return @data
	end

	def size
		@data.size
	end

	def [](x)
		@data[x]
	end

	def first
		@data.first
	end

	def last
		@data.last
	end
end
