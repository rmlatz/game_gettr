class CreateAdditions < ActiveRecord::Migration
  def change
    create_table :additions do |t|
      t.references :user
      t.references :game
    end
  end
end
