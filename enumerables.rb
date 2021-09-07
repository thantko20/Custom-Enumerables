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
    self.my_each { |item| arr.push(item) if block.call(item) }
    arr
  end

  def my_all?(&block)
    match_all = true
    block = Proc.new { |item| item unless item.nil? || !item } unless block_given?
    self.my_each { |item| match_all = false unless block.call(item) }
    match_all
  end
end