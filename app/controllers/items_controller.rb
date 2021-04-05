class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :create]
  before_action :choose_item, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:update, :edit, :destroy]
  before_action :check_item, only: [:edit, :update, :destroy]

  def index
    @items = Item.order("created_at DESC")
  end

  def new
    @item = ItemTagRelation.new
  end

  def create
    @item = ItemTagRelation.new(item_params)
    if @item.valid?
      @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_update_params)
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
    params.require(:item_tag_relation).permit(:tag_name, :name, :description, :category_id, :status_id, :delivery_fee_id, :delivery_source_id, :delivery_date_id, :price, images: [] ).merge(user_id: current_user.id)
  end

  def item_update_params
    params.require(:item).permit(:name, :description, :category_id, :status_id, :delivery_fee_id, :delivery_source_id, :delivery_date_id, :price, images: [] ).merge(user_id: current_user.id)
  end

  def check_user
    if @item.user.id != current_user.id
      redirect_to action: :index
    end
  end

  def choose_item
    @item = Item.find(params[:id])
  end

  def check_item
    if @item.purchase.present?
      redirect_to root_path
    end
  end
end
