class CreateCliqs < ActiveRecord::Migration
  def change
    create_table :cliqs do |t|
      t.string :name

      t.timestamps
    end
  end
end
