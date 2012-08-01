require 'benchmark'
require_relative '../deck.rb'
require_relative '../linked_list.rb'
require_relative '../optimummemoryarray.rb'


Benchmark.bmbm do |b|
  b.report("Array push") do
    array = Array.new
    1000.times do array.push(Card.new("A","S")) end
  end

  b.report("Linked List push") do
    list = LinkedList.new
    1000.times do list.push(Card.new("A","S")) end
  end

  b.report("Optimum Memory Array push") do
    o_array = OptimumMemoryArray.new
    1000.times do o_array.push(Card.new("A","S")) end
  end
end
