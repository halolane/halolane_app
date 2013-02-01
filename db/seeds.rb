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


