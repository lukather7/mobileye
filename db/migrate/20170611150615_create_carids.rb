class CreateCarids < ActiveRecord::Migration[5.0]
  def change
    create_table :carids do |t|
      t.string :company
      t.string :number

      t.timestamps
    end
  end
end
