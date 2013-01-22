FactoryGirl.define do
  factory :user do
    name     "Foo Bar"
    email    "foo@bar.com"
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :memory do
    content "Hi there"
    user
  end
end