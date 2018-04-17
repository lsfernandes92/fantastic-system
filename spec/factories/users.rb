FactoryGirl.define do
  factory :default_user, class: "User" do
    email                  "john@snow.com"
    password               "me_know_nothing"
    password_confirmation  "me_know_nothing"
  end

  factory :user do
    sequence(:email) { |n| "mike#{n}@awesome.com"}
    password               "password"
    password_confirmation  "password"
  end
end
