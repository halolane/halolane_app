class AddSubtypeToChapters < ActiveRecord::Migration
  def change
    add_column :chapters, :subtype, :string
  end
end
