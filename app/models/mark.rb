class Mark < ApplicationRecord
  belongs_to :student

  

  validates :score, presence: true

end
