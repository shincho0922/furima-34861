class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :show, :update, :create]
  before_action :choose_item, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:update, :edit, :destroy]

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
    choose_item
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to action: :index
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
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

  def choose_item
    @item = Item.find(params[:id])
  end
end
