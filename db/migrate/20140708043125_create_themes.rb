class CreateThemes < ActiveRecord::Migration
  def change
    create_table :themes do |t|
      t.text :template, :stylesheet, :script
      t.string :name
      t.integer :user_id

      t.timestamps
    end

    add_column :sites, :template, :text
    add_column :sites, :stylesheet, :text
    add_column :sites, :script, :text
    add_column :sites, :theme_id, :integer
  end
end
