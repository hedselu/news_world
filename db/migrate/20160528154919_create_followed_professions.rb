class CreateFollowedProfessions < ActiveRecord::Migration
  def change
    create_table :followed_professions do |t|
      t.string :name, null: false
      t.references :followed_professions
    end
  end
end
