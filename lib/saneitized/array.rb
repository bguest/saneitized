
module Saneitized

  class Array < SimpleDelegator

    def initialize(array = [])
      super(array.map{|item| Saneitized.convert(item)})
      self
    end

    def []=(index, value)
      super index, Saneitized.convert(value)
    end

    def << (value)
      super Saneitized.convert(value)
    end

  end
end
