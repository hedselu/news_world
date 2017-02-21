class AddPersonSecondName < ActiveRecord::Migration
  def change
    add_column :followed_people, :second_name, :string
    rename_column :followed_people, :name, :first_name
  end
end
