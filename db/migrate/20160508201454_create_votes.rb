class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :news
      t.references :user
      t.boolean :value
      t.timestamps null: false
    end
  end
end
