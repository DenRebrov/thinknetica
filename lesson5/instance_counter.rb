module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send InstanceMethods
  end

  module ClassMethods
    def instances
      @counter
    end
  end

  module InstanceMethods
    protected

    def register_instance
      @counter += 1
    end
  end
end
