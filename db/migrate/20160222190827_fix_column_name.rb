class FixColumnName < ActiveRecord::Migration
  def self.up
    rename_column :beers, :style, :old_style
  end

  def self.down
    # rename back if you need or do something else or do nothing
  end
end