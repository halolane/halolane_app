require 'spec_helper'

describe Profile do

  before do
    @profile = Profile.new(first_name: "Test", last_name: "User", 
                     birthday: 70.years.ago , 
                     deathday: Date.today ,
                     url: "testuser",
                     privacy: 0 )
  end
  
  subject { @profile }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:birthday) }
  it { should respond_to(:deathday) }
  it { should respond_to(:privacy) }
  it { should respond_to(:relationships) }
  it { should respond_to(:users) }
  it { should respond_to(:memories) }
  

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

  describe "memory associations" do

    before do 
      @profile.save
      FactoryGirl.create(:memory, profile: @profile)
    end

    it "should destroy associated memories" do
      memories = @profile.memories.dup
      @profile.destroy
      memories.should_not be_empty
      memories.each do |memory|
        Memory.find_by_id(@profile.id).should be_nil
      end
    end
  end

  describe "relationship associations" do

    before do 
      @profile.save
      FactoryGirl.create(:memory, profile: @profile)
    end

    it "should destroy associated memories" do
      memories = @profile.memories.dup
      @profile.destroy
      memories.should_not be_empty
      memories.each do |memory|
        Memory.find_by_id(@profile.id).should be_nil
      end
    end
  end

  describe "contributors" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      @profile.save
      user.contribute!(@profile)
    end

    it { should be_contributor(user) }
    its(:users) { should include(user) }

    describe "by users" do
      subject { user } 
      its(:profiles) { should include(@profile) }
    end

    describe "and noncontributors" do
      before { user.uncontribute!(@profile) }

      it { should_not be_contributor(user) }

      its(:users) { should_not include(@user) }
    end
  end
end
