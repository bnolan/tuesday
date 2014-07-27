class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :site_id, :user_id
      t.string :name
      t.text :caption
      t.timestamps
    end

    add_attachment :images, :image
  end
end
