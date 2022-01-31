class AddCompanyToAccounts < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :company, :string
  end
end
