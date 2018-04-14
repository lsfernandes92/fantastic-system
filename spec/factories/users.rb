FactoryGirl.define do
  factory :default_user, class: "User" do
    email                  "email@example.com.br"
    password               "password"
    password_confirmation  "password"
  end

  factory :user do
    sequence(:email) { |n| "mike#{n}@awesome.com"}
    password               "password"
    password_confirmation  "password"
  end
end
