class ChangeFollowedProfessionsToProfessions < ActiveRecord::Migration
  def change
    rename_table :followed_professions, :professions
    rename_column :followed_people, :followed_profession_id, :profession_id
  end
end
