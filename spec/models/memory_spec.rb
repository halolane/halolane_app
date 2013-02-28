require 'spec_helper'

describe Memory do

  let (:user) { FactoryGirl.create(:user) }
  let (:profile) { FactoryGirl.create(:profile) }
  let (:relationship) { user.relationships.build(profile_id: profile.id)}

  before do
    @memory = user.memories.build(content: "Lorem ipsum") 
    @memory.profile_id = profile.id
  end

  subject { @memory }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { should respond_to(:profile_id) }
  it { should respond_to(:profile) }

  its(:user) { should == user }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Memory.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when user_id is not present" do
    before { @memory.user_id = nil }
    it { should_not be_valid }
  end

  describe "when profile_id is not present" do
    before { @memory.profile_id = nil }
    it { should_not be_valid }
  end

  describe "when blank content" do
  	before { @memory.content = " " } 
  	it { should_not be_valid }
  end
  
  describe "with content that is too long" do
  	before { @memory.content = "a" * 1001 }
  	it { should_not be_valid }
  end
end