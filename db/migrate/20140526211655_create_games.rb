class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :api_id
      t.string :title
      t.text :image_irl
    end
  end
end
