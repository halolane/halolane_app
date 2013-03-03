require 'spec_helper'

describe "Static Pages" do

  subject { page }

  describe "home page" do
    before { visit root_url }

    describe "with invalid information" do
      before { click_button "Get Started" }

      it { should have_selector('div.alert.alert-error') }
    end

    describe "with invalid information to test profile and user count" do
  
      it "should not create a profile" do
        expect { click_button "Get Started" }.not_to change(Profile, :count).by(1)
      end

      it "should not create a user" do
        expect { click_button "Get Started" }.not_to change(User, :count).by(1)
      end
    end

    describe "with valid information" do
      let(:new_fname)  { "New" }
      let(:new_lname)  { "Name" }
      let(:user_fname)  { "Test" }
      let(:User_lname)  { "Dummy" }
      let(:new_email) { "new@example.com" }
      let(:new_password) { "foobar" }

      before do
        fill_in "user_profile_first_name",  with: new_fname
        fill_in "user_profile_last_name",   with: new_lname
        fill_in "user_first_name",  with: user_fname
        fill_in "user_last_name",  with: user_fname
        fill_in "user_email",               with: new_email
        fill_in "user_password",            with: new_password    
        click_button "Get Started"
      end
      it { should have_content('Welcome') }
      it { should_not have_link('Sign in', href: signin_path) }
      
    end

    describe "with valid information to test profile and user count" do
      let(:new_fname)  { "New" }
      let(:new_lname)  { "Name" }
      let(:user_fname)  { "Test" }
      let(:User_lname)  { "Dummy" }
      let(:new_email) { "new@example.com" }
      let(:new_password) { "foobar" }


      before do
        fill_in "user_profile_first_name",  with: new_fname
        fill_in "user_profile_last_name",   with: new_lname
        fill_in "user_first_name",  with: user_fname
        fill_in "user_last_name",  with: user_fname
        fill_in "user_email",               with: new_email
        fill_in "user_password",            with: new_password    
      end

      it "should create a profile" do
        expect { click_button "Get Started" }.to change(Profile, :count).by(1)
      end

      it "should create a user" do
        expect { click_button "Get Started" }.to change(User, :count).by(1)
      end
    end
  end
end