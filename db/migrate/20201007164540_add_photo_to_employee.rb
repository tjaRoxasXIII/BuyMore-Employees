class AddPhotoToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :photo, :img 
  end
end
