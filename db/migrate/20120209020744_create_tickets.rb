class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :token
      t.string :email
      t.integer :cliq_id
      t.integer :user_id

      t.timestamps
    end
  end
end
