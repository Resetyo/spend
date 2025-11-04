class SpendsController < ApplicationController
  before_action :authenticate_user!

  def index
    @spends = SpendItem.all
    @spend = if params[:spend_id]
               spend = SpendItem.find(params[:spend_id])
               spend.like = '1' if spend.like_id
               spend
             else
               SpendItem.new
             end
    @categories = Category.pluck(:title, :id)
    @sources = Source.pluck(:id, :title).to_h
    first_spend = @spends.first&.created_at
    @last_time = if first_spend && first_spend.day < Time.zone.now.day || first_spend.month < Time.zone.now.month
                   first_spend + 1.minute
                 end
  end

  def total
    @categories = Category.pluck(:title, :id)
    @sources = Source.all

    @grouped_items = SpendItem.all
                              .group_by { |item| item.created_at.strftime('%m-%y') }
                              .transform_values do |group_by_date|
      group_by_date.group_by { |item| @categories.find { |category| category.last == item.category_id }&.first }
                   .transform_values do |group_by_category|
        group_by_category.sum do |item|
          item.amount > 0 && !item.target_id ? item.amount : 0
        end
      end
    end

    @grouped_earnings = SpendItem.all
                                 .group_by { |item| item.created_at.strftime('%m-%y') }
                                 .transform_values do |group_by_date|
      group_by_date.sum { |item| item.amount < 0 && !item.target_id ? -item.amount : 0 }
    end

    date = params[:date].present? && Time.zone.parse(params[:date])
    @month = params[:month] || (date || Time.zone.now).strftime('%m-%y')
  end

  def create
    @spend_item = SpendItem.new(spend_item_params)
    @spend_item.like_id = spend_item_params[:like].to_i == 1 ? current_user.id : nil

    if spend_item_params[:source_id] == spend_item_params[:target_id]
      flash[:notice] = 'перевод на источник'
      redirect_to(spends_path)
      return
    end

    if @spend_item.save
      redirect_to spends_path
    else
      render "index"
    end
  end

  def update
    @spend_item = SpendItem.find(params[:id])
    @spend_item.assign_attributes(spend_item_params)
    @spend_item.like_id = spend_item_params[:like].to_i == 1 ? current_user.id : nil

    if @spend_item.save
      redirect_to spends_path
    else
      render "index"
    end
  end

  def destroy
    SpendItem.find(params[:id]).destroy

    redirect_to spends_path
  end

  private

  def spend_item_params
    params.require(:spend_item)
          .permit(:title, :category_id, :amount, :source_id, :target_id, :like, :created_at, :replenishment)
  end
end
