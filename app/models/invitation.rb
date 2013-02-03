class Invitation < ActiveRecord::Base
  # attr_accessible :sender_id, :profile_id, :recipient_email, :token, :sent_at
  attr_accessible :profile_id 

  belongs_to :profile
  belongs_to :user

  before_create :generate_token

  validate :recipient_email, presence: true
  validate :recipient_is_not_registered

  def recipient_registered?(email)
  	User.exists?(:email => email )
  end

  private

    def recipient_is_not_registered
      errors.add :recipient_email, "is already registered" if User.find_by_email(recipient_email)
    end

	  def generate_token
	  	self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
	  end
end
