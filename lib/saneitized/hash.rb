module Saneitized

  class Hash < SimpleDelegator

    def initialize(hash = {}, options = {})
      @options = options
      new_hash = {}
      hash.each do |key, value| new_hash[key] = Saneitized.convert(value, options) end
      super(new_hash)
      self
    end

    def []=(key, value)
      super key, Saneitized.convert(value, @options)
    end

    def merge!(*args, &block)
      raise NotImplementedError
    end
  end
end
