class Buy
  include ActiveModel::Model
  attr_accessor  :item_id, :user_id, :post_code, :prefecturse_id, :municipality, :address, :building_name, :phone_number, :purchase_id, :token

  with_options presence: true do
    validates :post_code,      format: {with: /\A[0-9]{3}-[0-9]{4}\z/}
    validates :prefecturse_id, numericality: { other_than: 1 }
    validates :municipality
    validates :address
    validates :phone_number,   format: { with: /\A\d{10,11}\z/ }
    validates :token
  end

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(post_code: post_code, prefecturse_id: prefecturse_id, municipality: municipality, address: address, building_name: building_name, phone_number: phone_number, purchase_id: purchase.id )
  end
end