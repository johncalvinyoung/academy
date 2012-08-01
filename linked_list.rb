class LinkedNode
  attr_accessor :thing, :next
  def initialize(thing,next_node)
    @thing = thing
    @next = next_node
  end
end

class LinkedList
  attr_accessor :first_object, :last_object
  def initialize
    @first_object = nil
    @last_object = nil
  end

  def size
    cursor = @first_object
    i = 0
    while cursor != @last do
      i += 1
      cursor = cursor.next
    end
    return i
  end

  def first
    return @first_object.thing
  end

  def last
    return @last_object.thing
  end

  def push(item)
    node = LinkedNode.new(item,nil)
    if @first_object != nil then
      @last_object.next = node
      @last_object = node
    else
      @first_object = node
      @last_object = node
    end
    return self
  end

  def pop
    cursor = @first_object
    if @first_object != @last_object then
      while cursor.next != @last_object do
	cursor = cursor.next
      end
      cursor.next = nil
      popped_item = @last_object.clone
      @last_object = cursor
    else
      popped_item = @last_object.clone
      @last_object = nil
      @first_object = nil
    end
    return popped_item.thing
  end

  def shift(*num)
    if num == [] then
      object = @first_object.clone
      @first_object = @first_object.next
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
    node = LinkedNode.new(item,@first_object)
    @first_object = node
    return self
  end

  def concat other_list
    while other_list.size > 0 do
      node = other_list.pop
      self.push(node)
    end
    return self
  end

  def [] index
    cursor = @first_object
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
