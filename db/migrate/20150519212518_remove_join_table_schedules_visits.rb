class RemoveJoinTableSchedulesVisits < ActiveRecord::Migration
  def change
    drop_table :schedules_visits
  end
end
