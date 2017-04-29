class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  # Associations
  has_many :restaurants
  has_many :stars
  has_many :starred_restaurants, through: :stars
  
end
