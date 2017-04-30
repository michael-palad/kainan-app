require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  context 'validations' do
    it { should validate_presence_of(:name) }  
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:telephone_number) }
    it { should validate_presence_of(:cuisine) }
    it do
      should validate_inclusion_of(:cuisine)
        .in_array(%w(Filipino Chinese American Korean Fastfood))
    end
  end
  
  context 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:stars) }
    it { should have_many(:starring_users) }
  end
  
  it 'should have a valid factory' do
    expect(build(:restaurant)).to be_valid  
  end
end