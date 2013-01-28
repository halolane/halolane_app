require 'spec_helper'

describe Relationship do
  let (:user) { FactoryGirl.create(:user) }
  let (:profile) { FactoryGirl.create(:profile) }
  let (:relationship) { user.relationships.build(profile_id: profile.id)}

  subject { relationship }

  it { should be_valid }

  describe "accessible attributes" do
  	it "should not allow acces to user_id" do
  		expect do
  			Relationship.new(user_id: user.id)
  		end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
  	end
  end

  describe "relationship methods" do
  	it { should respond_to(:user) }
  	it { should respond_to(:profile) }
  	its(:user) { should == user }
  	its(:profile) { should == profile }
  end

  describe "when user id is not present" do
  	before { relationship.user_id = nil }
  	it { should_not be_valid }
  end

  describe "when profile id is not present" do
  	before { relationship.profile_id = nil }
  	it { should_not be_valid }
  end
end
