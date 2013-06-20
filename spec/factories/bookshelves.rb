# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bookshelf do
    name "MyString"
    user_id 1
    privacy 1
  end
end
