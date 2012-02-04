module Tarte  
  module BakedInValidationHelpers
    def validates_baked_in (*attr_names)
      configuration = { :on => :save, :message => :invalid }
      configuration.update(attr_names.extract_options!)
      
      has_one_list = read_inheritable_attribute(:has_one_baked_in_attributes) || []
      codes_or_masks = attr_names.partition {|attr_name| has_one_list.include?(attr_name)}
      validates_code_of(codes_or_masks[0], configuration) unless codes_or_masks[0].empty?
      validates_mask_of(codes_or_masks[1], configuration) unless codes_or_masks[1].empty?
    end
    
    def validates_code_of(attr_names, configuration)
      enum = configuration[:is] || configuration[:is_not]
      validates_each(attr_names, configuration) do |record, attr_name, value|
        value_code = record.send("#{attr_name}_code")
        if value_code
          if configuration[:is]
            unless self.send("#{attr_name}_codes_for", enum).include? value_code
              record.errors.add(attr_name, configuration[:message], :value => value)
            end
          elsif configuration[:is_not]
            if self.send("#{attr_name}_codes_for", enum).include? value_code
              record.errors.add(attr_name, configuration[:message], :value => value)
            end
          end
        else
          record.errors.add(attr_name, (configuration[:message])) unless configuration[:allow_nil]
        end
      end
    end
    
    def validates_mask_of(attr_names, configuration)
      has_many_list = read_inheritable_attribute(:has_many_baked_in_attributes)||{}
      attr_names.each do |attribute|
        raise(ArgumentError, "#{attribute} is not a baked in association") unless has_many_list.has_key?(attribute)
      end
      
      validates_each(attr_names, configuration) do |record, attr_name, value|
        verb = has_many_list[attr_name]
        enum = configuration[verb] || configuration["#{verb}_not".to_sym]
        eql = configuration[:matches] || configuration[:does_not_match]
        if value_mask = record.send("#{attr_name}_mask")
          if configuration[:matches]
            unless self.send("#{attr_name}_mask_for", eql) == value_mask
              record.errors.add(attr_name, configuration[:message], :value => value)
            end
          elsif configuration[:does_not_match]
            if self.send("#{attr_name}_mask_for", eql) == value_mask
              record.errors.add(attr_name, configuration[:message], :value => value)
            end
          elsif configuration[verb]
            unless self.send("#{attr_name}_mask_for", enum) & value_mask > 0
              record.errors.add(attr_name, configuration[:message], :value => value)
            end
          elsif configuration["#{verb}_not".to_sym]
            if send("#{attr_name}_mask_for", enum) & value_mask > 0
              self.record.errors.add(attr_name, configuration[:message], :value => value)
            end
          end
        else
          record.errors.add(attr_name, configuration[:message]) unless configuration[:allow_nil]
        end
      end
    end
    
  end
end
