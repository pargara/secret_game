class Area < ApplicationRecord
  has_many :employees

  validates :name, presence: true, length: { minimum: 3 }, uniqueness: true, format: { with: /^[a-zA-Z0-9]*$/ }
end
