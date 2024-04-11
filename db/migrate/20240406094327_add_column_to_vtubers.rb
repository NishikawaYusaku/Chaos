class AddColumnToVtubers < ActiveRecord::Migration[7.1]
  def change
    add_column :vtubers, :birthday, :string
    add_column :vtubers, :affiliation, :string
  end
end
