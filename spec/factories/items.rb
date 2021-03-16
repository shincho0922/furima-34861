FactoryBot.define do
  factory :item do
    name               {'test'}
    description        {'test'}
    category_id        {2}
    status_id          {2}
    delivery_fee_id    {3}
    delivery_source_id {14}
    delivery_date_id   {2}
    price              {1000}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
