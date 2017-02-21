class DropUsersFollowedPeople < ActiveRecord::Migration
  def change
    drop_table :users_followed_people
  end
end
