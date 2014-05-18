module Saneitized
  def self.convert(unknown)
    return Saneitized::Hash.new(unknown) if unknown.is_a? ::Hash
    return unknown unless unknown.is_a? String #Only attempt to convert string
    return true  if unknown == 'true'
    return false if unknown == 'false'

    if value = Converter.integer?(unknown) then return value end
    if value = Converter.float?(unknown) then return value end

    unknown
  end

  module Converter
    extend self
    def integer?(unknown)
      Integer(unknown)
    rescue ArgumentError, TypeError
      false
    end

    def float?(unknown)
      Float(unknown)
    rescue ArgumentError, TypeError
      false
    end
  end

end
