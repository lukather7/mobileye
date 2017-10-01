class AddKindToMicropost < ActiveRecord::Migration[5.0]
  def change
    add_column :microposts, :kind, :string
    add_column :microposts, :lat, :string
    add_column :microposts, :lng, :string
    add_column :microposts, :accuracy, :string
  end
end
