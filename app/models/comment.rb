class Comment < ActiveRecord::Base
  belongs_to :author, :class_name => 'User'
  belongs_to :commentable, :polymorphic => true
  
  attr_accessible :comment
  validates_presence_of :comment, :author_id, :commentable_id, :commentable_type
  
end
