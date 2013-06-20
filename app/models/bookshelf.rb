class Bookshelf < ActiveRecord::Base
  attr_accessible :name, :privacy, :user_id
end
