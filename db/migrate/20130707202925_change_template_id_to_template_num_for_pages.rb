class ChangeTemplateIdToTemplateNumForPages < ActiveRecord::Migration
  def up
  	rename_column :pages, :template_id, :template_num
  end

  def down
  end
end
