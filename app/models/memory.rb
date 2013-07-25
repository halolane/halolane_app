# == Schema Information #
# Table name: memories
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Memory < ActiveRecord::Base
  
  attr_accessible :content, :title, :profile_id, :photo, :date, :page_id, :has_photo, :tile_num
  has_attached_file :photo, :styles => Proc.new { |photo| photo.instance.styles }

  belongs_to :user
  belongs_to :profile
  belongs_to :page

  has_one :chapter, through: :pages
  has_many :likememories, dependent: :destroy
  has_many :storycomments, dependent: :destroy
  validate :content_and_photo_not_blank
  validates :user_id, presence: true  
  validates :profile_id, presence: true
  validates_date :date, :after => "1700-01-01",
                :after_message => 'must be a correct date',
                :on_or_before => (Date.today + 2),
                :on_or_before_message => 'must be before today\'s date'
  validates :content, :length => { :maximum => 250, :message => 'Story exceeds 250 characters'}
  validates :title, :length => { :maximum => 140 }
  

  validates_attachment :photo,
  :content_type => { :content_type => /image/ },
  :size => { :in => 0..5.megabytes }


  # Sorts it by created_at descending
  default_scope order: 'memories.date DESC, memories.created_at DESC'

  def numlikes
    self.likememories.count
  end

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
          chapter_id =  @profile.chapterlist.last.id
          @memory = @user.memories.build(:profile_id => @profile.id, :content => content, :chapter_id => chapter_id)
          @memory.date = Date.today
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
            @user.actionlog!(@profile.id, "Memory model", "New story created by email" )
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

  def dynamic_style_format_symbol
    URI.escape(@dynamic_style_format).to_sym
  end

  def styles
    unless @dynamic_style_format.blank?
      { dynamic_style_format_symbol => @dynamic_style_format }
    else
      {}
    end
  end

  def dynamic_photo_url(format)
    @dynamic_style_format = format
    photo.reprocess!(dynamic_style_format_symbol) unless photo.exists?(dynamic_style_format_symbol)
    photo.url(dynamic_style_format_symbol)
  end

  def commentcount()
    storycomments.count()
  end

  private

    def content_and_photo_not_blank
      if photo_file_name.nil? and content.blank?
        self.errors.add :base, 'You did not submit a story or a picture.'
      end
    end

end
