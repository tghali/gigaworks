module LogActionHelper
  def self.included(base) #:nodoc:
    base.extend(ClassMethods)
  end

  module ClassMethods
    
    # Specifies the observers that can access the controller
    def log_actions_with(*observers)
      configuration = observers.extract_options!

      observers.each do |observer|
        observer_instance = (observer.is_a?(Symbol) ? Object.const_get(observer.to_s.classify) : observer).instance

        if observer_instance.respond_to?(:filter)
          around_filter(observer_instance, :only => configuration[:only])
        else
          after_filter(observer_instance, :only => configuration[:only])
        end
      end
    end
    
  end
end
