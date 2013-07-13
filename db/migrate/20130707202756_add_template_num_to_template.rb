class AddTemplateNumToTemplate < ActiveRecord::Migration
  def change
    add_column :templates, :template_num, :integer
  end
end
