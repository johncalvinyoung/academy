require 'test/unit'
require 'optimummemoryarray.rb'

class OptimumMemoryArrayTest < Test::Unit::TestCase
#@a = OptimumMemoryArray.new

	def test_create_array
		a = OptimumMemoryArray.new
		assert_equal(true, a.size == 0)
		assert_equal(OptimumMemoryArray,a.class)
	end
	def test_push
		a = OptimumMemoryArray.new		
		a.push(10)
		assert_equal(10, a[0])
		assert_equal(1, a.size)
	end

	def test_first_last
		a = OptimumMemoryArray.new
		a.push(10)
		a.push(20)
		assert_equal(10,a.first)
		assert_equal(20,a.last)
	end

	def test_pop
		a = OptimumMemoryArray.new
		a.push(10)
		t = a.pop
		assert_equal(10, t)
		assert_equal(0, a.size)
	end

	def test_shift
		a = OptimumMemoryArray.new

		a.push(20)
		a.push(30)
		a.push(40)

		size1 = a.size
		t = a.shift
		size2 = a.size

		assert_equal(30, a[0])
		assert_equal(20, t)
		assert_equal(size1, size2+1)
	end

	def test_unshift
		a = OptimumMemoryArray.new

		a.push(50)
		a.push(60)
		a.push(70)
		a.push(80)

		a.unshift(45)

		assert_equal(5, a.size)
		assert_equal(45, a[0])
		assert_equal(80, a.last)
	end

	def test_concat
		a = OptimumMemoryArray.new

		a.push(1)
		a.push(2)
		a.push(3)

		b = [4, 5, 6]
		c = a.concat(b)

		assert_equal(5, c[4])
		assert_equal(6, c.size)
	end

	def test_shift_multiple
		a = OptimumMemoryArray.new
		a.push(1)
		a.push(2)
		a.push(3)
		a.push(4)
		a.push(5)

		b = a.shift(2)
		assert_equal(3, a.size)
		assert_equal(2, b.size)
	end
end
