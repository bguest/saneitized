require 'json'
require 'chronic'

module Saneitized

  def self.convert(unknown, options = {})
    options[:blacklist] ||= nil
    return Saneitized::Hash.new(unknown) if unknown.is_a? ::Hash
    return Saneitized::Array.new(unknown) if unknown.is_a? ::Array
    return unknown unless unknown.is_a? String #Only attempt to convert string
    return unknown if Array(options[:blacklist]).include?(unknown)

    %w(true false nil integer float json time).each do |type|
      value = Converter.send(type + '?', unknown)
      next if value == :nope
      return (type == 'json') ? convert(value) : value
    end

    unknown
  end


  module Converter
    extend self

    def true?(unknown)
      (unknown == 'true') ? true : :nope
    end

    def false?(unknown)
      (unknown == 'false') ? false : :nope
    end

    def nil?(unknown)
      (%w(nil null NULL).include? unknown) ? nil : :nope
    end

    def json?(unknown)
      JSON.parse(unknown)
    rescue JSON::ParserError, TypeError
      :nope
    end

    def integer?(unknown)
      Integer(unknown)
    rescue ArgumentError, TypeError
      :nope
    end

    def float?(unknown)
      Float(unknown)
    rescue ArgumentError, TypeError
      :nope
    end

    def time?(unknown)
      value = Chronic.parse(unknown)
      value.nil? ? :nope : value
    end
  end

end
