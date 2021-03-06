class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable
  validates :fullname, presence: true
  mount_uploader :image, ImageUploader

  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :followings, through: :following_relationships
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships
  has_many :lessons, dependent: :destroy
  has_many :categories, through: :lessons
  has_many :activities, dependent: :destroy
  has_one :activity, as: :action
  has_many :answers, through: :lessons

  def following?(other_user)
    following_relationships.find_by(following_id: other_user.id)
  end

  def follow!(other_user)
    following_relationships.create!(following_id: other_user.id)
  end

  def unfollow!(other_user)
    following_relationships.find_by(following_id: other_user.id).destroy
  end

  def lesson_taken(cat_id)
    lesson = lessons.find_by(category_id: cat_id)
  end

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
