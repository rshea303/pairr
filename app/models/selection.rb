class Selection < ActiveRecord::Base
  def self.make_selections_list(curr_user)
    curr_user.selections.map do |selection|
      selection.selected_user_id
    end
  end
end
