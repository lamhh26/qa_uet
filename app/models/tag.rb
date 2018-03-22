class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags

  scope :load_tags, (-> do
    left_outer_joins(:posts).group(:id).select "tags.*, COUNT(*) AS tag_count"
  end)

  scope :popular, ->{order "tag_count DESC"}

  scope :sort_by_name, ->{order :name}
end
