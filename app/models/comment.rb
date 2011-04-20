class Comment < ActiveRecord::Base
  belongs_to :author, :class_name => 'User'
  belongs_to :commentable, :polymorphic => true, :touch => true
  has_many   :glossary_actions, :as => :target
  
  attr_accessible :comment
  validates_presence_of :comment, :author_id, :commentable_id, :commentable_type
  
end
