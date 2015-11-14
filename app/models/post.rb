class Post < ActiveRecord::Base
  # validation for post model
  validates :title, presence: true, uniqueness: true
  validates :body, presence: true, uniqueness: true

  # model associations
  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :category

  # method used for search form
  def self.search(term)
    if term
      where(["LOWER(title) LIKE :search_term OR LOWER(body) LIKE :search_term",
             {search_term: "%#{term}%"}])
    else
      all
    end
  end

  def ten_items
    order("created_at DESC").limit(10)
  end

end
