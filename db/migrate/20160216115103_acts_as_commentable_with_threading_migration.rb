class ActsAsCommentableWithThreadingMigration < ActiveRecord::Migration
  def self.up
    create_table :faalis_tags, :force => true do |t|
      t.integer :tagable_id
      t.string :tagable_type
      t.string :title
      t.text :body
      t.string :subject
      t.integer :user_id, :null => false
      t.integer :parent_id, :lft, :rgt
      t.timestamps
    end

    add_index :faalis_tags, :user_id
    add_index :faalis_tags, [:tagable_id, :tagable_type]
  end

  def self.down
    drop_table :faalis_tags
  end
end
