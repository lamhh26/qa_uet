class Vote < ApplicationRecord
  belongs_to :post

  enum vote_type: {down_mod: 0, up_mod: 1}
end
