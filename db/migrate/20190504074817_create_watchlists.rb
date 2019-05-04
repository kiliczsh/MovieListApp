class CreateWatchlists < ActiveRecord::Migration[5.2]
  def change
    create_table :watchlists do |t|
      t.string :title
      t.string :year
      t.string :director
      t.string :genre
      t.string :rating

      t.timestamps
    end
  end
end
