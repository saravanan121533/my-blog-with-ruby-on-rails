class Post < ActiveRecord::Base
  # validation for post model
  validates :title, presence: true, uniqueness: true
  validates :body, presence: true, uniqueness: true

  # model associations
  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :category

  has_many :taggings
  has_many :tags, through: :taggings, dependent: :destroy

  has_many :favourites, dependent: :destroy
  has_many :favouriting_users, through: :favourites, source: :user

  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user


  # method used for search form
  def self.search(term)
    if term
      # this will handle if no terms is found in tags table it will only
      # search in posts table
      begin
        tag = Tag.find_by_name!(term)
        where(["LOWER(title) LIKE :search_term OR LOWER(body) LIKE :search_term",
               {search_term: "%#{term}%"}]) + tag.posts
      rescue ActiveRecord::RecordNotFound => e
        where(["LOWER(title) LIKE :search_term OR LOWER(body) LIKE :search_term",
               {search_term: "%#{term}%"}])
      end

      # previous implementations
      # this will error if term is not found in tags table, fixed using above implementation
      # where(["LOWER(title) LIKE :search_term OR LOWER(body) LIKE :search_term",
            #  {search_term: "%#{term}%"}]) + Tag.find_by_name!(term).posts
      # this will return the tagging object and not the post object
      # Tagging.joins(:post, :tag).where(["LOWER(posts.title) LIKE :search_term OR LOWER(posts.body) LIKE :search_term", {search_term: "%#{term}%"}])
      # OK: Tagging.joins(:post, :tag).where("tags.name": "bacon")
    else
      all
    end
  end

  # The strip function is for removing whitespace
  # This will be used during new/edit blog
  def all_tags=(names)
    self.tags = names.split(",").map do |name|
        Tag.where(name: name.strip).first_or_create!
    end
  end

  # This will be customized to render all the tags separated by commas.
  # This will be used during new/edit blog
  def all_tags
    self.tags.map(&:name).join(", ")
  end

  def favourited_by?(user)
    favourite_for(user).present?
  end

  def favourite_for(user)
    favourites.find_by_user_id user.id
  end

  def liked_by?(user)
    like_for(user).present?
  end

  def like_for(user)
    likes.find_by_user_id(user.id)
  end

end
