require 'spec_helper'

describe "Profile pages" do

  describe "createstorybook" do

  let (:user) { FactoryGirl.create(:user) }
  let (:profile) { FactoryGirl.create(:profile) }
  let (:relationship) { user.profiles.build(profile_id: profile.id)}

  before do  
    user.save
    profile.save
    sign_in user
    visit createstorybook_path
  end


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
      end

      it "should create a profile" do
        expect { click_button submit }.to change(Profile, :count).by(1)
      end
    end
  end

end
