class CreateFollowedPeopleUsers < ActiveRecord::Migration
  def change
    create_table :followed_people_users do |t|
      t.integer :user_id
      t.integer :followed_person_id
    end
  end
end
