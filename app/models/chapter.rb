class Chapter < ActiveRecord::Base
  attr_accessible :chapter_name, :chapter_num, :profile_id, :subtype

  belongs_to :profile
  has_many :pages, dependent: :destroy
  has_many :memories, through: :pages
  before_destroy :renum_chapter_num

  validates :profile_id, presence: true

  def pagelist (page_num = nil)
    if page_num.nil? or page_num < 1 or page_num > pagecount
      Page.where("chapter_id = ?", id).order(:page_num)
    else
      Page.where("chapter_id = ?", id).where("page_num > ?", page_num).order(:page_num)
    end
  end

  def pagecount
    Page.where("chapter_id = ?", id).count
  end

  def createpage! (template_num = 1)
    new_page_num = pagecount + 1
    begin
      template_id = Template.find_by_template_num(template_num).id
    rescue
      return
    end
    @page = pages.create!(chapter_id: id, page_num: new_page_num, template_id: template_id)
  end

  private 
  	def renum_chapter_num 
  		@profile = Profile.find(profile_id)
      @chapters_renum = @profile.chapterlist(chapter_num)
      new_chapter_num = chapter_num
      @chapters_renum.each do |chp|
        chp.update_attributes(:chapter_num => new_chapter_num)
        new_chapter_num = new_chapter_num + 1
      end
    end
end
