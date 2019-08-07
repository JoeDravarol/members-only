class User < ApplicationRecord
  before_save :downcase_email

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, length: { maximum: 255 },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  private
    
    def downcase_email
      self.email.downcase!
    end
end
