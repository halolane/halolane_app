# == Schema Information
#
# Table name: memories
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Memory < ActiveRecord::Base
  
  attr_accessible :content, :profile_id, :photo
  has_attached_file :photo

  belongs_to :user
  belongs_to :profile

  validate :content_and_photo_not_blank
  validates :user_id, presence: true  
  validates :profile_id, presence: true
  validates :content, :length => { :maximum => 250 }
  
  validates_attachment :photo,
  :content_type => { :content_type => /image/ },
  :size => { :in => 0..5.megabytes }


  # Sorts it by created_at descending
  default_scope order: 'memories.created_at DESC'

  def self.receive_mail(message)
    @user = User.find_by_email(message.from.first)
    if ! @user.nil?
      url = (message.to.first).split('@').first.split('+').last
      if Profile.exists?(:url => url)

        @profile = Profile.find_by_url(url)
        if @user.contributing?(@profile) && @user.canContribute?(@profile)

          if message.multipart?
            content = message.text_part.body.decoded
          else
            content = message.body.decoded
          end
          @memory = @user.memories.build(:profile_id => @profile.id, :content => content)
          # email_attachments = []   # an array which can be used to store object records of the attachments..

          # Un comment if you expect multiple pictures here
          # message.attachments.each do |attachment|
          if message.attachments.count > 0
            file = StringIO.new(message.attachments[0].decoded)
            file.class.class_eval { attr_accessor :original_filename, :content_type }
            file.original_filename = message.attachments[0].filename
            file.content_type = message.attachments[0].mime_type
            file.content_type
            @memory.photo = file
          end
          # email_attachments << attachment   # adding all attachment objects one by one in the array...
          # end
          
          if @memory.save
            Mailer.receive_email_confirm(message.from.first, message.to.first, "https://www.familytales.co/" + @profile.url).deliver
          else
            Mailer.receive_email_save_error(message.from.first, message.to.first).deliver
          end

        else
          Mailer.receive_email_storybook_error(message.from.first, message.to.first).deliver
        end
      else
        Mailer.receive_email_storybook_error(message.from.first, message.to.first).deliver
      end
    else
      Mailer.receive_email_not_user(message.from.first, message.to.first).deliver
    end

  end

  private

    def content_and_photo_not_blank
      if photo_file_name.nil? and content.blank?
        self.errors.add :base, 'My string can not be nil'
      end
    end

end
