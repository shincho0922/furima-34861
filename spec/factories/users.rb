FactoryBot.define do
  factory :user do
    nickname              {'test'}
    email                 {Faker::Internet.free_email}
    password              {'123abc'}
    password_confirmation {password}
    first_name            {'加藤'}
    last_name             {'和丸'}
    first_name_kana       {'カトウ'}
    last_name_kana        {'カズマル'}
    date_of_birth         {'1995-09-22'}
  end
end