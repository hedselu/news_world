class CreateFollowedPeople < ActiveRecord::Migration
  def change
    create_table :followed_people do |t|
      t.string :name
    end
  end
end
