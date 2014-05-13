class CreateAwkiposts < ActiveRecord::Migration
  def change
    create_table :awkiposts do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
    add_index :awkiposts, [:user_id, :created_at]
  end
end
