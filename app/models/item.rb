class Item < ApplicationRecord
  with_options presence: true do
    validates :image
    validates :name
    validates :description
    with_options numericality: { other_than: 1 } do
      validates :category_id
      validates :status_id
      validates :delivery_fee_id
      validates :delivery_source_id
      validates :delivery_date_id
    end
    validates :price, numericality: {
      only_integer: true,greater_than: 299, less_than: 10000000 
      }
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
