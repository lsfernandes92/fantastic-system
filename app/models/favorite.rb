class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :todo_list
  validates_uniqueness_of :user_id, scope: :todo_list_id
end
