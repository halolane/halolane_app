class CreateStorybookQuestions < ActiveRecord::Migration
  def change
    create_table :storybook_questions do |t|
      t.text :question

      t.timestamps
    end
  end
end
