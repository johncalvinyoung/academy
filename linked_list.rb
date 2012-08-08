class LinkedNode
  attr_accessor :thing, :next, :last
  def initialize(thing, next_node, last_node)
    @last = last_node
    @thing = thing
    @next = next_node
  end
end

class LinkedList
  attr_accessor :first_object, :last_object
  def initialize
    @first_node = nil
    @last_node = nil
  end

  def size
    cursor = @first_node
    i = 0
    while cursor != nil do
      i += 1
      cursor = cursor.next
    end
    return i
  end

  def first
    return @first_node.thing
  end

  def last
    return @last_node.thing
  end

  def push(item)
    node = LinkedNode.new(item, nil, @last_node)
    if @first_node != nil then
      @last_node.next = node
      @last_node = node
    else
      @first_node = node
      @last_node = node
    end
    return self
  end

  def pop
    cursor = @first_node
    if @first_node != @last_node then
      while cursor.next != @last_node do
	cursor = cursor.next
      end
      cursor.next = nil
      cursor.last = nil
      popped_item = @last_node.clone
      @last_node = cursor
    else
      popped_item = @last_node.clone
      @last_node = nil
      @first_node = nil
    end
    return popped_item.thing
  end

  def shift(*num)
    if num == [] then
      object = @first_node.clone
      @first_node = @first_node.next
      @first_node.last = nil
      return object.thing
    else
      list = LinkedList.new
      num[0].times do
	list.push(self.shift)
      end
      return list
    end
  end

  def unshift(item)
    node = LinkedNode.new(item,@first_node, nil)
    @first_node.last = node
    @first_node = node
    return self
  end

  def concat other_list
    consumable_list = other_list.clone
    while consumable_list.size > 0 do
      node = consumable_list.pop
      self.push(node)
    end
    return self
  end

  def [] index
    cursor = @first_node
    i = 0
    if index < 0 then index = self.size+index end
    if index < 0 || index > self.size-1 then raise IndexError end
    while i != index && i <= self.size do
      i += 1
      cursor = cursor.next
    end
    return cursor.thing
  end
end
