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

plan_list = [
	["Free", 0],
	["Basic", 4.99],
	["Pro", 9.99]
]
plan_list. each do |name, price|
 	Plan.find_or_create_by_price(name: name, price: price )
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
	"What was the last thing that @profile.first_name did that surprised you?",
"What was the last thing that @profile.first_name did that scared you?",
"What was the last thing that @profile.first_name did that made you smile?",
"What was the last thing that @profile.first_name did that made you laugh?",
"What was the last thing that @profile.first_name did that made you happy?",
"What was the last thing that @profile.first_name did that made you proud?",
"What do you remember most about @profile.first_name\'s arrival?",
"What is @profile.first_name like as a baby?",
"What similarities do you have with @profile.first_name?",
"What are things @profile.first_name inherited from you or your family members?",
"What are special qualities you see in @profile.first_name?",
"What are favourite activities you do with @profile.first_name right now?",
"What are things that make @profile.first_name smile or laugh?",
"What are things @profile.first_name does that make you proud?",
"What are your hopes and dreams for @profile.first_name\'s future?",
"What are some names you considered for @profile.first_name?",
"How has your life changed after @profile.first_name was born?",
"What are some parenting ideas you tried with @profile.first_name?",
"What is a funny moment you had with @profile.first_name?",
"What are a list of places you hope to take @profile.first_name someday and why?",
"What are a list of movies you would like to show @profile.first_name someday and why?",
"What are a list of books you would like to read to @profile.first_name someday and why?",
"What are some advice you have for @profile.first_name when @profile.first_name grows up?",
"What are @profile.first_name\'s favourite toys and things?",
"What are TV shows and characters @profile.first_name love right now?",
"What are @profile.first_name\'s favourite children\'s books?",
"What are some songs that @profile.first_name\'s love?",
"What are some things that @profile.first_name destroyed as a child?",
"What are some costumes and cute outfits @profile.first_name wore?",
"What are memorable things you did with @profile.first_name?",
"What is the biggest scare @profile.first_name gave you and why?",
"What is @profile.first_name favourite food?",
"What was most memorable about @profile.first_name first bath?",
"What are some memorable prenatal doctor appointments before @profile.first_name was born?",
"What are some of your wishes for @profile.first_name when @profile.first_name grows up?",
"What are some funny actions that @profile.first_name did that made you smile?",
"What are a list of adjectives that best describe @profile.first_name?",
"What are a list of books or movies @profile.first_name should experience?",
"What are changes you hope the world makes in @profile.first_name\'s lifetime?",
"What are things you look forward to doing with @profile.first_name?",
"What are cute things you did with @profile.first_name?",
"What are your sweetest moments with @profile.first_name?",
"What are a list of things that got @profile.first_name in trouble for?",
"What are a list of funny and embarrassing moments with @profile.first_name?",
"What are a list of advices you received as a parent?",
"What are a list of parental magic powers you wish you had when raising @profile.first_name?",
"Who are significant people in your life when @profile.first_name was born?",
"What are some of the new things you bought for @profile.first_name\'s arrival?",
"What are some things you were given as gifts for @profile.first_name\'s arrival?",
"What are quotes you live by that you want to share to @profile.first_name?",
"What are life lessons you learned that you want to share to @profile.first_name?",
"Who are some role models that you want to share to @profile.first_name when @profile.first_name grows up?",
"What advice would you give to @profile.first_name on love?",
"What advice would you give to @profile.first_name on life?",
"What advice would you give to @profile.first_name on faith?",
"What advice would you give to @profile.first_name on family?",
"What advice would you give to @profile.first_name on dating?",
"What advice would you give to @profile.first_name on staying healthy?",
"What advice would you give to @profile.first_name on healthy and enduring relationships?",
"What advice would you give to @profile.first_name on making friends?",
"What advice would you give to @profile.first_name on happiness?",
"What advice would you give to @profile.first_name on education?",
"What is the most important thing you want to teach @profile.first_name?",
"Does parenting @profile.first_name make you see your own parents in a different light?",
"Do you worry about @profile.first_name growing up? Why?",
"Do you have nicknames for @profile.first_name? Where did they come from?",
"What do you feel when you look at @profile.first_name?",
"What are your proudest moments with @profile.first_name?",
"What makes @profile.first_name laugh out loud?",
"How do you cheer up @profile.first_name?",
"What are foods that @profile.first_name can\'t live without?",
"What values do you want to pass on to @profile.first_name?",
"What are your most vivid memories of @profile.first_name?",
"What kind of a child is @profile.first_name? Shy or sociable? Thoughtful or lively?",
"What are your happiest memories with @profile.first_name so far?",
"What are cravings you or your partner had during the pregnancy?",
"What are songs and lullabies that @profile.first_name loves?",
"What are games that @profile.first_name love to play?",
"What is @profile.first_name crazy about?",
"What are @profile.first_name\'s favorite activities at home?",
"What are bath time games @profile.first_name enjoyed?",
"What are bath time toys @profile.first_name love to play with?",
"What is @profile.first_name\'s bed time routine?",
"Where was @profile.first_name\'s first outing in a stroller?", 
"Who were the first people who visited @profile.first_name?", "What were nice things they said?",
"What are foods that @profile.first_name hate?",
"What is @profile.first_name\'s favorite word?",
"What is the best way to soothe @profile.first_name?",
"What is @profile.first_name\'s favorite stuffed animal right now?",
"What is @profile.first_name\'s favorite toy right now?",
"What is @profile.first_name\'s favorite candy or treat?",
"What is @profile.first_name\'s favorite animal?",
"What are @profile.first_name\'s favorite songs and lullabies?",
"What are @profile.first_name\'s favorite foods?",
"Who are important world leaders when @profile.first_name was born?",
"What are popular movies when @profile.first_name was born?",
"What are popular songs when @profile.first_name was born?",
"What are leading news stories on the year that @profile.first_name was born?",
"What are some of @profile.first_name\'s proudest accomplishments?",
"What are funny faces you make at @profile.first_name?", 
"What are things @profile.first_name does that make you smile or laugh?"
	]. each do |q|
	StorybookQuestion.find_or_create_by_question(q)
end

