class Admin::PagesController < ApplicationController

  before_action :authenticate_user!
  before_action :admin_user

  def dashboard
    @user_count = User.count
    @category_count = Category.count
    @users = User.last(5).reverse
  end
end
