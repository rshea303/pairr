class CreatePendings < ActiveRecord::Migration
  def change
    create_table :pendings do |t|
      t.integer :user_id
      t.integer :pending_user_id

      t.timestamps null: false
    end
  end
end
