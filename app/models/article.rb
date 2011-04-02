class Article < ActiveRecord::Base
  validates :title, :presence => true
  validates :body, :presence => true
  
  belongs_to :user
  has_and_belongs_to_many :categories
  has_many :comments
  
  scope :published, where("articles.published_at is NOT NULL")
  scope :draft, where("articles.publised_at is NULL")
  scope :recent, lambda{ published.where("artcles.published_at > ?", 1.week.ago.to_date) }
  scope :where_title, lambda{ |term| where("articles.title LIKE ?", "%#{term}%")}
  
  def long_title
    "#{title} - #{published_at}"
  end
end
