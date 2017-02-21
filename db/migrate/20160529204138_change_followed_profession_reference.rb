class ChangeFollowedProfessionReference < ActiveRecord::Migration
  def change
    remove_column :followed_professions, :followed_professions_id
    add_column :followed_people, :followed_profession_id, :integer
    add_index :followed_professions, :name, unique: true
  end
end
