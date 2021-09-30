class AddImageToProperty < ActiveRecord::Migration[6.1]
  def change
    add_column :properties, :image, :string
  end
end
