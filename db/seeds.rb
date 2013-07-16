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

template_list = [
	[1, "Six tiles, two oversized", 1297, 680],
	[2, "title page", 1297, 680],
	[3, "Four tiles", 1297, 680]
]
template_list. each do |template_num, description, width, height|
 	Template.find_or_create_by_template_num(template_num: template_num, description: description, width: width, height: height )
end

tile_list = [
	[1, 1, 1, 1, 3, 2, 460, 300],
	[1, 2, 1, 4, 2, 2, 300, 300],
	[1, 3, 1, 6, 2, 2, 300, 300],
	[1, 4, 3, 1, 2, 2, 300, 300],
	[1, 5, 3, 3, 3, 2, 460, 300],
	[1, 6, 3, 5, 2, 2, 300, 300],
	[2, 1, 1, 1, 3, 3, 460, 460],
	[2, 2, 1, 4, 4, 1, 620, 140],
	[2, 3, 2, 4, 2, 3, 300, 460],
	[2, 4, 4, 1, 3, 1, 460, 140],
	[2, 5, 2, 6, 2, 3, 300, 460],
	[3, 1, 1, 1, 3, 2, 620, 300],
	[3, 2, 1, 4, 4, 2, 620, 300],
	[3, 3, 3, 3, 5, 2, 780, 300],
	[3, 4, 3, 1, 2, 2, 300, 300]
]

tile_list. each do |template_num, tile_num, datarow, datacol, datasizex, datasizey, width, height|
	t = Template.find_by_template_num(template_num)
 	t.createtile!(tile_num, datarow, datacol, datasizex, datasizey, width, height )
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
	"What's one advice you\'d like to give to @profile.first_name when @profile.first_name grows up?",
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

question_list = [
	["@profile.first_name's cover picture", "title", 1],
	["What names did you consider for the baby and why did you choose @profile.first_name?", "title", 2],
	["A picture of mommy!", "title", 3],
	["Welcome to the world! Place of birth? Time of birth? Weight?", "title", 4],
	["A picture of daddy!", "title", 5],
	["Place ultrasound picture here", "pregnancy", ""],
	["Belly photo", "pregnancy", ""],
	["Place baby shower picture here", "pregnancy", ""],
	["Finished the nursery!", "pregnancy", ""],
	["Went into labour!", "pregnancy", ""],
	["Parents to Be!", "pregnancy", ""],
	["What is @profile.first_name's favourite food right now?", "1mt", ""],
	["Nursery Rhymes and music that you played for @profile.first_name at this stage?", "1mt", ""],
	["@profile.first_name is discovering their fingers and toes for the first time. Take a picture of @profile.first_name's little feet!", "1mt", ""],
	["Does your baby suck on her thumbs? Take a picture!", "1mt", ""],
	["What I remember most about your arrival", "1mt", ""],
	["Your baby's first real smile. Take a picture!", "2mt", ""],
	["A video of your baby laughing", "2mt", ""],
	["Can your baby prop themselves up on all fours? Take a picture!", "2mt", ""],
	["What are @profile.first_name's favourite toys at the moment?", "2mt", ""],
	["Pet name I have for you, and how it came to be", "2mt", ""],
	["Encourage her hand movements by holding toys around for her to hold. If she can do it at this stage, take a picture!", "3mt", ""],
	["Does @profile.first_name still keep you up late at night? When was the latest time you've stayed up to take care of @profile.first_name", "3mt", ""],
	["@profile.first_name can recognize his/her parents now. Take a picture of the both of you!", "3mt", ""],
	["What books are you reading to @profile.first_name now? Which ones are her favourite?", "3mt", ""],
	["Things you do that make me smile or laugh:", "3mt", ""],
	["What is @profile.first_name's favourite food now?", "4mt", ""],
	["Record a video of @profile.first_name rolling over.", "4mt", ""],
	["Does @profile.first_name have a rattle? Take a picture!", "4mt", ""],
	["Can you tell if @profile.first_name has a favourite colour (or colours)? What is it?", "4mt", ""],
	["Funny and embarrassing moments I had as a parent so far", "4mt", ""],
	["Take a picture of the first time @profile.first_name sits up on their own!", "5mt", ""],
	["Take a video of @profile.first_name blowing a raspberry or making bubbles.", "5mt", ""],
	["Does she/he play little games with you to see how you react? What  does she/he do?", "5mt", ""],
	["Funny faces you make at her/him.", "5mt", ""],
	["Picture of @profile.first_name hugging or kissing you.", "5mt", ""],
	["@profile.first_name's favourite toy right now.", "6mt", ""],
	["Diaper change! Accomplishment at this stage since he/she can't seem to sit still!", "6mt", ""],
	["What are games you play with @profile.first_name right now?", "6mt", ""],
	["Any syllables @profile.first_name likes to say?", "6mt", ""],
	["@profile.first_name's favourite toy right now?", "6mt", ""],
	["What books are you reading to @profile.first_name now?", "6mt", ""],
	["Video of @profile.first_name bouncing.", "7mt", ""],
	["Take a picture of @profile.first_name first teeth!", "7mt", ""],
	["Picture of @profile.first_name playing with the telephone like a toy!", "7mt", ""],
	["Picture of (baby name) in her crib, sleeping by herself. ", "7mt", ""],
	["What is (baby name)'s favourite toy right now?", "7mt", ""],
	["Picture of @profile.first_name sitting or standing up by themselves", "8mt", ""],
	["Video of @profile.first_name crawling", "8mt", ""],
	["Video or picture of @profile.first_name blowing a kiss", "8mt", ""],
	["@profile.first_name's favourite toy now?", "8mt", ""],
	["Similarities between you and me:", "8mt", ""],
	["@profile.first_name's first step!", "9mt", ""],
	["@profile.first_name's  favourite toy now?", "9mt", ""],
	["Picture of @profile.first_name in his car seat or stroller!", "9mt", ""],
	["Things you seem to have inherited from other family members", "9mt", ""],
	["Things you do that make me smile or laugh", "9mt", ""],
	["Picture of @profile.first_name's first shoe?", "10mt", ""],
	["What is @profile.first_name's personality like now?", "10mt", ""],
	["Words/phrases @profile.first_name seems to understand.", "10mt", ""],
	["@profile.first_name's first word?", "10mt", ""],
	["My hopes and dreams for your future", "10mt", ""],
	["@profile.first_name's eating her/his favourite food by herself/himself!", "11mt", ""],
	["@profile.first_name's favourite books now.", "11mt", ""],
	["@profile.first_name's favourite stuffed animal or blankie.", "11mt", ""],
	["Funny and embarrassing moments I had as a parent so far.", "11mt", ""],
	["Your favourite fictional character right now.", "11mt", ""],
	["Video of @profile.first_name's first steps by himself/herself", "12mt", ""],
	["@profile.first_name's favourite toy now?", "12mt", ""],
	["What do you do to put @profile.first_name to sleep now?", "12mt", ""],
	["@profile.first_name first words besides ma and da/pa", "12mt", ""],
	["How my life has changed since you were born!", "12mt", ""]
]

	question_list. each do |question, subtype, tile_num|
	 	StorybookQuestion.find_or_create_by_question_and_subtype_and_tile_num(question,subtype,tile_num)
	end
end

