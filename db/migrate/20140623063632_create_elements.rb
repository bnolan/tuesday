class CreateElements < ActiveRecord::Migration
  def change
    create_table :elements do |t|
      t.text :content
      t.integer :page_id, :position
      t.string :uuid
      t.timestamps
    end
  end
end
