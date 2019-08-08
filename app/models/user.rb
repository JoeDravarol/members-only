class User < ApplicationRecord
  before_save :downcase_email
  before_create :generate_remember_token

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, length: { maximum: 255 },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }


  def generate_remember_token
    new_token = SecureRandom.urlsafe_base64

    # Encrypt and save token
    self.remember_token = Digest::SHA1.hexdigest(new_token)
  end
  
  private
    
    def downcase_email
      self.email.downcase!
    end
end
