class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :articleUrl
      t.string :status
      t.string :moodMusicURL

      t.timestamps null: false
    end
  end
end
