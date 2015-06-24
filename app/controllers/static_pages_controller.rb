class StaticPagesController < ApplicationController
  before_action :authorize!, except: [:home]

  def home
  end

  def dashboard
    User.make_current_matches(current_user)
    selections_ids = Selection.make_selections_list(current_user) 
    reject_ids = Reject.make_list_of_reject_ids(current_user)
    current_user_match_ids = Match.current_user_match_ids(current_user)
    removed_users = (selections_ids + reject_ids + [current_user.id]).compact

    removed_users.each do |removed_user_id|
      if current_user_match_ids.include?(removed_user_id)
        current_user.matches.find_by(match_user_id: removed_user_id).destroy
      end
    end
    current_user.matches
  end

  def pairs
    if current_user.pendings.nil? || current_user.pendings.empty?
      @match = User.find(current_user.matches.first.match_user_id)
    else
      @match = User.find(current_user.pendings.first.pending_user_id)
    end
  end

  def rejects
    current_user.rejects << Reject.create(rejected_user_id: params[:rejected_user_id])
    if current_user.matches.find_by(match_user_id: params[:rejected_user_id])
      current_user.matches.find_by(match_user_id: params[:rejected_user_id]).destroy
    else
      current_user.pendings.find_by(pending_user_id: params[:rejected_user_id]).destroy
    end
    redirect_to pairs_path
  end

  def selections
    if current_user.pendings.find_by(pending_user_id: params[:selected_user_id])
      current_user.buds << Bud.create(bud_user_id: params[:selected_user_id])
      current_user.pendings.find_by(pending_user_id: params[:selected_user_id]).destroy
      flash[:notice] = "Congratulations! You and #{User.find(params[:selected_user_id]).nickname} are a pair!"
      redirect_to dashboard_path
    else
      current_user.selections << Selection.create(selected_user_id: params[:selected_user_id])
      selected_user = User.find(params[:selected_user_id])
      selected_user.pendings << Pending.create(pending_user_id: current_user.id)

      current_user.matches.find_by(match_user_id: params[:selected_user_id]).destroy
      redirect_to pairs_path
    end
  end
end
