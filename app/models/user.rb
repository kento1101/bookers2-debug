class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 has_many :books, dependent: :destroy
  attachment :profile_image
  
 has_many :favorites, dependent: :destroy
 
 has_many :post_comments, dependent: :destroy
 
 
 
 has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
 has_many :followings, through: :active_relationships, source: :follower

 has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
 has_many :followers, through: :passive_relationships, source: :following


  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  
   validates :introduction,
    length: { maximum: 50 }

  
 
  
  def followed_by?(user)
   passive_relationships.find_by(following_id: user.id).present?
  end
  
end
