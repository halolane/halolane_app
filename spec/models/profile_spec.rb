require 'spec_helper'

describe Profile do

	let(:user) { FactoryGirl.create(:user) }
  before do
    @profile = Profile.new(first_name: "Ramli", last_name: "Solidum", 
                     birthday: 70.years.ago , 
                     deathday: Date.today,
                     privacy: 0)
  end

  subject { @profile }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:birthday) }
  it { should respond_to(:deathday) }
  it { should respond_to(:privacy) }
  

  it { should be_valid }

  describe "when first name is not present" do
  	before { @profile.first_name = " " }
  	it { should_not be_valid }
  end

  describe "when first name is too long" do
    before { @profile.first_name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when last name is not present" do
  	before { @profile.last_name = " " }
  	it { should_not be_valid }
  end

  describe "when last name is too long" do
    before { @profile.last_name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when death_day is before birth_day" do
  	before { @profile.deathday = @profile.birthday.years_ago(1) }
  	it { should_not be_valid }
  end

  describe "when death_day is on birth_day" do
  	before { @profile.deathday = @profile.birthday }
  	it { should_not be_valid }
  end

  describe "when death_day is after birth_day" do
  	before { @profile.deathday = @profile.birthday.years_since(1) }
  	it { should be_valid }
  end

  describe "when death day or birthday is not present" do
  	before { @profile.deathday = @profile.birthday = nil }
  	it { should_not be_valid }
  end

  describe "when birthday or death day is after today" do
  	before do 
  	  @profile.birthday = Date.tomorrow 
  	  @profile.deathday = Date.tomorrow.advance(:days => 1 ) 
  	end
  	it { should_not be_valid }
  end

  describe "when privacy setting is blank" do
  	before { @profile.privacy = nil }
  	it { should_not be_valid }
  end

  describe "when privacy setting is a string" do
  	before { @profile.privacy = "a" }
  	it { should_not be_valid }
  end

  describe "when privacy setting is a negative number" do
  	before { @profile.privacy = -1 }
  	it { should_not be_valid }
  end

  describe "when privacy setting is a decimal number" do
  	before { @profile.privacy = 1.1 }
  	it { should_not be_valid }
  end


end
