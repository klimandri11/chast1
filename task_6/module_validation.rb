module Validation

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(name, type, dop_parametr = nil)
      validations ||= {}
      validations[name] ||= {}
      validations[name][type] = dop_parametr
      class_variable_set(:@@validations, validations)
    end
  end

  module InstanceMethods
    def validate!
      validations = self.class.class_variable_get(:@@validations)
      validations.each_key do |name|
        var_name = "@#{name}".to_sym
        var_value = instance_variable_get(var_name)
        validations[name].each do |type, dop_parametr|
          send("validate_#{type}", var_value, dop_parametr)
        end
      end
    end

    def validate_presence(name, dop_parametr)
      raise "Пустая строка" if name.nil? || name == ""
    end

    def validate_format(name, dop_parametr)
      raise "Неправильный формат" if name !~ dop_parametr
    end

    def validate_type(name, dop_parametr)
      raise "Неподходящее название класса" if name.class != dop_parametr
    end

    def valid?
      validate!
      true
    rescue
      false
    end
  end
end
