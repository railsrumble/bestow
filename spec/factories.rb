FactoryGirl.define do
  sequence :email do |n|
    "user-#{n}@example.com"
  end

  trait :first_or_new_list do
    before(:create) do |model|
      model.list ||= List.first || create(:list)
    end
  end

  trait :first_or_new_user do
    before(:create) do |model|
      model.user ||= User.first || create(:user)
    end
  end

  factory :invitation do
    first_or_new_list
    first_or_new_user
    email
  end

  factory :list do
    sequence(:name) { |n| "List #{n}" }
    first_or_new_user
  end

  factory :list_share do
    first_or_new_list
    first_or_new_user
  end

  factory :person do
    list
    sequence(:name) { |n| "Person #{n}" }
    amount 100.5
  end

  factory :purchased_gift do
    person
    sequence(:name) { |n| "Purchased Gift #{n}" }
    amount 1.5
  end

  factory :user do
    email
    password "password"
  end
end
