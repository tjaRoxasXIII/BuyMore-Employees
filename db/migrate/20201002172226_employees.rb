class Employees < ActiveRecord::Migration
  def change
    create_table Employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :job_title
      t.date :birthdate
      t.string :username
      t.string :password_digest
      t.integer :store_id
    end
  end
end
