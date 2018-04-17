FactoryGirl.define do
  factory :default_todo_item, class: "TodoItem" do
    content       "New todo item"
    todo_list
  end
end
