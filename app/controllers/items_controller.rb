class ItemsController < ApplicationController
  def index

  end

  def new
    unless user_signed_in?
      redirect_to new_user_session_path
    end
    @item = Item.new
  end

  def create
    
  end
end
