class GlossaryObserver < ActiveRecord::Observer
  observe :sentence, :translation_pair, :comment
  
  # access different controllers and users in different threads
  def controller
    Thread.current[:controller]
  end
  
  def current_user
    Thread.current[:current_user]
  end
  
  def filter(controller)
    Thread.current[:controller], Thread.current[:current_user] = controller, controller.current_user
    yield
    Thread.current[:controller], Thread.current[:current_user] = nil, nil
  end
  
  def after_create(target)
    return unless controller
    
    GlossaryAction.create(:user => current_user, :action => 'created', :target => target) if current_user
  end
  
  def after_update(target)
    return unless controller
    
    case controller.action_name
    when 'update' then action = 'updated'
    when 'flag'
      action = (target.flagged? ? 'flagged' : 'unflagged')
    end
    GlossaryAction.create(:user => current_user, :action => action, :target => target) if current_user
  end
  
  def after_destroy(target)
    return unless controller
    GlossaryAction.create(:user => current_user, :action => 'deleted', :placeholder => "a #{target.class.human_name}") if current_user
  end
  
end
