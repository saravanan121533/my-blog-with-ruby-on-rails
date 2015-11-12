class Category < ActiveRecord::Base
  # validation for category model
  validates :title, presence: true

  has_many :posts, dependent: :destroy
end
