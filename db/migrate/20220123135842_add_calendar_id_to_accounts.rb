class AddCalendarIdToAccounts < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :calendar_id, :string
  end
end
