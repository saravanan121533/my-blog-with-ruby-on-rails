class Comment < ActiveRecord::Base
  # validation for comment model
  validates :body, presence: true

  belongs_to :user
  belongs_to :post
end
