class AddTileNumToStorybookQuestions < ActiveRecord::Migration
  def change
    add_column :storybook_questions, :tile_num, :integer
  end
end
