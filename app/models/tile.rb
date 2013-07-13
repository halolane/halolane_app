class Tile < ActiveRecord::Base
  attr_accessible :datacol, :datarow, :datasizex, :datasizey, :template_id, :tile_num, :width, :height

  belongs_to :template

  private 
  	def renum_tile_num 
  		@template = Template.find(template_id)
      @tiles_renum = @template.tilelist(self.tile_num)
      new_tile_num = tile_num
      @tiles_renum.each do |t|
        t.update_attributes(:tile_num => new_tile_num)
        new_tile_num = new_tile_num + 1
      end
    end
end
