module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send(:include, InstanceMethods)
  end

  module ClassMethods
    attr_reader :validations

    def validate(name, type, params = nil)
      @validations ||= []
      @validations << { name: name, type: type, params: params }
    end
  end

  module InstanceMethods
    NIL_VALUE_ERROR = 'Значение не может быть пустым'
    VALUE_TYPE_ERROR = 'Значение не является объектом заданного класса'
    INVALID_VALUE_FORMAT = 'Значение имеет неправильный формат. Допустимый формат: три буквы или цифры в любом порядке, необязательный дефис и еще 2 буквы или цифры после дефиса'
    VALUE_FORMAT = /^[a-zа-яё\d]{3}\-?[a-zа-яё\d]{2}$/i

    def validate?
      validate!
      true
    rescue StandardError
      false
    end

    protected

    def validate_presence(value, _)
      raise NIL_VALUE_ERROR if value.nil? || value == ''
    end

    def validate_format(value, format)
      raise INVALID_VALUE_FORMAT if value !~ format
    end

    def validate_type(value, type)
      raise VALUE_TYPE_ERROR unless value.is_a?(type)
    end

    def validate!
      self.class.validations.each do |validation|
        value = instance_variable_get("@#{validation[:name]}".to_sym)
        method_name = "validate_#{validation[:type]}".to_sym
        send method_name, value, validation[:params]
      end
    end
  end
end
