class OrdersController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
  end

  def create
    Purchase.create(purchase_params)
    Address.create(address_params)
    redirect_to action: :index
  end

  private

  def purchase_params
    params.parmit(:item_id).merge(user_id: current_user.id)
  end

  def address_params
    params.parmit(:post_code, :prefecturse_id, :municipality, :address, :building_name, :phone_number).merge(purchase_id: purchase.id)
  end
end
