class ModifyUser < ActiveRecord::Migration
  def change
    add_column :users, :how_to_box, :boolean, :null => false, :default => true 
  end
end
