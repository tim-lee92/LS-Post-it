class Category < ActiveRecord::Base
  has_many :post_categories, foreign_key: :category_id
  has_many :posts, through: :post_categories

  validates :name, presence: true
end