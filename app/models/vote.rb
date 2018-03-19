class Vote < ApplicationRecord
  belongs_to :post
  belongs_to :user

  enum vote_type: {down_mod: -1, up_mod: 1}
end
