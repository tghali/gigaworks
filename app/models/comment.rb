class Comment < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :comment, :user_id, :commentable_id, :commentable_type
end
