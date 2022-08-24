class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      
      t.integer :user_id 
      t.string  :title,    null: false
      t.text    :body,     null: false 
      t.string  :image,    null: false

      t.timestamps
    end
  end
end
