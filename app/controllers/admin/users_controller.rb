class Admin::UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :admin_user

  def index
    @search = User.ransack(params[:q])
    @users = @search.result(distinct: true).paginate(page: params[:page], per_page: 10).order(created_at: :desc)
  end

  def update
    @user = User.find(params[:id])
    @user.update(is_admin: true)
    redirect_back(fallback_location: request.referer)
  end

  def destroy
    @user = User.find(params[:id])
    @user.update(is_admin: false)
    redirect_back(fallback_location: request.referer)   
  end
end
