class AddTimestampsToPosts < ActiveRecord::Migration

  # First argument is table, second is column name, third is type
  def change
    add_column :posts, :created_at, :datetime
    add_column :posts, :updated_at, :datetime
  end
end
