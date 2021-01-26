class PagesController < ApplicationController
  def home
    if signed_in?
      @user = current_user
      @activities = Activity.where("user_id IN (?) OR user_id = ?", current_user.following_ids, current_user.id).paginate(page: params[:page], per_page: 10)
      render 'users/home_feed'
    end
  end
end
