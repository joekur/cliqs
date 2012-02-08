class CreateCliqMemberships < ActiveRecord::Migration
  def change
    create_table :cliq_memberships do |t|
      t.int :cliq_id
      t.int :user_id
      t.boolean :accepted
      t.int :nav_rank

      t.timestamps
    end
  end
end
