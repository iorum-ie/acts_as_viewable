class ActsAsViewableMigration < ActiveRecord::Migration
  def self.up
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
  end

  def self.down
    remove_index :total_viewings, [:viewable_type, :viewable_id]
    
    drop_table :total_viewings
    
    add_index :viewings, [:viewable_type]
    add_index :viewings, [:viewable_id, :viewable_type, :ip]
    
    drop_table :viewings
  end
end