class TodoList < ApplicationRecord
  validates :title, :description, presence: true
  validates :description, length: { maximum: 50 }
end
