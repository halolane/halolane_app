require 'spec_helper'

describe "Memory pages" do

  subject { page }

  let (:user) { FactoryGirl.create(:user) }
  let (:profile) { FactoryGirl.create(:profile) }
  let (:relationship) { user.profiles.build(profile_id: profile.id)}

  before do 
    user.save
    profile.save
    sign_in user
  end

  describe "memory creation" do
    before { visit '/profiles/1' }

    describe "with invalid information" do

      it "should not create a memory" do
        expect { click_button "Post" }.not_to change(Memory, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content("Content can't be blank") } 
      end
    end

    #describe "with valid information" do

    #  before { fill_in 'memory_content', with: "Lorem ipsum" }
    #  it "should create a memory" do
    #    expect { click_button "Post" }.to change(Memory, :count).by(1)
    #  end
    #end
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
end