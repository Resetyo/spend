class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    @category = if params[:category_id]
            category = Category.find(params[:category_id])
            category.like = 1 if category.like_id
          else
            Category.new
          end
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_path
    else
      render "index"
    end
  end

  def update
    @category = Category.find(params[:id])
    @category.assign_attributes(category_params)

    if @category.save
      redirect_to categories_path
    else
      render "index"
    end
  end

  def destroy
    Category.find(params[:id]).destroy

    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:title, :position)
  end
end
