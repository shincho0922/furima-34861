class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @buy = Buy.new(buy_params)  
    @item = Item.find(params[:item_id])
    check_user
    check_item
  end

  def create
    @buy = Buy.new(buy_params)  
    buy_check
  end

  private

  def check_user
    if @item.user.id == current_user.id
      redirect_to root_path
    end
  end

  def check_item
    if @item.purchase.present?
      redirect_to root_path
    end
  end

  def buy_params
    params.permit(:item_id, :post_code, :prefecturse_id, :municipality, :address, :building_name, :phone_number, :token).merge(user_id: current_user.id)
  end

  def buy_check
    if @buy.valid?
      @item = Item.find(params[:item_id])
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # 自身のPAY.JPテスト秘密鍵を記述しましょう
      Payjp::Charge.create(
        amount: @item.price,  # 商品の値段
        card: buy_params[:token],    # カードトークン
        currency: 'jpy'                 # 通貨の種類（日本円）
      )
      @buy.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render action: :index
    end
  end
end
