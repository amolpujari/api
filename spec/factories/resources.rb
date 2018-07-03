FactoryBot.define do
  factory :resource, class: Resource do
    sequence(:name) { |n| "item #{n}" }
  end
end
