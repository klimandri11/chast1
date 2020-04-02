module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def all
      @all ||= []
    end

    def instances
      @all.size
    end
  end

  module InstanceMethods
    protected
    def register_instance
      @quatiti = self.class.instances
    end

  end
end
