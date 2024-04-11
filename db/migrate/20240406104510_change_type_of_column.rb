class ChangeTypeOfColumn < ActiveRecord::Migration[7.1]
  def change
    remove_column :vtubers, :birthday
    add_column :vtubers, :birthday, :date
  end
end