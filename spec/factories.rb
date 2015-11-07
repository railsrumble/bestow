FactoryGirl.define do
  trait :first_or_new_user do
    before(:create) do |model|
      model.user ||= User.first || create(:user)
    end
  end

  factory :list do
    name "My List"
    first_or_new_user
  end

  factory :person do
    sequence(:name)  { |n| "Person #{n}" }
    amount 100.5
  end

  factory :user do
    sequence(:email) { |n| "user-#{n}@example.com" }
    password "password"
  end
end
