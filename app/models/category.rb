class Category < ApplicationRecord
  before_save :format_name

  has_many :posts

  validates :name, presence: true, uniqueness: true

  private

  def format_name
    self.name = name.parameterize
  end
end
