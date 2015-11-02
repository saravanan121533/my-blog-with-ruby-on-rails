class Comment < ActiveRecord::Base
  # validation for comment model
  validates :body, presence: true, uniqueness: true
end
