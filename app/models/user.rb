class User < ActiveRecord::Base
    
    before_create :save_token
    has_secure_password
    
  def User.new_token
    SecureRandom.urlsafe_base64.to_s
  end
  
  def User.encrypt(string)
    Digest::SHA1.hexdigest(string)
  end
  
  def save_token
    self.remember_token = User.encrypt(User.new_token)
  end
  
  def forget
    update_attribute(:remember_token, nil)
  end
end
