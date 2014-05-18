module Saneitized

  class Hash < SimpleDelegator

    def initialize(hash)
      super(hash)
      hash.each do |key, value|
        hash[key] = Saneitized.convert(value)
      end
    end

  end
end
