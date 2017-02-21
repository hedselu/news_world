class CreateFollowedPeopleNews < ActiveRecord::Migration
  def change
    create_table :followed_people_news, id: false do |t|
      t.integer :followed_person_id
      t.integer :news_id
    end
  end
end
