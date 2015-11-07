FactoryGirl.define do
  factory :person do
    sequence(:name)  { |n| "Person #{n}" }
    amount 100.5
  end

  factory :user do
    sequence(:email) { |n| "user-#{n}@example.com" }
    password "password"
  end
end
