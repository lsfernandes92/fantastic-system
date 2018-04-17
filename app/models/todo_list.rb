class TodoList < ApplicationRecord
  belongs_to :user
  has_many :todo_items, dependent: :destroy

  has_many :favorites
  has_many :users, through: :favorites

  validates :title, presence: true
  validates :description, :title, length: { maximum: 50 }

  def public?
    self.public
  end
end
