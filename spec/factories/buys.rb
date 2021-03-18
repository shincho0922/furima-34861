FactoryBot.define do
  factory :buy do
    post_code      {"123-4567"}
    prefecturse_id {13}
    municipality   {"墨田区"}
    address        {"青山1-1-1"}
    phone_number   {"08012345678"}
    token          {"test"}
  end
end
