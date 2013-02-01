require 'spec_helper'

describe "Profile pages" do

  let (:user) { FactoryGirl.create(:user) }
  let (:user2) { FactoryGirl.create(:user) }

  
  before do  
    user.save
    sign_in user

    @profile = Profile.new(first_name: "Test", last_name: "User", 
                     birthday: 70.years.ago , 
                     deathday: Date.today ,
                     privacy: 0 )
    visit createstorybook_path
  end

  describe "createstorybook" do

    let(:submit) { "Create the life storybook" }

    describe "with invalid information" do
      it "should not create a storybook" do
        expect { click_button submit }.not_to change(Profile, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "First name",   with: "Example"
        fill_in "Last name",   	with: "User"
        select '1', :from => "profile_birthday_3i"
        select 'January', :from => "profile_birthday_2i"
        select '2012', :from => "profile_birthday_1i"
        select '1', :from => "profile_deathday_3i"
        select 'January', :from => "profile_deathday_2i"
        select '2013', :from => "profile_deathday_1i"
        select 'Friend' , :from => "relationship_description"
      end

      it "should create a profile" do
        expect { click_button submit }.to change(Profile, :count).by(1)
      end

      it "should make relationship" do
        expect { click_button submit }.to change(Relationship, :count).by(1)
      end
    end

    describe "with valid information should create relationship" do
      before do
        fill_in "First name",   with: "Example"
        fill_in "Last name",    with: "User"
        select '1', :from => "profile_birthday_3i"
        select 'January', :from => "profile_birthday_2i"
        select '2012', :from => "profile_birthday_1i"
        select '1', :from => "profile_deathday_3i"
        select 'January', :from => "profile_deathday_2i"
        select '2013', :from => "profile_deathday_1i"
        select 'Friend' , :from => "relationship_description"
        click_button submit 
      end

      it "with user id" do 
        Relationship.find_by_user_id(user.id).should_not be_nil 
      end

      it "with user id as admin" do
        Relationship.find_by_user_id_and_profile_id(user.id, Profile.last.id).profile_admin == true
      end
    end
  end

  describe "when related user views profile that is" do
    describe "set to public" do
      before do 
        @profile.save
        user.contribute!(@profile)
        visit '/profiles/1' 
      end
      it { should_not have_content('not authorized') }
    end

    describe "set to privacy setting level 1" do
      before do 
        @profile.privacy = 1
        @profile.save
        user.contribute!(@profile)
        visit '/profiles/1'
      end
      it { should_not have_content('not authorized') }
    end

    describe "set to privacy setting level 2" do
      before do 
        @profile.privacy = 2
        @profile.save
        user.contribute!(@profile)
        visit '/profiles/1'
      end
      it { page.should_not have_content('not authorized') }
    end
  end

  describe "when logged in user views profile that is" do
    before do
      sign_in user2
    end
    describe "set to public" do
      before do 
        @profile.save
        visit '/profiles/1' 
      end
      it { page.should_not have_content('not authorized') }
    end

    describe "set to privacy setting level 1" do
      before do 
        @profile.privacy = 1
        @profile.save
        visit '/profiles/1'
      end
      it { page.should_not have_content('not authorized') }
    end

    describe "set to privacy setting level 2" do
      before do 
        @profile.privacy = 2
        @profile.save
        visit '/profiles/1'
      end
      it { page.should have_content('not authorized') }
    end
  end
end