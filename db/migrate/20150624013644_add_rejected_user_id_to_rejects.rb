class AddRejectedUserIdToRejects < ActiveRecord::Migration
  def change
    add_column :rejects, :rejected_user_id, :integer
  end
end
