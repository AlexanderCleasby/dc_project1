class AddOriginalIdToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :original_id, :string
  end
end
