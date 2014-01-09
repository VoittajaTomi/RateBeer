class Renamestyle < ActiveRecord::Migration
  def up

    rename_column :beers, :style, :old_style

  end

  def down
  end
end
