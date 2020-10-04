class Updates < ActiveRecord::Migration
  def change
    create_table Updates do |t|
      t.string :content
      t.integer :employee_id
      t.timestamps
    end
  end
end
