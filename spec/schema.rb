ActiveRecord::Schema.define :version => 0 do
  create_table :viewings do |t|
    t.integer :viewable_id
    t.string :viewable_type
    t.string :ip
    t.timestamps
  end
  
  add_index :viewings, [:viewable_id, :viewable_type, :ip]
  add_index :viewings, [:viewable_type]
  
  create_table :total_viewings do |t|
    t.integer :viewable_id
    t.string :viewable_type
    t.integer :viewings
    t.timestamps
  end
  
  add_index :total_viewings, [:viewable_type, :viewable_id], :unique => true
  
  create_table :viewable_model_without_ttls, :force => true do |t|
  end
  
  create_table :viewable_model_with_ttls, :force => true do |t|
  end
end