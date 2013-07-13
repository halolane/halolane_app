class ChangeTemplateNumToTemplateIdForPages < ActiveRecord::Migration
  def up
  	rename_column :pages, :template_num, :template_id
  end

  def down
  end
end
