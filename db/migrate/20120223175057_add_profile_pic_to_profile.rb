class AddProfilePicToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :pic, :string

  end
end
