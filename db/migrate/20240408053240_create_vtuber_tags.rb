class CreateVtuberTags < ActiveRecord::Migration[7.1]
  def change
    create_table :vtuber_tags do |t|
      t.references :vtuber, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
    add_index :vtuber_tags, [:vtuber_id, :tag_id], unique: true
  end
end
