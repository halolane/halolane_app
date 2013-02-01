require 'spec_helper'

describe "Memory pages" do

  subject { page }
  let (:user) { FactoryGirl.create(:user) }
  let (:user2) { FactoryGirl.create(:user) }
  let(:submit) { "Post" }

  before do 
    user.save
    user2.save
    @profile = Profile.new(first_name: "Test", last_name: "User", 
                     birthday: 70.years.ago , 
                     deathday: Date.today ,
                     privacy: 0 )
    sign_in user
  end

  describe "memory creation" do
    before do
      @profile.save
      user.contribute!(@profile)
      visit '/profiles/1' 
    end

    describe "with invalid information" do

      it "should not create a memory" do
        expect { click_button "Post" }.not_to change(Memory, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content("Content can't be blank") } 
      end
    end

    describe "with valid information" do

      before { fill_in 'memory_content', with: "Lorem ipsum" }
      it "should create a memory" do
        expect { click_button "Post" }.to change(Memory, :count).by(1)
      end
    end
  end

  describe "memory destruction" do
    before { FactoryGirl.create(:memory, user: user) }

    describe "as correct user" do
      before { visit root_path }

      # DO THIS WHEN YOU HAVE CREATED THE PROFILE MODEL
      # it "should delete a micropost" do
      #  expect { click_link "delete" }.to change(Memory, :count).by(-1)
      # end
    end
  end

  # Test to create memory by related user
  describe "when creating memory by related user for profile that is" do
    describe "set to public should create memory" do
      before do 
        @profile.save
        user.contribute!(@profile)
        visit '/profiles/1' 
        fill_in 'memory_content', with: "Lorem ipsum"
      end
      it { expect { click_button "Post" }.to change(Memory, :count) }
    end

    describe "set to privacy setting level 1 should create memory" do
      before do 
        @profile.privacy = 1
        @profile.save
        user.contribute!(@profile)
        visit '/profiles/1' 
        fill_in 'memory_content', with: "Lorem ipsum"
      end
      it { expect { click_button "Post" }.to change(Memory, :count) }
    end

    describe "set to privacy setting level 2 should create memory" do
      before do 
        @profile.privacy = 2
        @profile.save
        user.contribute!(@profile)
        visit '/profiles/1' 
        fill_in 'memory_content', with: "Lorem ipsum"
      end
      it { expect { click_button "Post" }.to change(Memory, :count) }
    end
  end

  # Test to create memory by unrelated user
  describe "when creating memory by unrelated user for profile that is" do
    before { sign_in user2 }
    describe "set to public should create" do
      before do 
        @profile.save
        visit '/profiles/1' 
        fill_in 'memory_content', with: "Lorem ipsum"
      end
      it { expect { click_button "Post" }.to change(Memory, :count) }
    end

    describe "set to privacy setting level 1 should not create memory" do
      before do 
        @profile.privacy = 1
        @profile.save
        visit '/profiles/1' 
        fill_in 'memory_content', with: "Lorem ipsum"
      end
      it { expect { click_button "Post" }.not_to change(Memory, :count) }
    end

    describe "set to privacy setting level 2 should not create memory" do
      before do 
        @profile.privacy = 2
        @profile.save
        user.contribute!(@profile)
        visit '/profiles/1' 
      end
      it { page.should have_content('not authorized') }
    end
  end
end