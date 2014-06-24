class AddPositionToPages < ActiveRecord::Migration
  def change
    add_column :pages, :position, :integer

    execute "update pages set position = id"
  end
end
