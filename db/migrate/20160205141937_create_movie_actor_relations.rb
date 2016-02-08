class CreateMovieActorRelations < ActiveRecord::Migration
  def change
    create_table :actors_movies do |t|
      t.integer :movie_id
      t.integer :actor_id

      t.timestamps
    end
    add_index :actors_movies, [:movie_id, :actor_id]
  end
end
