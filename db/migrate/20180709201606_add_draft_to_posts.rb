class AddDraftToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :draft, :boolean
  end
end