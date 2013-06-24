class Bookshelfrelation < ActiveRecord::Base
  attr_accessible :bookshelf_id, :owner, :permission, :user_id

  belongs_to :user
  belongs_to :bookshelf
  validates :bookshelf_id, presence: true
  validates :user_id, presence: true

  validates_inclusion_of :permission, :in => ["edit", "contribute", "view"], :allow_nil => true

  validates_uniqueness_of :bookshelf_id, :scope => :user_id

end

