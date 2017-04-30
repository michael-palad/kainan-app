FactoryGirl.define do
  factory :user do
    email 'sampleuser@email.com'
    password 'my_password1'
    password_confirmation 'my_password1'
  end
end