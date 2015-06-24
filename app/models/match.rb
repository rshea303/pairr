class Match < ActiveRecord::Base
  def self.current_user_match_ids(curr_user)
    curr_user.matches.map do |user|
      user.match_user_id
    end
  end
end
