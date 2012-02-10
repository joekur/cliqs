class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.integer :cliq_id
      t.date :birthdate
      t.text :quote

      t.timestamps
    end
  end
end
