# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :storycomment do
    user_id 1
    memory_id 1
    content "MyString"
  end
end
