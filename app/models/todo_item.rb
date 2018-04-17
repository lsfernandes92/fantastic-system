class TodoItem < ApplicationRecord
  belongs_to :todo_list

  validates :content, presence: true
  validates :content, length: { maximum: 40 }

  def completed?
    !completed_at.blank?
  end
end
