class Bookshelfrelation < ActiveRecord::Base
  attr_accessible :bookshelf_id, :owner, :permission, :user_id
end
