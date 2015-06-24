class StaticPagesController < ApplicationController
  def home
  end

  def dashboard
    User.all.each do |user|
      current_user.matches << Match.create(match_user_id: user.id)
      selections_ids = current_user.selections.map do |selection|
        selection.selected_user_id
      end
      reject_ids = current_user.rejects.map do |reject|
        reject.rejected_user_id
      end
      removed_users = (selections_ids + reject_ids + [current_user.id]).compact
    end
  end

  def pairs
    @match = User.find(current_user.matches.first.match_user_id)
  end

  def rejects
    current_user.rejects << Reject.create(rejected_user_id: params[:rejected_user_id])
    current_user.matches.find_by(match_user_id: params[:rejected_user_id]).destroy
    redirect_to pairs_path
  end

  def selections
    current_user.selections << Selection.create(selected_user_id: params[:selected_user_id])
    selected_user = User.find(params[:selected_user_id])
    selected_user.pendings << Pending.create(pending_user_id: current_user.id)
    current_user.matches.find_by(match_user_id: params[:selected_user_id]).destroy
    redirect_to pairs_path
  end
end
