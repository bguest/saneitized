require 'json'

module Saneitized
  def self.convert(unknown)
    return Saneitized::Hash.new(unknown) if unknown.is_a? ::Hash
    return Saneitized::Array.new(unknown) if unknown.is_a? ::Array
    return unknown unless unknown.is_a? String #Only attempt to convert string
    return true  if unknown == 'true'
    return false if unknown == 'false'

    if value = Converter.integer?(unknown) then return value end
    if value = Converter.float?(unknown)   then return value end
    if value = Converter.json?(unknown)    then return convert(value) end
    if value = Converter.time?(unknown)    then return value end

    unknown
  end

  module Converter
    extend self

    def json?(unknown)
      JSON.parse(unknown)
    rescue JSON::ParserError, TypeError
      false
    end

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

    def time?(unknown)
      Time.parse(unknown)
    rescue ArgumentError, TypeError
      false
    end
  end

end
