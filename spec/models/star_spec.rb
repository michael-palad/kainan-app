require 'rails_helper'

RSpec.describe Star, type: :model do
   context 'validations' do
    it { should validate_uniqueness_of(:user_id).scoped_to(:restaurant_id) }
  end
  
  context 'associations' do
    it { should belong_to(:starred_restaurants) }
    it { should belong_to(:starring_users) }
  end
end
