class CreateVideoContents < ActiveRecord::Migration[7.0]
  def change
    create_table :video_contents do |t|
      t.string :title
      t.string :thumb_url
      t.text :description
      t.string :video_id
      t.references :trail, null: false, foreign_key: true

      t.timestamps
    end
  end
end
