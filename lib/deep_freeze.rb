# frozen_string_literal: true

require_relative 'deep_freeze/version'

module DeepFreeze
  def deep_freeze(obj, frozen_objects = {})
    return obj if obj.frozen? || frozen_objects.key?(obj)

    frozen_objects[obj] = true

    case obj
    when String, Numeric, Symbol, NilClass, FalseClass, TrueClass
      obj.freeze
    when Hash
      obj.each do |key, value|
        deep_freeze(key, frozen_objects)
        deep_freeze(value, frozen_objects)
      end
      obj.freeze
    when Array
      obj.each { |value| deep_freeze(value, frozen_objects) }
      obj.freeze
    else
      raise "Can't deep_freeze objects of type #{obj.class}"
    end
  end
end
