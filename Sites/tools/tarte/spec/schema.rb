ActiveRecord::Schema.define :version => 0 do
  create_table :has_one_statuses, :force => true do |t|
    t.integer  :status_code
  end
  
  create_table :has_many_ingredients, :force => true do |t|
    t.string :dish
    t.integer :ingredients_mask
  end
end