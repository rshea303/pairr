class CreateSelections < ActiveRecord::Migration
  def change
    create_table :selections do |t|
      t.integer :user_id
      t.integer :selected_user_id

      t.timestamps null: false
    end
  end
end
