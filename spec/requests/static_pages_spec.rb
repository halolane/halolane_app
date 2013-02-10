require 'spec_helper'

describe "Static Pages" do

  subject { page }

  describe "home page" do
    before { visit root_url }

    describe "with invalid information" do
      before { click_button "Create Your Life Storybook" }

      it { should have_selector('div.alert.alert-error') }
    end

    describe "with invalid information to test profile and user count" do
  
      it "should not create a profile" do
        expect { click_button "Create Your Life Storybook" }.not_to change(Profile, :count).by(1)
      end

      it "should not create a user" do
        expect { click_button "Create Your Life Storybook" }.not_to change(User, :count).by(1)
      end
    end

    describe "with valid information" do
      let(:new_fname)  { "New" }
      let(:new_lname)  { "Name" }
      let(:new_email) { "new@example.com" }

      before do
        fill_in "user_profile_first_name",             with: new_fname
        fill_in "user_profile_last_name",             with: new_lname
        fill_in "user_email",            with: new_email
        click_button "Create Your Life Storybook"
      end

      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
      it { should have_content('Welcome') }
    end

    describe "with valid information to test profile and user count" do
      let(:new_fname)  { "New" }
      let(:new_lname)  { "Name" }
      let(:new_email) { "new@example.com" }

      before do
        fill_in "user_profile_first_name",             with: new_fname
        fill_in "user_profile_last_name",             with: new_lname
        fill_in "user_email",            with: new_email
        
      end

      it "should create a profile" do
        expect { click_button "Create Your Life Storybook" }.to change(Profile, :count).by(1)
      end

      it "should create a user" do
        expect { click_button "Create Your Life Storybook" }.to change(User, :count).by(1)
      end
    end
  end
end