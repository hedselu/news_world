class AddKeywordsToNews < ActiveRecord::Migration
  def change
    add_column :news, :keywords, :string, array: true
  end
end
