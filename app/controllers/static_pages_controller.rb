class StaticPagesController < ApplicationController
  def home
  end

  def dashboard
    User.all.each do |user|
      current_user.matches << Match.create(match_user_id: user.id)
    end
  end

  def pairs
    @match = User.find(current_user.matches.first.match_user_id)
  end

  def rejects
    current_user.rejects << Reject.create(rejected_user_id: params[:rejected_user_id])
    current_user.matches.delete(params[:rejected_user_id])
    redirect_to pairs_path
  end

  def selections
    current_user.selections << Selection.create(selected_user_id: params[:selected_user_id])
    selected_user = User.find(params[:selected_user_id])
    selected_user.pendings << Pending.create(pending_user_id: current_user.id)
    current_user.matches.delete(params[:selected_user_id])
    redirect_to pairs_path
  end
end
