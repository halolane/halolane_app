class Template < ActiveRecord::Base
  attr_accessible :template_num, :description, :height, :width

  has_many :tiles, dependent: :destroy
  has_many :pages

  def createtile! (tile_num, datarow, datacol, datasizex, datasizey, tile_width, tile_height)
  	if tiles.find_by_tile_num(tile_num).blank?
	  	new_tile_num = tilecount + 1
	  	@tile = tiles.create!(tile_num: new_tile_num, datacol: datacol, datarow: datarow, datasizex: datasizex, datasizey: datasizey, width: tile_width, height: tile_height )
  	else
		  tiles.find_by_tile_num(tile_num).update_attributes(:datacol => datacol, :datarow =>  datarow, :datasizex =>  datasizex, :datasizey =>  datasizey, :width => tile_width, :height => tile_height )
  	end
  end

  def tilecount
    self.tiles.count
  end

  def tilelist (tile_num = nil)
    if tile_num.nil? or tile_num < 1 or tile_num > tilecount
      Tile.where("template_id = ?", id).order(:tile_num)
    else
      Tile.where("template_id = ?", id).where("tile_num > ?", tile_num).order(:tile_num)
    end
  end
end
