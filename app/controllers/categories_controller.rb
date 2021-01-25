class CategoriesController < ApplicationController
  before_action :authenticate_user!
  def index
    @search = Category.ransack(params[:q])
    @categories = @search.result(distinct: true).paginate(page: params[:page], per_page: 10).order(created_at: :desc)
  end
end


