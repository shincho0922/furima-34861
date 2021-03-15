class Item < ApplicationRecord
  with_options presence: true do
    validates :image
    validates :name
    validates :description
    validates :category_id, numericality: { other_than: 1 }
    validates :statui_id
    validates :price, numericality: {
      only_integer: true,greater_than: 299, less_than: 10000000 
      }
    validates :delovery_fee_id
    validates :delivery_source_id
    validates :delivery_date_id
  end

  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_fee
  belongs_to :delivery_source
  belongs_to :delivery_date
end
