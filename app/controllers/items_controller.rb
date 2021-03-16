class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :show, :update, :create]
  def index
    @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find{params[:id]}
  end

  def edit
    @item = Item.find{params[:id]}
    check_user
  end

  def update
    @item = Item.find{params[:id]}
    check_user
    if @item.update(item_params)
      redirect_to action: :index
    else
      render :edit
    end
  end



  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :status_id, :delivery_fee_id, :delivery_source_id, :delivery_date_id, :price).merge(user_id: current_user.id)
  end

  def check_user
    if @item.user.id != current_user.id
      redirect_to action: :index
    end
  end
end
