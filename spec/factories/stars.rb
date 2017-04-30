FactoryGirl.define do
  factory :star do
    association :starring_users, factory: :user
    association :starred_restaurants, factory: :restaurant
  end
end
