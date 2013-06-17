class Chapter < ActiveRecord::Base
  attr_accessible :chapter_name, :chapter_num, :profile_id

  belongs_to :profile
  has_many :memories, dependent: :destroy

  before_destroy :renum_chapter_num

  validates :profile_id, presence: true

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
