class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :choose_item
  before_action :checker

  def index
    @buy = Buy.new(buy_params)  
  end

  def create
    @buy = Buy.new(buy_params)  
    buy_check
  end

  private

  def choose_item
    @item = Item.find(params[:item_id])
  end

  def checker
    if @item.user.id == current_user.id
      redirect_to root_path
    elsif @item.purchase.present?
      redirect_to root_path
    end
  end

  def buy_params
    params.permit(:item_id, :post_code, :prefecturse_id, :municipality, :address, :building_name, :phone_number, :token).merge(user_id: current_user.id)
  end

  def buy_check
    if @buy.valid?
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
