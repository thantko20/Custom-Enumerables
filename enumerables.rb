require 'pry-byebug'

module Enumerable

  def my_each
    for k, v in self do
      yield k, v
    end
  end

  def my_each_with_index
    for i in 0..self.size-1 do
      yield self[i], i
    end
  end

  def my_select(&block)
    arr = []
    hash = {}
    
    case self
    when Array
      self.my_each { |item| arr.push(item) if block.call(item) }
      return arr
    when Hash
      self.my_each { |k, v| hash[k] = v if block.call(k, v) }
      hash
    end
  end

  # Below methods will only work with arrays but will not work if the array contains
  # nil value
  def my_all?(argv=nil, &block)
    block = Proc.new { |item| item unless item.nil? || !item } unless block_given?
    block = Proc.new { |item| item if argv === item} unless argv.nil?
    self.my_each { |item| return false unless block.call(item) }
    
    true
  end

  def my_any?(argv=nil, &block)
    block = Proc.new { |item| item unless item.nil? || !item } unless block_given?
    block = Proc.new { |item| item if argv === item} unless argv.nil?
    self.my_each { |item| return true if block.call(item)}

    false
  end

  def my_none?(argv=nil, &block)
    block = Proc.new { |item| item unless item.nil? || !item } unless block_given?
    block = Proc.new { |item| item if argv === item} unless argv.nil?
    self.my_each { |item| return false if block.call(item)}

    true
  end

  def my_count(argv=nil, &block)
    count = 0
    return self.size if !block_given? && argv.nil?
    block = Proc.new { |item| item if argv == item } unless argv.nil?
    self.my_each { |item| count += 1 if block.call(item) }
    count
  end

  def my_map(a_proc=nil)
    arr = []
    unless a_proc.nil?
      self.my_each { |item| arr.push(a_proc.call(item)) }
      return arr
    end
    self.my_each { |item| arr.push(yield item) }
    arr
  end

  # my_inject method only works when given block
  def my_inject(&block)
    accumulator = self.first
    self.class == Range ? arr = self.to_a : arr = self
    if block_given?
      for i in 0..arr.size-2
        accumulator = block.call(accumulator, arr[i+1])
      end
    end
    accumulator
  end
end