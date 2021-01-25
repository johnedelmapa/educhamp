class Choice < ApplicationRecord
  belongs_to :word
  has_many :answers
  validates :content, presence: true
end
