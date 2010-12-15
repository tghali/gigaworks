#TODO still valid in rails 3?
#require 'action_dispatch/test_process'
require 'factory_girl'

class Factory
    
  def attachment(name, path, content_type = "image/jpg")
    uploaded_file = ActionDispatch::TestProcess.fixture_file_upload("#{Rails.root}/#{path}", MIME::Types.type_for(path))

    add_attribute name, uploaded_file
  end
  
  # def nested_attributes_for (association, options = {}, &block)
  #  
  #   factory_name = options.delete(:factory) || name
  #   if factory_name_for(factory_name) == self.factory_name
  #     raise AssociationDefinitionError, "Self-referencing association '#{name}' in factory '#{self.factory_name}'"
  #   end
  #   
  #   @attributes << Attribute::Association.new(name, factory_name, options)
  # end
  # 
  # class Attribute #:nodoc:
  # 
  #   class Delegate < Attribute  #:nodoc:
  #     def initialize(association, factory, delegates, block)
  #       super(name)
  #       @block = block
  #       @factory   = factory
  #       @delegates = delegates
  #     end
  # 
  #     def add_to(proxy)
  #       values = @block.arity.zero? ? @block.call : @block.call(proxy) # should it work just by means of this block being evaluated against the proxy
  #       if Factory::Sequence === values
  #         raise SequenceAbuseError
  #       end
  #       # remove the attribute values from the proxy
  #       proxy.associate(name, @factory, @overrides)
  #     end      
  #   end
  # 
  # end
  
end