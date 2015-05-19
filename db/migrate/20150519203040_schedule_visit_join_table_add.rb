class ScheduleVisitJoinTableAdd < ActiveRecord::Migration
  def change
    create_table :schedules_visits, id: false do |t|
      t.integer :schedule_id
      t.integer :visit_id
    end
    add_index :schedules_visits, :schedule_id
    add_index :schedules_visits, :visit_id
  end
end
