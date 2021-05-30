module Enumerable
  def my_each
    for i in self
      yield i
    end
    return self
  end
  def my_each_with_index
    idx = 0
    for i in self
      yield i, idx
      idx += 1
    end
    return self
  end
  def my_select
    elements = []
    my_each do |element|
      elements.append(element) if yield element
    end
    elements
  end
  def my_all?
    my_each do |element|
      return false unless yield element
    end
    return true
  end
  def my_any?
    my_each do |element|
      return true if yield element
    end
    return false
  end
  def my_none?
    my_each do |element|
      return false if yield element
    end
    return true
  end
  def my_count
    count = 0
    my_each do |element|
      count += 1 if yield element
    end
    count
  end
  def my_map
    map = []
    my_each do |element|
      map.push(yield element)
    end
    return map
  end
  def my_inject(*accumulator)
    arr = to_a
    if accumulator.empty?
      accumulator = arr[0]
      arr = arr[1..]
    end
    arr.my_each do |element|
      accumulator = yield accumulator, element
    end
    accumulator
  end
  def my_map_proc_or_block(&proc)
    map = []
    my_each do |element|
      map.push(proc.call(element))
    end
    map
  end
end
numbers = [1, 2, 3, 4, 5]
numbers.each  { |item| puts item }
numbers.my_each  { |item| puts item }
puts
numbers.each_with_index { |item, idx| puts item, idx }
numbers.my_each_with_index { |item, idx| puts item, idx }
puts
numbers.select { |item| item.even? }
numbers.my_select { |item| item.even? }
puts
numbers.all? { |item| item > 0 }
numbers.my_all? { |item| item > 0 }
puts
numbers.any? { |item| item == 7 }
numbers.my_any? { |item| item == 7 }
puts
numbers.none? { |item| item ** 2 == 4 }
numbers.my_none? { |item| item ** 2 == 4 }
puts
numbers.count { |item| item.odd? }
numbers.my_count { |item| item.odd? }
puts
numbers.map { |item| item + 5 }
numbers.my_map { |item| item + 5 }
puts
numbers.inject { |sum, item| sum + item }
numbers.my_inject { |sum, item| sum + item }

square = Proc.new {|x| x**2 }
numbers.map(&square)
numbers.my_map_proc_or_block(&square)
numbers.my_map_proc_or_block { |x| x ** 2 }
