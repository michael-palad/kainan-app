FactoryGirl.define do
  factory :star do
    association :starred_restaurants, factory: :restaurant
    association :starring_users, factory: :user
  end
end
