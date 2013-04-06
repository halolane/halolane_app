require 'spec_helper'

describe Invitation do
  let (:user) { FactoryGirl.create(:user) }
  let (:profile) { FactoryGirl.create(:profile) }

  before do
  	@invitation = user.invitations.build(profile_id: profile.id)
  	@invitation.recipient_email = "test@example.com"
  end

  subject { @invitation }

  it { should respond_to(:profile_id) }
  it { should respond_to(:sender_id) }
  it { should respond_to(:recipient_email) }
  it { should respond_to(:token) }
  it { should respond_to(:sent_at) }
  it { should respond_to(:user) }
  it { should respond_to(:profile) }


end
