class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :description
      t.string :title
      t.string :source
      t.string :text
      t.string :image_url
      t.string :publish_date
      t.integer :up_votes, default: 0
      t.integer :down_votes, default: 0
      t.references :category
      t.timestamps null: false
    end
  end
end
