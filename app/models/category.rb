class Category < ActiveRecord::Base
  # validation for category model
  validates :title, presence: true
end
