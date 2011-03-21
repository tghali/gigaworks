class Tag < ActiveRecord::Base
  belongs_to :taggable, :polymorphic => true

  attr_accessible :tag
  validates_presence_of :tag, :taggable_id, :taggable_type

end