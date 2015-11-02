class Post < ActiveRecord::Base
  # validation for post model
  validates :title, presence: true, uniqueness: true
end
