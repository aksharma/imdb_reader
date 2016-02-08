class CreateActors < ActiveRecord::Migration
  def change
    create_table :actors do |t|
      t.string :name
      t.float :rating

      t.timestamps
    end
  end
end
