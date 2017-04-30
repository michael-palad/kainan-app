require 'rails_helper'

RSpec.describe User, type: :model do
  context 'associations' do
    it { should have_many(:restaurants) }
    it { should have_many(:stars) }
    it { should have_many(:starred_restaurants) }
  end
  
  it 'should have a valid factory' do
    expect(build(:user)).to be_valid  
  end
end
