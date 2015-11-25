class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :posts_comments, through: :posts, source: :comments

  has_many :favourites, dependent: :nullify
  has_many :favourite_post, through: :favourites, source: :post

  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

end
