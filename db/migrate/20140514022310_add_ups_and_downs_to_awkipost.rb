class AddUpsAndDownsToAwkipost < ActiveRecord::Migration
  def change
    add_column :awkiposts, :ups, :integer
    add_column :awkiposts, :downs, :integer
  end
end
