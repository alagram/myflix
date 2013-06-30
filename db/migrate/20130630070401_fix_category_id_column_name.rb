class FixCategoryIdColumnName < ActiveRecord::Migration
  def self.up
    rename_column :video_genres, :category_id, :genre_id
  end

  def self.down
    rename_column :video_genres, :genre_id, :category_id
  end
end
