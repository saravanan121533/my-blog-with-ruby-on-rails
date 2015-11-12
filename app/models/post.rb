class Post < ActiveRecord::Base
  # validation for post model
  validates :title, presence: true, uniqueness: true
  validates :body, presence: true, uniqueness: true

  # scope :post_params, -> {params.require(:post).permit([:title, :body])}

  def ten_items
    oder("created_at DESC").limit(10)
  end

  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :category

end
