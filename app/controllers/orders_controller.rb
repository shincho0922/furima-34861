class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @buy = Buy.new(buy_params)  
    @item = Item.find(params[:item_id])
    check_user
  end

  def create
    @buy = Buy.new(buy_params)  
    if @buy.valid?
      @buy.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render action: :index
    end
  end

  private

  def check_user
    if @item.user.id == current_user.id
      redirect_to root_path
    end
  end

  def buy_params
    params.permit(:item_id, :post_code, :prefecturse_id, :municipality, :address, :building_name, :phone_number).merge(user_id: current_user.id)
  end
end
