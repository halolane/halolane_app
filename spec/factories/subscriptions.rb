# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subscription do
    plan_id 1
    email "MyString"
    profile_id 1
    stripe_customer_token "MyString"
  end
end
