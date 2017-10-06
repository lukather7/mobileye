class AddAreaToMicropost < ActiveRecord::Migration[5.0]
  def change
    add_column :microposts, :area, :string
  end
end
