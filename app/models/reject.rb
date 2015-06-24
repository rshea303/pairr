class Reject < ActiveRecord::Base
  def self.make_list_of_reject_ids(curr_user)
    curr_user.rejects.map do |reject|
      reject.rejected_user_id
    end
  end
end
