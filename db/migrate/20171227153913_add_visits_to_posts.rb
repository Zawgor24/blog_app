class AddVisitsToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :visits, :integer
  end
end
