class AddPublicToTodoLists < ActiveRecord::Migration[5.1]
  def change
    add_column :todo_lists, :public, :boolean
  end
end
