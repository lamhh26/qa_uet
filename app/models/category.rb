class Category < ApplicationRecord
  before_save :name_downcase

  has_many :posts

  private

  def name_downcase
    name.downcase!
  end
end
