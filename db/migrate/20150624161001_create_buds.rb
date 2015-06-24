class CreateBuds < ActiveRecord::Migration
  def change
    create_table :buds do |t|
      t.integer :user_id
      t.integer :bud_user_id

      t.timestamps null: false
    end
  end
end
