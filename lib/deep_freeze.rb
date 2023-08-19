# frozen_string_literal: true

require_relative 'deep_freeze/version'
# DeepFreeze module
module DeepFreeze
  def deep_freeze(obj)
    case obj

    when String, Numeric, Symbol, NilClass, FalseClass, TrueClass
      obj.freeze
    when Hash
      obj.each do |key, value|
        deep_freeze(key)
        deep_freeze(value)
      end
      obj.freeze
    when Array
      obj.each { |value| deep_freeze(value) }
      obj.freeze
    else
      raise "Can't deep_freeze objects of type #{obj.class}"
    end
  end
end
