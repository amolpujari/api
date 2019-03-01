FactoryBot.define do
  factory :user, class: User do
    sequence(:username) { |n| "username-#{n}" }
    sequence(:email) { |n| "username-#{n}@example.com" }
    resource
  end
end
