require 'delegate'

module Saneitized

  class Array < ::SimpleDelegator

    def initialize(array = [], options = {})
      @options = options
      super(array.map{|item| Saneitized.convert(item, options)})
      self
    end

    def []=(index, value)
      super index, Saneitized.convert(value, @options)
    end

    def << (value)
      super Saneitized.convert(value, @options)
    end

    def push(*args)
      raise NotImplementedError
    end

    def unshift(*args)
      raise NotImplementedError
    end

    def insert(*args)
      raise NotImplementedError
    end
  end
end
