class AddstartTimeToevent < ActiveRecord::Migration
  def change
     add_column :events, :start_time, :timestamps
  end
end
