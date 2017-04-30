class Restaurant < ApplicationRecord
  after_create :submitter_automatic_star
    
  # Associations
  belongs_to :user
  has_many :stars
  has_many :starring_users, through: :stars, dependent: :destroy
  
  # Validation
  validates_presence_of :name, :address, :telephone_number, :cuisine
  validates_uniqueness_of :name
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
      error_msg = <<-DOC
      format is invalid<br />
      Example:<br />
        +63 2 123-4567<br />
        02 123-4567<br />
        +63 2 123-4567 ext. 103
      DOC
    
      errors.add(:telephone_number, error_msg)
    end
  end
  
  protected
  
    def submitter_automatic_star
      user = self.user
      user.starred_restaurants << self
      user.save
    end

end
