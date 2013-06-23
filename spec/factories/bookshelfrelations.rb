# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bookshelfrelation do
    user_id 1
    bookshelf_id 1
    permission "MyString"
    owner false
  end
end
