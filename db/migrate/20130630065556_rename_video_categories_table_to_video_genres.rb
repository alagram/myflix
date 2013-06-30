class RenameVideoCategoriesTableToVideoGenres < ActiveRecord::Migration
  def self.up
    rename_table :video_categories, :video_genres
  end

  def self.down
    rename_table :video_genres, :video_categories
  end
end
