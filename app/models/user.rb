# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation
  has_secure_password
  has_many :invitations, dependent: :destroy, :class_name => 'Invitation', :foreign_key => 'sender_id'
  has_many :memories, dependent: :destroy
  has_many :relationships, dependent: :destroy
  has_many :profiles, through: :relationships
  has_many :profiles_with_relationships, :through => :relationships, :source => :profile
  has_many :bookshelves, dependent: :destroy
  has_many :authentications, dependent: :destroy
  has_many :likememories, dependent: :destroy
  has_many :useractionlogs, dependent: :destroy

  before_save { |user| user.email = email.downcase }

  before_save :create_remember_token
  before_create :generate_token

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :email, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
  					format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  

  def createbookshelf! (bookshelfname = "New Bookself", privacy = 2)
    @bookshelf = bookshelves.create!(name: bookshelfname, privacy: privacy)
  end

  def getbookshelves
    Bookshelf.where("user_id = ?", id)
  end

  def contribute!(profile, description = "", admin = false, permission = "view")
    @relationship = relationships.create!(profile_id: profile.id, description: description, profile_admin: false, permission: permission)
    @relationship.toggle!(:profile_admin) if admin 
  end

  def updateRelationship!(profile, description = "")
    @relationship = Relationship.find_by_profile_id(profile.id)
    @relationship.description = description
  end

  def getRelationship(profile)
    relationships.find_by_profile_id(profile.id)
  end

  def actionlog!(profile_id = "", page = "", action = "")
    @useractionlog = useractionlogs.create!(profile_id: profile_id, pages: page, action: action)
  end

  def like?(memory)
    not likememories.blank? and likememories.exists?(memory_id: memory.id)
  end

  def likememory!(memory)
    if likememories.blank? or not likememories.exists?(memory_id: memory.id)
      @likememory = likememories.create!(memory_id: memory.id)
    end
  end

  def unlikememory!(memory)
    if not likememories.blank? and likememories.exists?(memory_id: memory.id)
      likememories.find_by_memory_id(memory.id).destroy 
    end
  end

  def getPermission(profile)
    relationships.find_by_profile_id(profile.id).permission
  end

  def isEditor?(profile_id = "")
    relationships.find_by_profile_id(profile_id).permission == "edit"
  end

  def contributing?(profile)
    relationships.exists?(profile_id: profile.id)
  end

  def canContribute?(profile_id = "")
    if relationships.exists?(profile_id: profile_id)
      relationships.find_by_profile_id(profile_id).permission == "edit" or relationships.find_by_profile_id(profile_id).permission == "contribute"
    else
      false
    end
  end

  def uncontribute!(profile)
    relationships.find_by_profile_id(profile.id).destroy
  end

  def storybook_editor?(profile)
    relationships.find_by_profile_id(profile.id).profile_admin
  end

  def memorycount
    Memory.where("user_id = ?", id).count
  end

  def storybookcount
    Relationship.where("user_id = ?", id).count
  end

  def send_password_reset
    generate_pwd_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!(:validate => false)
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    def generate_token
      self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
    end

    def generate_pwd_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while User.exists?(column => self[column])
    end
end
