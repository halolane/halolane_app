class AddTemplateNumToPages < ActiveRecord::Migration
  def change
    add_column :pages, :template_num, :integer
  end
end
