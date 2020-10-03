class Stores < ActiveRecord::Migration
  def change
    create_table Stores do |t|
      t.string :location
      t.string :address
    end
  end
end
