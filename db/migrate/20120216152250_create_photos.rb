class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :user_id
      t.integer :cliq_id
      t.text :body
      t.string :image

      t.timestamps
    end
  end
end
