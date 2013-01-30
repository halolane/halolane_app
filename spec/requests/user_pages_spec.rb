require 'spec_helper'

describe "User pages" do

  subject { page }

   describe "index" do

    let(:user) { FactoryGirl.create(:user) }

    before(:each) do
      sign_in user
      visit users_path
    end

    it { should have_selector('title', text: 'All users') }
    it { should have_selector('h1',    text: 'All users') }

    describe "delete links" do

      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect { click_link('delete') }.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }
    
    # Making sure that invalid data doesn't put into database
    # test by making sure User count doesn't incremement
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    # Valid information - It should go increment User count by one
    describe "with valid information" do
      before do
        fill_in "First name",         with: "New"
        fill_in "Last name",         with: "User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email('user@example.com') }

        #it { should have_selector('title', text: user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
        it { should have_link('Sign out') }
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_fname)  { "New" }
      let(:new_lname)  { "Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "First name",             with: new_fname
        fill_in "First name",             with: new_lname
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end

      #it { should have_selector('title', text: new_fname) + " " + new_lname }
      #it { should have_link('Sign out', href: signout_path) }
      it { should have_selector('div.alert.alert-success') }
      
      # specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email }
    end
  end
end