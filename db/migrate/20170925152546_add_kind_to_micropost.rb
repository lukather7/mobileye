class AddKindToMicropost < ActiveRecord::Migration[5.0]
  def change
    add_column :microposts, :kind, :string
  end
end
