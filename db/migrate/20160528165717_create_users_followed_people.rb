class CreateUsersFollowedPeople < ActiveRecord::Migration
  def change
    create_table :users_followed_people, id: false do |t|
      t.integer :user_id
      t.integer :followed_person_id
    end
  end
end
