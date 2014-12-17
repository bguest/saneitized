require 'delegate'

module Saneitized

  class Hash < ::SimpleDelegator

    def initialize(hash = {}, options = {})
      @options = options
      @key_blacklist = Array(options.fetch(:key_blacklist){[]})
      new_hash = {}
      hash.each do |key, value|
        new_hash[key] = convert_key_value(key, value)
      end
      super(new_hash)
      self
    end

    def []=(key, value)
      super key, Saneitized.convert(value, @options)
    end

    def merge!(*args, &block)
      raise NotImplementedError
    end

    private

    def convert_key_value(key, value)
      if @key_blacklist.include? key
        value
      else
        Saneitized.convert(value, @options)
      end
    end

  end
end
