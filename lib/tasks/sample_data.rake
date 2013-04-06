namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_profile
    make_relationships
  end
end

def make_users
  admin = User.create!(first_name:     "New",
                       last_name:     "User",
                       email:    "example@railstutorial.org",
                       password: "foobar",
                       password_confirmation: "foobar")
  admin.toggle!(:admin)
  99.times do |n|
    first_name  = Faker::Name.name
    last_name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    User.create!(first_name:     first_name,
                 last_name:     last_name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_profile
  users = User.all
  admin  = users.first
  profile = admin.profiles.create!(first_name: "Grandma", last_name: "Johnson", 
                     birthday: 70.years.ago , 
                     deathday: Date.today ,
                     privacy: 0 )
end

def make_relationships
  profile = Profile.first
  users = User.all
  contributors = users[2..25]
  contributors.each { |user| user.contribute!(profile) } 
end

def make_memories
  profile = Profile.first
  users = User.all(limit: 6)
  50.times do
    content = Faker::Lorem.sentence(5)
    users.each do |user| 
      user.memories.create!(content: content, profile_id: 1)
    end
  end
end
