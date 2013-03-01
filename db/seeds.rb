# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

[	"Friend", 
	"Father", 
	"Mother", 
	"Husband", 
	"Wife", 
	"Son", 
	"Daughter", 
	"Uncle", 
	"Aunt", 
	"Grandfather",
	"Grandmother", 
	"Niece", 
	"Nephew", 
	"Girlfriend", 
	"Boyfriend", 
	"Spouse", 
	"Partner"]. each do |r|
 	Relationshipdesc.find_or_create_by_description(r)
 end


[	"What is one piece of advice you got from @profile.first_name?",
	"What is your favorite joke you heard from @profile.first_name?",
	"If @profile.first_name was an animal, what would she be and why?",
	"What sort of gift would you get @profile.first_name for their birthday?", 
	"How was traveling with @profile.first_name?", 
	"If @profile.first_name was an actor, what sort of movies would she play in?",
	"If you could tell @profile.first_name one final thing, what would it be? ",
	"What five words would you use to describe @profile.first_name?",
	"What did @profile.first_name teach you about life?",
	"What did you learn about yourself through @profile.first_name?",
	"What was the best piece of advice that @profile.first_name gave you?",
	"What did @profile.first_name inspire you to do?",
	"What did @profile.first_name mean to you?",
	"What was one funny memory you have of @profile.first_name?",
	"What would you want others to know about @profile.first_name?",
	"What would @profile.first_name do to cheer you up?", 
	"What was @profile.first_name's favorite dish to cook?",
	"What is @profile.first_name's favorite thing to do?",
	"What would say are @profile.first_name's values?",
	"What makes @profile.first_name happy?",
	"Who is @profile.first_name's biggest influence and why?",
	"What is one thing that you are proud of @profile.first_name for?",
	"What motto do you think @profile.first_name lived her life by? ",
	"How did you first meet @profile.first_name? ",
	"What did @profile.first_name take inspiration from? ",
	"What physical feature best defines @profile.first_name? ",
	"What is your earliest memory of @profile.first_name? ",
	"What would @profile.first_name think of the kids these days? ",
	"What is the craziest thing @profile.first_name has ever done? ",
	"If @profile.first_name had won the lottery, what would she buy? ",
	"Was @profile.first_name a morning or an evening person? ",
	"Did @profile.first_name enjoy traveling? ",
	"What sports did @profile.first_name like? ",
	"What side of the political spectrum would @profile.first_name lie on?",
	"What food did @profile.first_name hate the most? ",
	"Is there anything @profile.first_name couldn't say no to? ",
	"What is one thing @profile.first_name couldn't live without? ",
	"Which celebrity would @profile.first_name be mistaken for? ",
	"What adjectives would you use to describe @profile.first_name? Why?",
	"Describe a moment when @profile.first_name surprised you.",
	"What would @profile.first_name's ideal job be? Why?",
	"What is @profile.first_name's definition of happiness?",
	"What is your most memorable travel experience with @profile.first_name?",
	"What is your most memorable dining experience with @profile.first_name?",
	"How do you think people should remember @profile.first_name?",
	"If @profile.first_name could have one superpower, what would it be and why?"
	]. each do |q|
	StorybookQuestion.find_or_create_by_question(q)
end

