class ItemTagRelation
  include ActiveModel::Model
  attr_accessor  :tag_name, :name, :description, :category_id, :status_id, :delivery_fee_id, :delivery_source_id, :delivery_date_id, :price, :user_id, :images

  with_options presence: true do
    validates :images
    validates :name
    validates :description
    validates :tag_name
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

  def save
    item = Item.create(name: name, description: description,category_id: category_id, status_id: status_id, delivery_fee_id: delivery_fee_id, delivery_date_id: delivery_date_id, delivery_source_id: delivery_source_id, price: price, user_id: user_id, images: images)
    tag = Tag.where(tag_name: tag_name).first_or_initialize
    tag.save

    ItemTag.create(item_id: item.id, tag_id: tag.id)
  end
end