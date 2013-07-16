class AddSubtypeToStorybookquestions < ActiveRecord::Migration
  def change
    add_column :storybook_questions, :subtype, :string
  end
end
