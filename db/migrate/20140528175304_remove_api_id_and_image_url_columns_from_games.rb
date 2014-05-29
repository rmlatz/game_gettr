class RemoveApiIdAndImageUrlColumnsFromGames < ActiveRecord::Migration
  def change
    remove_column :games, :api_id
    remove_column :games, :image_irl
  end
end
