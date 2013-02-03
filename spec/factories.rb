FactoryGirl.define do
  factory :user do
    sequence(:first_name)  { |n| "New #{n}" }
    sequence(:last_name)  { |n| "User #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :memory do
    content "Hi there"
    user
    profile
  end

  factory :profile do
    first_name  "test"
    last_name   "user"
    birthday    70.years.ago
    deathday    Date.today
    privacy 0
    url "testuser"
    
  end

end