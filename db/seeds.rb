# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

[	"Son", 
	"Daughter", 
	"Father", 
	"Mother",
	"Brother",
	"Sister",
	"Husband", 
	"Wife", 
	"Friend", 
	"Uncle", 
	"Aunt", 
	"Grandfather",
	"Grandmother", 
	"Niece", 
	"Nephew", 
	"Girlfriend", 
	"Boyfriend", 
	"Spouse", 
	"Partner",
	"Myself",
	"Other"]. each do |r|
 	Relationshipdesc.find_or_create_by_description(r)
 end

User.find_or_create_by_email(
	:email => "familytalesuser2@gmail.com",
	:password => "explorer123",
	:password_confirmation => "explorer123",
  	:first_name => "Explorer",
  	:last_name => "User")

[	
	"What do you remember most about the arrival of @profile.first_name?",
	"What was @profile.first_name like as a baby?",
	"What pet name do you have for @profile.first_name, and how did it came to be?",
	"A story you remember from the earliest years of @profile.first_name.",
	"Similarities between @profile.first_name and you.",
	"Things @profile.first_name seem to have inherited from other family members.",
	"Something @profile.first_name may have inherited from you.",
	"Some special qualities you see in @profile.first_name.",
	"Some of our favourite activities you do together with @profile.first_name.",
	"Things @profile.first_name do that make you smile or laugh.",
	"Things @profile.first_name do that make you proud.",
	"Your hopes and dreams for @profile.first_name future.",
	"A list of names you considered for @profile.first_name.",
	"How has @profile.first_name life changed after @profile.first_name was born?",
	"What's one advice you'd like to give to @profile.first_name when @profile.first_name grows up?",
	"Funny and embarrassing moments you had about @profile.first_name.",
	"A list of places you hope to take @profile.first_name someday and why?",
	"A list of books and movies @profile.first_name should experience",
	"A list of advice for @profile.first_name future",
	"What were @profile.first_name first words?",
	"A list of things @profile.first_name pretended to do and to be",
	"Funny things @profile.first_name said.",
	"Memorable questions @profile.first_name asked.",
	"How did you celebrate @profile.first_name birthdays?",
	"A list of @profile.first_name friends (real and imaginary) over the years",
	"What were @profile.first_name favourite toys and things?",
	"TV shows and characters @profile.first_name loved",
	"A list of @profile.first_name favourite book",
	"Songs @profile.first_name loved as a baby/child",
	"Things that @profile.first_name destroyed as a kid",
	"A list of foods @profile.first_name loved and hated",
	"Costumes and cute outfits @profile.first_name wore",
	"Memorable things we did together",
	"Presents @profile.first_name made and gave to us",
	"The biggest scare @profile.first_name gave us was when...",
	"Some @profile.first_name proudest accomplishments were...",
	"The first Haircut @profile.first_name",
	"First babysitter of @profile.first_name",
	"First pet of @profile.first_name",
	"First performance @profile.first_name",
	"First School of @profile.first_name",
	"First teacher of @profile.first_name",
	"Favourite teacher of @profile.first_name",
	"Did @profile.first_name take music or any other lessons?",
	"What was @profile.first_name favourite food?",
	"What was @profile.first_name favourite candy or ice cream?",
	"What was @profile.first_name favourite animal?",
	"What vacations did we take @profile.first_name to..."
	]. each do |q|
	StorybookQuestion.find_or_create_by_question(q)
end

