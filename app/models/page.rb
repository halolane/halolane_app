class Page < ActiveRecord::Base
  attr_accessible :chapter_id, :page_num, :template_id

  belongs_to :chapter
  belongs_to :template
  has_many :memories, dependent: :destroy
  validates :chapter_id, presence: true

  before_destroy :renum_page_num

private 
	def renum_page_num 
		@chapter = Chapter.find(chapter_id)
    @pages_renum = @chapter.pagelist(page_num)
    new_page_num = page_num
    @pages_renum.each do |pg|
      pg.update_attributes(:page_num => new_page_num)
      new_page_num = new_page_num + 1
    end
  end
end
