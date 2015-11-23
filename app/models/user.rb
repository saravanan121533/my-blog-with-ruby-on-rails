class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, uniqueness: true

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :favourites, dependent: :nullify
  has_many :favourite_post, through: :favourites, source: :post

end
