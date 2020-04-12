class UsersController < ApplicationController

  def index
    @users = User.paginate(page: params[:page], per_page: 10).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
  end

  def following
    @user  = User.find(params[:id])
    @users = @user.followings.paginate(page: params[:page], per_page: 10).order(created_at: :desc)
    render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page], per_page: 10).order(created_at: :desc)
    render 'show_follower'
  end
end
