class AddPayStatusToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :pay_status, :integer, default: 0
  end
end
