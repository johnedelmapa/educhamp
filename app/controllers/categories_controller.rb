class CategoriesController < ApplicationController
  before_action :authenticate_user!
  # def index
  #   @search = Category.ransack(params[:q])
  #   @categories = @search.result(distinct: true).paginate(page: params[:page], per_page: 10).order(created_at: :desc)
  # end
  def index
    @categories = Category.paginate(page: params[:page], per_page: 10)
    @status = params[:status]
    if @status == "1"
      @categories = current_user.categories.paginate(page: params[:page], per_page: 10)
    elsif @status == "0"
      @categories = @categories.where.not(id: current_user.category_ids).paginate(page: params[:page], per_page: 10)
    end
  end
end


