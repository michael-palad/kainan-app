class Star < ApplicationRecord
  belongs_to :starred_restaurants, class_name: "Restaurant", 
             foreign_key: :restaurant_id, counter_cache: :stars_count
  belongs_to :starring_users, class_name: "User", foreign_key: :user_id
  
  validates_uniqueness_of :user_id, scope: :restaurant_id
end