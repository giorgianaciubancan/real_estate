class AddDetailsToAccounts < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :details, :text
  end
end
