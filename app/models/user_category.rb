class UserCategory < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validate :check_user

  private

  def check_user
    errors.add(:user, "must be consultant") unless user.consultant
  end
end
