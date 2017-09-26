class CreateMicroposts < ActiveRecord::Migration[5.0]
  def change
    create_table :microposts do |t|
      t.references :carid, index: true, foreign_key: true
      t.text :content

      t.timestamps null: false
      t.index [:carid_id, :created_at]
    end
  end
end
