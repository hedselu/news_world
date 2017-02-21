class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.boolean :categories_set, default: false
      t.string :role, default: 'user'
      t.timestamps null: false
    end
    add_index :users, :login, unique: true
    add_index :users, :email, unique: true
  end
end
