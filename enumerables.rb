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

    # Below methods will work with only arrays but will not work if the array contains
    # nil value
  def my_all?(argv=nil, &block)
    match_all = true
    block = Proc.new { |item| item unless item.nil? || !item } unless block_given?
    block = Proc.new { |item| item if argv === item} unless argv.nil?
    self.my_each { |item| match_all = false unless block.call(item) }
    match_all
  end

  def my_any?(argv=nil, &block)
    match_any = false
    block = Proc.new { |item| item unless item.nil? || !item } unless block_given?
    block = Proc.new { |item| item if argv === item} unless argv.nil?
    self.my_each do |item|
      if block.call(item)
        match_any = true
        break
      end
    end
    match_any
  end

  def my_none?(argv=nil, &block)
    match_none = true
    block = Proc.new { |item| item unless item.nil? || !item } unless block_given?
    block = Proc.new { |item| item if argv === item} unless argv.nil?
    self.my_each do |item|
      if block.call(item)
        match_none = false
        break
      end
    end
    match_none
  end

  def my_count(argv=nil, &block)
    count = 0
    return self.size if !block_given? && argv.nil?
    block = Proc.new { |item| item if argv == item } unless argv.nil?
    self.my_each { |item| count += 1 if block.call(item) }
    count
  end
end