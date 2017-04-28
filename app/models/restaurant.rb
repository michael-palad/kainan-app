class Restaurant < ApplicationRecord
    
  # Associations
  belongs_to :user
  has_many :stars
  has_many :starring_users, through: :stars
  
  # Validation
  validates_presence_of :name, :address, :telephone_number, :cuisine
  validates :cuisine, 
            inclusion: { in: %w(Filipino Chinese American Korean Fastfood),
            message: "%{value} is not a valid cuisine category" }
            
  validate :check_telephone_number_format
  
  def check_telephone_number_format
    valid_phone_formats = [
      /^\+\d\d \d \d\d\d-\d\d\d\d$/,               # +63 2 123-4567
      /^\d\d \d\d\d-\d\d\d\d$/,                    # 02 123-4567
      /^\+\d\d \d \d\d\d-\d\d\d\d ext. \d\d\d$/    # +63 2 123-4567 ext. 103
    ]
                  
    matched = valid_phone_formats.map do |re|
      re.match(telephone_number)
    end.any?
    unless matched
      errors.add(:telephone_number, "Invalid format for telephone number")
    end
  end
  
end
