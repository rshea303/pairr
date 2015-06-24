class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :user_id
      t.integer :match_user_id

      t.timestamps null: false
    end
  end
end
