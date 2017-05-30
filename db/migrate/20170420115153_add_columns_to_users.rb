class AddColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :alias, :string
    add_reference :users, :channel, foreign_key: true
  end
end
