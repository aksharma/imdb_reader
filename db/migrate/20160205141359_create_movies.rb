class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :director
      t.string :imdbId
      t.string :plot
      t.float :rating

      t.timestamps
    end
  end
end
