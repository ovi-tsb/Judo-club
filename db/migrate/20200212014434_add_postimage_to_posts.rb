class AddPostimageToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :postimage, :string
  end
end
