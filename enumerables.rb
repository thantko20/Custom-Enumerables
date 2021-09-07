module Enumerable
  # I can't use built-in #each method but I need to use something 
  # that iterates over arrays and hashes
  # so I'm thinking about for loop for this method that can iterate
  # (Probably won't work for hashes though)
  def my_each
    for k, v in self do
      yield k, v
    end
  end
end