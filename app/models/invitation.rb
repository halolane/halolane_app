class Invitation < ActiveRecord::Base
  # attr_accessible :sender_id, :profile_id, :recipient_email, :token, :sent_at
  attr_accessible :profile_id, :bookshelf_id, :invite_type

  belongs_to :profile
  belongs_to :user
  belongs_to :bookshelf

  before_create :generate_token

  before_save { |invitation| invitation.recipient_email = recipient_email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :recipient_email, presence: true, 
            format: { with: VALID_EMAIL_REGEX }

  validate :recipient_email, presence: true

  def recipient_registered?(email)
  	User.exists?(:email => email )
  end

  private

	  def generate_token
	  	self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
	  end
end
