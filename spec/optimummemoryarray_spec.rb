require 'test/unit'
require_relative '../optimummemoryarray.rb'

describe OptimumMemoryArray do
	before(:each) do
		@a = OptimumMemoryArray.new
	end
	it "should create efficient array" do
		@a.size.should eq(0)
		@a.class.should eq(OptimumMemoryArray)
	end
	it "should implement push correctly" do
		@a.push(10)
		@a[0].should eq(10)
		@a.size.should eq(1)
	end
	it "should return first and last correctly" do
		@a.push(10)
		@a.push(20)
		@a.first.should eq(10)
		@a.last.should eq(20)
	end
	it "should implement pop correctly" do
		@a.push(10)
		t = @a.pop
		t.should eq(10)
		@a.size.should eq(0)
	end
	it "should implement shift" do
		@a.push(20)
		@a.push(30)
		@a.push(40)

		size1 = @a.size
		t = @a.shift
		size2 = @a.size

		@a[0].should eq(30)
		t.should eq(20)
		size1.should eq(size2+1)
	end
	it "should unshift correctly?" do
		@a.push(50)
		@a.push(60)
		@a.push(70)
		@a.push(80)

		@a.unshift(45)

		@a.size.should eq(5)
		@a[0].should eq(45)
		@a.last.should eq(80)
	end
	it "should concat arrays" do
		@a.push(1)
		@a.push(2)
		@a.push(3)
		
		b = OptimumMemoryArray.new
		b.push(4)
		b.push(5)
		b.push(6)

		c = @a.concat(b)

		c[4].should eq(5)
		c.size.should eq(6)
	end
	it "should shift multiple correctly" do
		@a.load([1,2,3,4,5])
		b = @a.shift(2)
		@a.size.should eq(3)
		b.size.should eq(2)
	end
end
