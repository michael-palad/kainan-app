class Restaurant < ApplicationRecord
    
  # Associations
  belongs_to :user
  
  # Validation
  validates_presence_of :name, :address, :telephone_number, :cuisine
  validates :cuisine, 
            inclusion: { in: %w(Filipino Chinese American Korean Fastfood),
            message: "%{value} is not a valid cuisine category" }
  
end
