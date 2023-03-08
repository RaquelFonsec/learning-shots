class CreateTrails < ActiveRecord::Migration[7.0]
  def change
    create_table :trails do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.string :category

      t.timestamps
    end
  end
end
