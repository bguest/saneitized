module Saneitized

  class Hash < SimpleDelegator

    def initialize(hash)
      super(hash)
      hash.each do |key, value|
        next unless value.is_a? String        # Only attempt to convert strings
        next if convert_to_true(key, value)   # True
        next if convert_to_false(key, value)  # False
        next if convert_to_integer(key,value) # Integer
        next if convert_to_float(key, value)  # Float
      end
    end

    private

    def convert_to_true(key, value)
      (value == 'true' ? self[key] = true : false)
    end

    def convert_to_false(key, value)
      (value == 'false' ? (self[key] = false; true) : false)
    end

    def convert_to_integer(key, value)
      self[key] = Integer(value)
      true
    rescue ArgumentError, TypeError
      false
    end

    def convert_to_float(key, value)
      self[key] = Float(value)
      true
    rescue ArgumentError, TypeError
      false
    end

  end

end
