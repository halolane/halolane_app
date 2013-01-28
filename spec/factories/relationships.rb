# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :relationship do
    user_id 1
    profile_id 1
    description "Father"
    profile_admin true
  end
end
