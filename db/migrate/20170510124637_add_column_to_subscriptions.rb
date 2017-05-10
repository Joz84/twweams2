class AddColumnToSubscriptions < ActiveRecord::Migration[5.0]
  def change
    add_column :subscriptions, :opened_messages, :integer, default: 0
  end
end
