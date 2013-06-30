class RenameCategoriesTableToGenres < ActiveRecord::Migration
  def self.up
    rename_table :categories, :genres
  end

  def self.down
    rename_table :genres, :categories
  end
end
