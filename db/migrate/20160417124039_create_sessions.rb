class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :token
      t.references :user
      t.datetime :expiration
      t.timestamps null: false
    end
  end
end
