FactoryGirl.define do
  factory :todo_list_public, class: "TodoList" do
    title         "New todo list public"
    description   "Some cool description"
    user
    public        true
  end

  factory :todo_list_private, class: "TodoList" do
    title         "New todo list private"
    description   "Some cool description"
    user
    public        false
  end

  factory :todo_list do
    title         "Default todo list"
    description   "Some random default description"
    user
    public        true
  end
end
