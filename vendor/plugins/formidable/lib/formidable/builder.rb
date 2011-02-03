module Formidable
  class Builder < ActionView::Helpers::FormBuilder
    # Appends the text class unless the field class is present. Made to work with blueprint framework
    %w[text_field password_field].each do |method_name|
      define_method(method_name) do |field_name, *args|
        options = args.extract_options!
        if options[:class]
          (options[:class] << " text") unless options[:class] =~ /(title)|(text)/
        else
          options[:class] = 'text'
        end
        args << options
        @template.content_tag(:p, field_label(field_name, *args) + "<br />".html_safe + super(field_name, *args))
      end
    end

    %w[collection_select text_area datetime_select date_select select file_field].each do |method_name|
      define_method(method_name) do |field_name, *args|
        @template.content_tag(:p, field_label(field_name, *args) + "<br />".html_safe + super(field_name, *args))
      end
    end

    def check_box(field_name, *args)
      old_checkbox = super(field_name, *args)
      @template.content_tag :p do
        field_label(field_name, *args) do
          old_checkbox
        end
      end
    end
    
    def radio_button(field_name, *args)
      old_radio_button = super(field_name, *args)
      @template.content_tag :p do
        field_label(args.shift, *args) do
          old_radio_button
        end
      end
    end
    
    def submit(*args)
      @template.content_tag(:p, super)
    end

    def many_check_boxes(name, subobjects, options = {})
      @template.content_tag(:p) do
        field_name = "#{object_name}[#{name}][]"
        values = @template.instance_variable_get("@#{object_name}").send(name)
        subobjects.map do |subobject|
          options.merge!(:id => "#{object_name}_#{subobject}")
          field_label(subobject, options) do
            checked = values.include?(subobject)
            @template.check_box_tag field_name, subobject, checked, options
          end
        end.join("<br />")
        #@template.hidden_field_tag(field_name, "")
      end
    end
    # 
    # def error_messages(*args)
    #   @template.render_error_messages(object, *args)
    # end

    private

    def field_error(field_name)
      if object.errors.invalid? field_name
        @template.content_tag(:span, [object.errors.on(field_name)].flatten.first.sub(/^\^/, ''), :class => 'error_message')
      else
        ''
      end
    end

    def field_label(field_name, *args)
      options = args.extract_options!
      # options.reverse_merge!(:required => field_required?(field_name))
      options[:label_class] = "required" if options[:required]
      object_id = object_name.to_s.gsub(%r{[\[\]]+},"_").gsub(%r{_$},"")
      @template.content_tag(:label, :for => "#{object_id}_#{field_name}", :class => options[:label_class]) do
        if block_given?
          result = yield
        else
          result = ''
        end
        result << (options[:label] || label_text(field_name))
      end
    end

    def label_text(field_name)
      if object.class.superclass == ActiveRecord::Base
        object.class.human_attribute_name field_name.to_s
      else
        field_name.to_s.humanize
      end
    end
    # def field_required?(field_name)
    #   object.class.reflect_on_validations_for(field_name).map(&:macro).include?(:validates_presence_of)
    # end

    def objectify_options(options)
      super.except(:label, :required, :label_class)
    end
  end
end