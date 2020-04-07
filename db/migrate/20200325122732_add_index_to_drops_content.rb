class AddIndexToDropsContent < ActiveRecord::Migration[6.0]
  def change
    change_column_null :drops, :content, false, 0
  end
end
