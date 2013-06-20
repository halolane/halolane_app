class Profile < ActiveRecord::Base
  extend FriendlyId
  friendly_id :url, use: :slugged


  attr_accessible :birthday, :deathday, :first_name, :last_name, :privacy
  belongs_to :bookshelf

  has_many :relationships, dependent: :destroy
  has_many :memories, dependent: :destroy
  has_many :users, through: :relationships
  has_many :invitations, dependent: :destroy
  has_many :chapters, dependent: :destroy

  before_create :setprettyurl

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :url, length: { maximum: 50 }

  validates_date :birthday, :before => :deathday,
                            :before_message => 'must be before date of passing'

  validates_date :birthday, :after => "1700-01-01",
  							:after_message => 'must be a correct date',
  							:on_or_before => Date.today,
  							:on_or_before_message => 'must be a correct date'

  validates_date :deathday, :after => "1700-01-01",
  							:after_message => 'must be a correct date',
  							:on_or_before => Date.today,
  							:on_or_before_message => 'must be a correct date'

  validates_numericality_of :privacy, :greater_than_or_equal_to => 0,
                            :only_integer => true, :allows_nil => false

  def chapterlist(chap_num = nil)
    if chap_num.nil? or chap_num < 1 or chap_num > chaptercount
      Chapter.where("profile_id = ?", id).order(:chapter_num)
    else
      Chapter.where("profile_id = ?", id).where("chapter_num > ?", chap_num).order(:chapter_num)
    end
  end

  def chaptercount
    Chapter.where("profile_id = ?", id).count
  end

  def createchapter! (chapter_name = "New chapter")
    new_chapter_num = chaptercount + 1
    @chapter = chapters.create!(profile_id: id, chapter_name: chapter_name, chapter_num: new_chapter_num)
  end

  def memoryfeed
    Memory.where("profile_id = ?", id)
  end

  def memorycount
    Memory.where("profile_id = ?", id).count
  end

  def photofeed
    Photomemory.where("profile_id = ?", id)
  end
  
  def contributor?(user)
    relationships.find_by_user_id(user.id)
  end

  def changeprivacy(p)
    privacy = p
  end

  def get_vcf_file
    output = ['BEGIN:VCARD']
    output << 'VERSION:3.0'
    output << 'N:' + self.first_name + " " + self.last_name + ';FamilyTales;;;'
    output << 'FN:FamilyTales ' + self.first_name + " " + self.last_name 
    output << 'EMAIL;type=INTERNET;type=HOME;type=pref:story+' + self.url + '@familytales.co'
    output << 'item1.URL;type=pref:www.familytales.co/' + self.url
    output << 'item1.X-ABLabel:_$!<HomePage>!$_'
    output << 'END:VCARD'
    output.join("\n")
  end
  
  private 

    def setprettyurl
      newurl = self.first_name.downcase + self.last_name.downcase
      i = 0
      while Profile.exists?(url: newurl) do
        i = i + 1
        newurl = newurl + i.to_s
      end
      self.url = newurl.gsub(/\s+/, "")
    end 
end

