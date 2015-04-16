class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :lists, dependent: :destroy

  def clear_authentication_token!
    self.update authentication_token: nil
  end

  def set_authentication_token!
    self.authentication_token = generate_authentication_token
    self.save
  end

  private

  def generate_authentication_token
    loop do 
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
