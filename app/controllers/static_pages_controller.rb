class StaticPagesController < ApplicationController
  before_action :authorize!, except: [:home]

  def home
  end

  def dashboard
    User.all.each do |user|
      current_user.matches << Match.create(match_user_id: user.id)
    end

    selections_ids = current_user.selections.map do |selection|
      selection.selected_user_id
    end

    reject_ids = current_user.rejects.map do |reject|
      reject.rejected_user_id
    end

    current_user_match_ids = current_user.matches.map do |user|
      user.match_user_id
    end

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
