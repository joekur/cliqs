class CreateCliqMemberships < ActiveRecord::Migration
  def change
    create_table :cliq_memberships do |t|
      t.integer :cliq_id
      t.integer :user_id
      t.boolean :accepted
      t.integer :nav_rank

      t.timestamps
    end
  end
end
