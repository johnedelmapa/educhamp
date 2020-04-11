class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable
  validates :fullname, presence: true

  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first
    if user
      return user
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20] #Creating random password
        user.fullname = auth.info.name   #Changed username to fullname
        user.image = auth.info.image # assuming the user model has an image
        user.uid = auth.uid
        user.provider = auth.provider
        
        user.skip_confirmation!
      end
    end
  end
end
