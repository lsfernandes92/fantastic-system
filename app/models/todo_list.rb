class TodoList < ApplicationRecord
  validates :title, presence: true
  validates :description, length: { maximum: 50 }

  belongs_to :user
end
