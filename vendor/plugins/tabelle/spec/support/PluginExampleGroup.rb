require 'action_controller/test_process'

module Spec
  module Plugin    
    
    module RenderObserver

      def verify_rendered # :nodoc:
        render_proxy.rspec_verify
      end

      def unregister_verify_after_each #:nodoc:
        proc = verify_rendered_proc
        Spec::Example::ExampleGroup.remove_after(:each, &proc)
      end

      def should_receive(*args)
        if args[0] == :render
          register_verify_after_each
          render_proxy.should_receive(:render, :expected_from => caller(1)[0])
        else
          super
        end
      end
      
      def should_not_receive(*args)
        if args[0] == :render
          register_verify_after_each
          render_proxy.should_not_receive(:render)
        else
          super
        end
      end
      
      def stub(*args)
        if args[0] == :render
          register_verify_after_each
          render_proxy.stub(args.first, :expected_from => caller(1)[0])
        else
          super
        end
      end
      
      # FIXME - for some reason, neither alias nor alias_method are working
      # as expected in the else branch, so this is a duplicate of stub()
      # above. Could delegate, but then we'd run into craziness handling
      # :expected_from. This will have to do for the moment.
      def stub!(*args)
        if args[0] == :render
          register_verify_after_each
          render_proxy.stub!(args.first, :expected_from => caller(1)[0])
        else
          super
        end
      end
      
      def verify_rendered_proc #:nodoc:
        template = self
        @verify_rendered_proc ||= Proc.new do
          template.verify_rendered
          template.unregister_verify_after_each
        end
      end

      def register_verify_after_each #:nodoc:
        proc = verify_rendered_proc
        Spec::Example::ExampleGroup.after(:each, &proc)
      end

      def render_proxy #:nodoc:
        @render_proxy ||= Spec::Mocks::Mock.new("render_proxy")
      end

    end
    
    
    class PluginExampleGroup < ActionController::TestCase
      extend Spec::Example::ExampleGroupMethods 
      include Spec::Example::ExampleMethods
      
      prepend_before(:each) do
        run_callbacks :setup if respond_to?(:run_callbacks)
      end
      append_after(:each) do
        run_callbacks :teardown if respond_to?(:run_callbacks)
      end
      
      
      attr_reader :request, :response, :controller
      
      class << self

        # Use integrate_views to instruct RSpec to render views in
        # your controller examples in Integration mode.
        #
        #   describe ThingController do
        #     integrate_views
        #     ...
        #
        # See Spec::Rails::Example::ControllerExampleGroup for more
        # information about Integration and Isolation modes.
        def integrate_views(integrate_views = true)
          @integrate_views = integrate_views
        end

        def integrate_views? # :nodoc:
          @integrate_views
        end

        def inherited(klass) # :nodoc:
          klass.integrate_views(integrate_views?)
          klass.subject { controller }
          super
        end

        def set_description(*args) # :nodoc:
          super
          if described_class && described_class.ancestors.include?(ActionController::Base)
            controller_klass = if superclass.controller_class.ancestors.include?(ActionController::Base)
              superclass.controller_class
            else
              described_class
            end
            tests controller_klass
          end
        end

        # When you don't pass a controller to describe, like this:
        #
        #   describe ThingsController do
        #
        # ... then you must provide a controller_name within the context of
        # your controller specs:
        #
        #   describe "ThingController" do
        #     controller_name :thing
        #     ...
        def controller_name(name)
          tests "#{name}_controller".camelize.constantize
        end
      end
      
      
      def setup
        # no-op to override AC::TC's setup w/ conflicts with the before(:each) below
      end
      
      
      def params
        request.parameters
      end

      # Provides access to the flash hash. Use this after rendering a
      # view, calling a helper or calling a controller action.
      #
      # == Examples
      #   post :create
      #   flash[:notice].should == "Success!"
      def flash
        @controller.__send__ :flash
      end

      # Provides acces to the session hash. Use this before or after
      # rendering a view, calling a helper or calling a controller action.
      def session
        request.session
      end
    

      before(:each) do
        # setup_controller_request_and_response
        # Some Rails apps explicitly disable ActionMailer in environment.rb
        if defined?(ActionMailer)
          @deliveries = []
          ActionMailer::Base.deliveries = @deliveries
        end

        unless @controller.class.ancestors.include?(ActionController::Base)
          Spec::Expectations.fail_with <<-MESSAGE
Controller specs need to know what controller is being specified. You can
indicate this by passing the controller to describe():

describe MyController do

or by declaring the controller's name

describe "a MyController" do
  controller_name :my #invokes the MyController
end
MESSAGE
        end
        @controller.extend ControllerInstanceMethods
        @controller.integrate_views! if integrate_views?
        @controller.session = session
      end

      def integrate_views?
        @integrate_views || self.class.integrate_views?
      end

      # Bypasses any error rescues defined with rescue_from. Useful
      # in cases in which you want to specify errors coming out of
      # actions that might be caught by a rescue_from clause that is
      # specified separately.
      #
      # Note that this will override the effect of rescue_action_in_public
      def bypass_rescue
        def controller.rescue_action(exception)
          raise exception
        end
      end

    protected

      def _assigns_hash_proxy
        @_assigns_hash_proxy ||= AssignsHashProxy.new(self) {@response.template}
      end

    private

      module TemplateIsolationExtensions
        def file_exists?(ignore); true; end

        def render_file(*args)
          @first_render ||= args[0] unless args[0] =~ /^layouts/
        end

        # Rails 2.2
        def _pick_template(*args)
          @_first_render ||= args[0] unless args[0] =~ /^layouts/
          PickedTemplate.new
        end

        def __action_exists?(params)
          controller.respond_to? params[:action]
        end

        def __template_exists?(args)
          self.view_paths.respond_to?(:find_template) ?
            self.view_paths.find_template(args[0][:file], template_format) :
            false
        end

        def render(*args)
          return super unless __action_exists?(params) || __template_exists?(args)

          if file = args.last[:file].instance_eval{@template_path}
            record_render :file => file
          elsif args.last[:inline]
            super
          elsif @_rendered
            record_render(args[0])
          else
            super
          end
        end

      private

        def record_render(opts)
          return unless @_rendered
          @_rendered[:template] ||= opts[:file] if opts[:file]
          @_rendered[:partials][opts[:partial]] += 1 if opts[:partial]
        end

        # Returned by _pick_template when running controller examples in isolation mode.
        class PickedTemplate
          # Do nothing when running controller examples in isolation mode.
          def render_template(*ignore_args); end
          # Do nothing when running controller examples in isolation mode.
          def render_partial(*ignore_args);  end
        end
      end

      module ControllerInstanceMethods # :nodoc:
        include Spec::Plugin::RenderObserver

        # === render(options = nil, extra_options={}, &block)
        #
        # This gets added to the controller's singleton meta class,
        # allowing Controller Examples to run in two modes, freely switching
        # from example group to example group.
        def render(options=nil, extra_options={}, &block)
          unless block_given?
            unless integrate_views?
              @template.extend TemplateIsolationExtensions
            end
          end

          if matching_message_expectation_exists(options)
            render_proxy.render(options, &block)
            @performed_render = true
          else
            if matching_stub_exists(options)
              @performed_render = true
            else
              super(options, extra_options, &block)
            end
          end
        end

        # Rails 2.3
        def default_template(action_name = self.action_name)
          if integrate_views?
            super
          else
            begin
              super
            rescue ActionView::MissingTemplate
              "#{self.class.name.sub(/Controller$/,'').underscore}/#{action_name}"
            end
          end
        end

        def response(&block)
          # NOTE - we're setting @update for the assert_select_spec - kinda weird, huh?
          @update = block
          super
        end

        def integrate_views!
          @integrate_views = true
        end

      private

        def integrate_views?
          @integrate_views
        end

        def matching_message_expectation_exists(options)
          render_proxy.__send__(:__mock_proxy).__send__(:find_matching_expectation, :render, options)
        end

        def matching_stub_exists(options)
          render_proxy.__send__(:__mock_proxy).__send__(:find_matching_method_stub, :render, options)
        end

      end

      Spec::Example::ExampleGroupFactory.register(:controller, self)
    end
  end
end