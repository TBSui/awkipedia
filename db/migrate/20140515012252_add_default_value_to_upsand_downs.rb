class AddDefaultValueToUpsandDowns < ActiveRecord::Migration
  def change
  	change_column_default(:awkiposts, :ups, 0)
  	change_column_default(:awkiposts, :downs, 0)

  end
end
