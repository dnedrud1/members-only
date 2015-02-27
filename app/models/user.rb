class User < ActiveRecord::Base
    attr_accessor :unencrypted_token
    #before_create :save_token
    has_secure_password
    
  def User.new_token
    SecureRandom.urlsafe_base64.to_s
  end
  
  def User.encrypt(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  def save_token
    self.unencrypted_token = User.new_token
    update_attribute(:remember_token, User.encrypt(unencrypted_token))
  end
  
  def forget
    update_attribute(:remember_token, nil)
  end
  
  def authenticated?(item)
    return false if remember_token.nil?
    BCrypt::Password.new(remember_token).is_password?(item)
  end
end
